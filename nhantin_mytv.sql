---- Ban Tin 1
  select vngay, nvl(ptm_ngay,0) ptm_ngay, nvl(ptm_lk_thang,0) ptm_lk_thang, nvl(ptm_thangtruoc,0) ptm_thangtruoc,
               nvl(td_ngay,0) td_ngay, nvl(td_lk_thang,0) td_lk_thang, nvl(td_thangtruoc,0) td_thangtruoc,
               nvl(khoiphuc_ngay,0) khoiphuc_ngay, nvl(khoiphuc_lk_thang,0) khoiphuc_lk_thang, nvl(khoiphuc_thangtruoc,0) khoiphuc_thangtruoc,
               nvl(huy_ngay,0) huy_ngay, nvl(huy_lk_thang,0) huy_lk_thang, nvl(huy_thangtruoc,0) huy_thangtruoc,
               nvl(sl_hoatdong,0) sl_hoatdong, nvl(sl_hd_thangtruoc,0) sl_hd_thangtruoc, nvl(sl_hd_namtruoc,0) sl_hd_namtruoc,
               4 dichvuvt_id, 61 loaitb_id, sysdate ngay_cn
        from ( --Phat trien moi trong ngay, thang
               Select sum(case when trunc(a.ngay_ins) = trunc(vngay) then 1 else 0 end) ptm_ngay,   -- Phat trien moi trong ngay
                    sum(case when to_char(ngay_ins,'yyyyMM') = to_char(vngay,'yyyyMM') and trunc(a.ngay_ins) <= trunc(vngay) then 1 else 0 end) ptm_lk_thang,  --phat trien moi luy ke trong thang
                    sum(case when to_char(ngay_ins,'yyyyMM') = to_char(ADD_MONTHS(vngay,-1),'yyyyMM') and trunc(a.ngay_ins) <= add_months(trunc(vngay),-1)  then 1 else 0 end) ptm_thangtruoc   -- ptm cung ky thang truoc
               From hd_thuebao a
               where a.loaitb_id = 61
                    and a.tthd_id = 6
                    and a.kieuld_id in (select kieuld_id from kieu_ld where loaihd_id = 1)
                    and to_char(ngay_ins,'yyyyMM') >= to_char(ADD_MONTHS(vngay,-1),'yyyyMM')
                    and to_char(ngay_ins,'yyyyMM') <= to_char(vngay,'yyyyMM')
                    and trunc(a.ngay_ins) <= trunc(vngay)   -- luy ke toi ngay nhan tin
             ) ptm,
             -- tam ngung trong ngay, thang
             (select  sum(case when kieu_yc = 1 and trunc(a.ngay_ins) = trunc(vngay) then 1 else 0 end) td_ngay,
                    sum(case when kieu_yc = 1 and to_char(ngay_ins,'yyyyMM') = to_char(vngay,'yyyyMM') and trunc(a.ngay_ins) <= trunc(vngay) then 1 else 0 end) td_lk_thang,  --khoiphuc luy ke trong thang
                    sum(case when kieu_yc = 1 and to_char(ngay_ins,'yyyyMM') = to_char(ADD_MONTHS(vngay,-1),'yyyyMM') and trunc(a.ngay_ins) <= add_months(trunc(vngay),-1)  then 1 else 0 end) td_thangtruoc,   -- tam dung cung ky thang truoc

                    sum(case when kieu_yc = 0 and trunc(a.ngay_ins) = trunc(vngay) then 1 else 0 end) khoiphuc_ngay,
                    sum(case when kieu_yc = 0 and to_char(ngay_ins,'yyyyMM') = to_char(vngay,'yyyyMM') and trunc(a.ngay_ins) <= trunc(vngay) then 1 else 0 end) khoiphuc_lk_thang,  --khoiphuc luy ke trong thang
                    sum(case when kieu_yc = 0 and to_char(ngay_ins,'yyyyMM') = to_char(ADD_MONTHS(vngay,-1),'yyyyMM') and trunc(a.ngay_ins) <= add_months(trunc(vngay),-1)  then 1 else 0 end) khoiphuc_thangtruoc   -- tam dung cung ky thang truoc

              from (  Select distinct a.thuebao_id, a.ma_tb, b.kieu_yc, trunc(a.ngay_ins) ngay_ins
                      from hd_thuebao a, dangky_dvgt b, dichvu_gt c
                      where a.hdtb_id =b.hdtb_id
                            and b.dichvugt_id = c.dichvugt_id
                            and c.trangthaitb_id in (2,3,4,5,6)
                            and a.loaitb_id = 61
                            and a.tthd_id = 6
                            and a.kieuld_id in (select kieuld_id from kieu_ld where loaihd_id = 7)
                            and to_char(ngay_ins,'yyyyMM') >= to_char(ADD_MONTHS(vngay,-1),'yyyyMM')
                            and to_char(ngay_ins,'yyyyMM') <= to_char(vngay,'yyyyMM')
                            and trunc(a.ngay_ins) <= trunc(vngay)   -- luy ke toi ngay nhan tin
                   ) a
             ) td,
             ( --Huy trong ngay, thang
               Select  sum(case when trunc(a.ngay_ins) = trunc(vngay) then 1 else 0 end) huy_ngay,   -- huy trong ngay
                    sum(case when to_char(ngay_ins,'yyyyMM') = to_char(vngay,'yyyyMM') and trunc(a.ngay_ins) <= trunc(vngay) then 1 else 0 end) huy_lk_thang,  --Huy  luy ke trong thang
                    sum(case when to_char(ngay_ins,'yyyyMM') = to_char(ADD_MONTHS(vngay,-1),'yyyyMM') and trunc(a.ngay_ins) <= add_months(trunc(vngay),-1)  then 1 else 0 end) huy_thangtruoc   -- huy cung ky thang truoc
               From hd_thuebao a
               where a.loaitb_id = 61
                    and a.tthd_id = 6
                    and a.kieuld_id in (select kieuld_id from kieu_ld where loaihd_id = 4)
                    and to_char(ngay_ins,'yyyyMM') >= to_char(ADD_MONTHS(vngay,-1),'yyyyMM')
                    and to_char(ngay_ins,'yyyyMM') <= to_char(vngay,'yyyyMM')
                    and trunc(a.ngay_ins) <= trunc(vngay)   -- luy ke toi ngay nhan tin
             ) huy,
             ( -- Hoat dong
              Select count(*) sl_hoatdong,
                    nhantin_lay_sl_tb_thang(to_char(ADD_MONTHS(vngay,-1),'yyyyMM')||'01',61,1) sl_hd_thangtruoc,    -- thang truoc
                    nhantin_lay_sl_tb_thang(to_number(to_char(vngay,'yyyy'))-1||'1201',61,1) sl_hd_namtruoc    -- nam truoc
              From db_thuebao a
              where loaitb_id = 61
                    and trangthaitb_id = 1
                    and trunc(nvl(a.ngay_sd,vngay)) <= trunc(vngay)
             ) hd;
             
---------- Ban tin 2
  Select ngay, tong_ptm, KoSTB_chuan, KoSTB_nangcao,KoSTB_vip,
                STB_chuan, STB_nangcao,STB_vip, mytv_kem_fiber_moi, mytv_tren_fiber_hhuu,
                goi_hangthang, goi_6thang, goi_12thang, goi_khac,  ngay_cn, nam.ptm_nam, nam.ptm_thang
         from (  Select vngay ngay, count(*) tong_ptm,
                          sum(case when b.trangbi_id = 7 and c.matocdo = 'VASC011' then 1 else 0 end)  KoSTB_chuan,
                          sum(case when b.trangbi_id = 7 and c.matocdo = 'MYTV006' then 1 else 0 end)  KoSTB_nangcao,
                          sum(case when b.trangbi_id = 7 and c.matocdo = 'MYTV008' then 1 else 0 end)  KoSTB_vip,
                          sum(case when nvl(b.trangbi_id,0) <> 7 and c.matocdo = 'VASC011' then 1 else 0 end)  STB_chuan,
                          sum(case when nvl(b.trangbi_id,0) <> 7 and c.matocdo = 'MYTV006' then 1 else 0 end)  STB_nangcao,
                          sum(case when nvl(b.trangbi_id,0) <> 7 and c.matocdo = 'MYTV008' then 1 else 0 end)  STB_vip,
                          sum(case when kld.kieu = 1  then 1 else 0 end)  mytv_kem_fiber_moi,  -- Mytv lap kem fiber
                          sum(case when kld.kieu = 2  then 1 else 0 end)  mytv_tren_fiber_hhuu,  -- Mytv lap tren fiber co san
                          sum(case when nvl(tt.huong_dc,0) = 0 then 1 else 0 end) goi_hangthang,
                          sum(case when tt.huong_dc =6 then 1 else 0 end) goi_6thang,
                          sum(case when tt.huong_dc =12 then 1 else 0 end) goi_12thang,
                          sum(case when nvl(tt.huong_dc,0) not in (6,12) and nvl(tt.huong_dc,0) > 0 then 1 else 0 end) goi_khac,
                          sysdate ngay_cn
                   From hd_thuebao a, hdtb_adsl b, tocdo_adsl c,
                          (select kieuld_id, kieu
                           from kieu_ld
                           where kieuld_id in (select kieuld_id from kieu_ld_lhtb where loaitb_id = 61)
                              and kieuld_id in (select kieuld_id from kieuld_lhtb where loaitb_id = 58)
                              and loaihd_id = 1
                              and kieu in (1,2)
                          ) kld,
                         (select thuebao_id, max(huong_dc) huong_dc
                          from (select distinct  a.thuebao_id, c.huong_dc
                               from hd_thuebao a, khuyenmai_hdtb b, ct_khuyenmai c
                               where a.hdtb_id = b.hdtb_id
                                  and b.chitietkm_id = c.chitietkm_id
                                  and c.huong_dc > 0
                                  and a.tthd_id = 6
                                  and b.kieu_yc = 1
                                  and trunc(nvl(a.ngay_ins, a.ngay_ht)) = trunc(vngay)   -- ngay bao cao
                               union
                               select distinct a.thuebao_id, c.huong_dc
                               from hd_thuebao a, hdtb_datcoc b, ct_khuyenmai c
                               where a.hdtb_id = b.hdtb_id
                                  and b.chitietkm_id = c.chitietkm_id
                                  and c.huong_dc > 0
                                  and a.tthd_id = 6
                                  and a.kieuld_id= 550
                                  and trunc(nvl(a.ngay_ins, a.ngay_ht)) = trunc(vngay)   -- ngay bao cao
                              )
                           group by thuebao_id
                          ) tt
                   where a.loaitb_id = 61
                          and a.hdtb_id = b.hdtb_id
                          and b.tocdo_id = c.tocdo_id
                          and a.kieuld_id = kld.kieuld_id(+)
                          and a.thuebao_id = tt.thuebao_id(+)
                          and a.tthd_id = 6
                          and a.kieuld_id in (select kieuld_id from kieu_ld where loaihd_id = 1)
                          and trunc(a.ngay_ins) = trunc(vngay)   -- ngay bao cao
              ) ngay,
              (Select  count(*) ptm_nam,
                    sum(case when to_char(ngay_ins,'yyyyMM') = to_char(vngay,'yyyyMM') then 1 else 0 end) ptm_thang
               From hd_thuebao a
               where a.loaitb_id = 61
                    and a.tthd_id = 6
                    and a.kieuld_id in (select kieuld_id from kieu_ld where loaihd_id = 1)
                    and to_char(ngay_ins,'yyyy') = to_char(vngay,'yyyy')
                    and trunc(a.ngay_ins) <= trunc(vngay)   -- luy ke toi ngay nhan tin
              ) nam ;
                    
