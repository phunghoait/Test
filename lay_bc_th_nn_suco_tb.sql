SELECT nhom.donvi_id,nhom.ten_dvql,tongbaoloi.loaihinh_tb,
             nhomnn1.nhom1_capday,nhomnn2.nhom2_khachhang,nhomnn3.nhom3_Modem,nhomnn4.nhom4_khac,nhomnn5.nhom5_batkhakhang,nhomnn6.nhom6_media_net
--(nhomnn1.nhom1_capday+nhomnn2.nhom2_khachhang+nhomnn3.nhom3_Modem+nhomnn4.nhom4_khac+nhomnn5.nhom5_batkhakhang+nhomnn6.nhom6_media_net) as tongsoloi,
            
FROM admin_LCI.donvi nhom
LEFT JOIN ( -- T?ng s? l?i    css_LCI.dbtb_dv tbdv, 
                                 Select d.donvi_id, lh.loaihinh_tb, count(distinct a.baohong_id) tongbaoloi
                 from baohong_LCI.baohong a , baohong_LCI.giaophieu b ,CSS_LCI.db_thuebao d ,
                                            baohong_LCI.nguyennhan e, baohong_LCI.ct_hong f,
                                            css_LCI.dichvu_vt dvvt, css_LCI.loaihinh_tb lh
                 where a.baohong_id = b.baohong_id
                                            and a.thuebao_id =d.thuebao_id
                                            and b.huonggiao_id IN (SELECT huonggiao_id from css_LCI.huonggiao WHERE ttbh_id = 3)
                                            --and d.thuebao_id = tbdv.thuebao_id 
                                            --and tbdv.loaidv_id = 5
                                            and b.phieu_id=e.phieu_id
                                            and e.cthong_id =f.cthong_id
                                            and d.dichvuvt_id = dvvt.dichvuvt_id 
                                            and d.loaitb_id =lh.loaitb_id 
                                            and a.loaitb_id =lh.loaitb_id 
                                            and a.ttbh_id = 6 
                                            and b.ttph_id <> 3  
                                            --AND d.trangthaitb_id = 1  
                                            and a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                                            and a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                                            --and f.loaihong_id in (1,2,3,4,7,11,13,24,5,22,23,8,9,12,21,6,25,29,1,28,26,27)  
                                    group by d.donvi_id,lh.loaihinh_tb
                                    order by d.donvi_id,lh.loaihinh_tb
                    ) tongbaoloi ON nhom.donvi_id = tongbaoloi.DONVI_ID
LEFT JOIN ( -- Nhom nguyen nhan 1
                                 Select d.donvi_id, lh.loaihinh_tb, count(distinct a.baohong_id) nhom1_capday
                 from baohong_LCI.baohong a , baohong_LCI.giaophieu b ,CSS_LCI.db_thuebao d , 
                                            baohong_LCI.nguyennhan e, baohong_LCI.ct_hong f,
                                            css_LCI.dichvu_vt dvvt, css_LCI.loaihinh_tb lh
                 where a.baohong_id = b.baohong_id
                                            and a.thuebao_id =d.thuebao_id
                                            and b.huonggiao_id IN (SELECT huonggiao_id from css_LCI.huonggiao WHERE ttbh_id = 3)
                                            --and d.thuebao_id = tbdv.thuebao_id 
                                            --and tbdv.loaidv_id = 5
                                            and b.phieu_id=e.phieu_id
                                            and e.cthong_id =f.cthong_id
                                            and d.dichvuvt_id = dvvt.dichvuvt_id 
                                            and d.loaitb_id =lh.loaitb_id 
                                            and a.loaitb_id =lh.loaitb_id 
                                            and a.ttbh_id = 6 
                                            and b.ttph_id <> 3  
                                            --AND d.trangthaitb_id = 1  
                                            and a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                                            and a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                                            and f.loaihong_id in (2,3,4,7,11,12,13,24)  
                                    group by d.donvi_id,lh.loaihinh_tb
                                    order by d.donvi_id,lh.loaihinh_tb
                    ) nhomnn1 ON nhom.donvi_id = nhomnn1.DONVI_ID AND tongbaoloi.loaihinh_tb = nhomnn1.loaihinh_tb
LEFT JOIN ( -- Nhom nguyen nhan 2
                                 Select d.donvi_id, lh.loaihinh_tb, count(distinct a.baohong_id) nhom2_khachhang
                 from baohong_LCI.baohong a , baohong_LCI.giaophieu b ,CSS_LCI.db_thuebao d ,
                                            baohong_LCI.nguyennhan e, baohong_LCI.ct_hong f,
                                            css_LCI.dichvu_vt dvvt, css_LCI.loaihinh_tb lh
                 where a.baohong_id = b.baohong_id
                                            and a.thuebao_id =d.thuebao_id
                                            and b.huonggiao_id IN (SELECT huonggiao_id from css_LCI.huonggiao WHERE ttbh_id = 3)
                                            --and d.thuebao_id = tbdv.thuebao_id 
                                            --and tbdv.loaidv_id = 5
                                            and b.phieu_id=e.phieu_id
                                            and e.cthong_id =f.cthong_id
                                            and d.dichvuvt_id = dvvt.dichvuvt_id 
                                            and d.loaitb_id =lh.loaitb_id 
                                            and a.loaitb_id =lh.loaitb_id 
                                            and a.ttbh_id = 6 
                                            and b.ttph_id <> 3  
                                            --AND d.trangthaitb_id = 1  
                                            and a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                                            and a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                                            and f.loaihong_id in (5,22,23,30)
                                    group by d.donvi_id,lh.loaihinh_tb
                                    order by d.donvi_id,lh.loaihinh_tb
                    ) nhomnn2 ON nhom.donvi_id = nhomnn2.DONVI_ID AND tongbaoloi.loaihinh_tb = nhomnn2.loaihinh_tb
LEFT JOIN ( -- Nhom nguyen nhan 3
                                 Select d.donvi_id, lh.loaihinh_tb, count(distinct a.baohong_id) nhom3_Modem
                 from baohong_LCI.baohong a , baohong_LCI.giaophieu b ,CSS_LCI.db_thuebao d ,
                                            baohong_LCI.nguyennhan e, baohong_LCI.ct_hong f,
                                            css_LCI.dichvu_vt dvvt, css_LCI.loaihinh_tb lh
                 where a.baohong_id = b.baohong_id
                                            and a.thuebao_id =d.thuebao_id
                                            and b.huonggiao_id IN (SELECT huonggiao_id from css_LCI.huonggiao WHERE ttbh_id = 3)
                                            --and d.thuebao_id = tbdv.thuebao_id 
                                            --and tbdv.loaidv_id = 5
                                            and b.phieu_id=e.phieu_id
                                            and e.cthong_id =f.cthong_id
                                            and d.dichvuvt_id = dvvt.dichvuvt_id 
                                            and d.loaitb_id =lh.loaitb_id 
                                            and a.loaitb_id =lh.loaitb_id 
                                            and a.ttbh_id = 6 
                                            and b.ttph_id <> 3  
                                            --AND d.trangthaitb_id = 1  
                                            and a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                                            and a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                                            and f.loaihong_id in (8,9,21)
                                    group by d.donvi_id,lh.loaihinh_tb
                                    order by d.donvi_id,lh.loaihinh_tb
                    ) nhomnn3 ON nhom.donvi_id = nhomnn3.DONVI_ID AND tongbaoloi.loaihinh_tb = nhomnn3.loaihinh_tb
LEFT JOIN ( -- Nhom nguyen nhan 4
                                 Select d.donvi_id, lh.loaihinh_tb, count(distinct a.baohong_id) nhom4_khac
                 from baohong_LCI.baohong a , baohong_LCI.giaophieu b ,CSS_LCI.db_thuebao d , 
                                            baohong_LCI.nguyennhan e, baohong_LCI.ct_hong f,
                                            css_LCI.dichvu_vt dvvt, css_LCI.loaihinh_tb lh
                 where a.baohong_id = b.baohong_id
                                            and a.thuebao_id =d.thuebao_id
                                            and b.huonggiao_id IN (SELECT huonggiao_id from css_LCI.huonggiao WHERE ttbh_id = 3)
                                            --and d.thuebao_id = tbdv.thuebao_id 
                                            --and tbdv.loaidv_id = 5
                                            and b.phieu_id=e.phieu_id
                                            and e.cthong_id =f.cthong_id
                                            and d.dichvuvt_id = dvvt.dichvuvt_id 
                                            and d.loaitb_id =lh.loaitb_id 
                                            and a.loaitb_id =lh.loaitb_id 
                                            and a.ttbh_id = 6 
                                            and b.ttph_id <> 3  
                                            --AND d.trangthaitb_id = 1  
                                            and a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                                            and a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                                            and f.loaihong_id in (6,25,29,31,32,33,90)
                                    group by d.donvi_id,lh.loaihinh_tb
                                    order by d.donvi_id,lh.loaihinh_tb
                    ) nhomnn4 ON nhom.donvi_id = nhomnn4.DONVI_ID AND tongbaoloi.loaihinh_tb = nhomnn4.loaihinh_tb
LEFT JOIN ( -- Nhom nguyen nhan 5
                                 Select d.donvi_id, lh.loaihinh_tb, count(distinct a.baohong_id) nhom5_batkhakhang
                 from baohong_LCI.baohong a , baohong_LCI.giaophieu b ,CSS_LCI.db_thuebao d , 
                                            baohong_LCI.nguyennhan e, baohong_LCI.ct_hong f,
                                            css_LCI.dichvu_vt dvvt, css_LCI.loaihinh_tb lh
                 where a.baohong_id = b.baohong_id
                                            and a.thuebao_id =d.thuebao_id
                                            and b.huonggiao_id IN (SELECT huonggiao_id from css_LCI.huonggiao WHERE ttbh_id = 3)
                                            --and d.thuebao_id = tbdv.thuebao_id 
                                            --and tbdv.loaidv_id = 5
                                            and b.phieu_id=e.phieu_id
                                            and e.cthong_id =f.cthong_id
                                            and d.dichvuvt_id = dvvt.dichvuvt_id 
                                            and d.loaitb_id =lh.loaitb_id 
                                            and a.loaitb_id =lh.loaitb_id 
                                            and a.ttbh_id = 6 
                                            and b.ttph_id <> 3  
                                            --AND d.trangthaitb_id = 1  
                                            and a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                                            and a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                                            and f.loaihong_id in (1,28,34)
                                    group by d.donvi_id,lh.loaihinh_tb
                                    order by d.donvi_id,lh.loaihinh_tb
                    ) nhomnn5 ON nhom.donvi_id = nhomnn5.DONVI_ID AND tongbaoloi.loaihinh_tb = nhomnn5.loaihinh_tb
LEFT JOIN ( -- Nhom nguyen nhan 6 css_LCI.dbtb_dv tbdv,
                                 Select d.donvi_id, lh.loaihinh_tb, count(distinct a.baohong_id) nhom6_media_net
                 from baohong_LCI.baohong a , baohong_LCI.giaophieu b ,CSS_LCI.db_thuebao d , 
                                            baohong_LCI.nguyennhan e, baohong_LCI.ct_hong f,
                                            css_LCI.dichvu_vt dvvt, css_LCI.loaihinh_tb lh
                 where a.baohong_id = b.baohong_id
                                            and a.thuebao_id =d.thuebao_id
                                            and b.huonggiao_id IN (SELECT huonggiao_id from css_LCI.huonggiao WHERE ttbh_id = 3)
                                            --and d.thuebao_id = tbdv.thuebao_id 
                                            --and tbdv.loaidv_id = 5
                                            and b.phieu_id=e.phieu_id
                                            and e.cthong_id =f.cthong_id
                                            and d.dichvuvt_id = dvvt.dichvuvt_id 
                                            and d.loaitb_id =lh.loaitb_id 
                                            and a.loaitb_id =lh.loaitb_id 
                                            and a.ttbh_id = 6 
                                            and b.ttph_id <> 3
                                            --AND d.trangthaitb_id = 1  
                                            and a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                                            and a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                                            and f.loaihong_id in (26,27,91)
                                    group by d.donvi_id,lh.loaihinh_tb
                                    order by d.donvi_id,lh.loaihinh_tb
                    ) nhomnn6 ON nhom.donvi_id = nhomnn6.DONVI_ID AND tongbaoloi.loaihinh_tb = nhomnn6.loaihinh_tb
WHERE (NHOM.DONVI_ID>0 AND NHOM.DONVI_ID<9)
ORDER BY nhom.DONVI_ID, tongbaoloi.loaihinh_tb ;
