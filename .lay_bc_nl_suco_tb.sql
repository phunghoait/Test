SELECT nhom.donvi_id,nhom.ten_dvql,tongbaoloi.loaihinh_tb,tongbaoloi.loaitb_id,tongbaoloi.tongsoloi,lan1.lan1,lan2.lan2,
             lan3.lan3,lan4.lan4,lan5.lan5,lan6.lan6,lan7.lan7,lan8.lan8,
             lan9.lan9,lan10.lan10,lan11.lan11,lan12.lan12,lan13.lan13,lan14.lan14,lan15.lan15,
             (lan16.lan16+lan17.lan17+lan18.lan18+lan19.lan19+lan20.lan20) as lan16trolen
FROM admin_LCI.donvi nhom
LEFT JOIN ( 
               Select c.donvi_id ,lh.loaihinh_tb, lh.loaitb_id, count(DISTINCT a.baohong_id) tongsoloi
                 from baohong_LCI.baohong a , baohong_LCI.giaophieu b ,CSS_LCI.db_thuebao c ,css_LCI.dbtb_dv tbdv,
                                            baohong_LCI.nguyennhan e, baohong_LCI.ct_hong f,
                                            css_LCI.dichvu_vt dvvt, css_LCI.loaihinh_tb lh
                 where a.baohong_id = b.baohong_id
                            and a.thuebao_id =c.thuebao_id
                            and b.huonggiao_id IN (SELECT huonggiao_id from css_LCI.huonggiao WHERE ttbh_id = 3)
                            and b.phieu_id=e.phieu_id
                            and e.cthong_id =f.cthong_id
                            and c.thuebao_id = tbdv.thuebao_id 
                            and tbdv.loaidv_id = 5
                            and c.dichvuvt_id = dvvt.dichvuvt_id 
                            and a.loaitb_id =lh.loaitb_id 
                            and a.ttbh_id = 6
                            and b.ttph_id <> 3
                            --AND c.trangthaitb_id = 1
                            and a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                            and a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                            and a.thuebao_id in (
                                            Select a.thuebao_id From baohong_LCI.baohong a  
                                            WHERE a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                                                        AND a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                                            group by a.thuebao_id
                                            HAVING count(a.thuebao_id) >= 1
                                            )
                            --and a.dichvuvt_id <>2 
                            --and a.loaitb_id not in (9,10,12,76)
                            --and c.trangthaitb_id not in (7,8,9)
                group by c.donvi_id, lh.loaihinh_tb, lh.loaitb_id
                order by c.donvi_id, lh.loaihinh_tb

            ) tongbaoloi ON nhom.donvi_id = tongbaoloi.DONVI_ID
LEFT JOIN (  --- bo : css_LCI.dbtb_dv tbdv,
               Select c.donvi_id ,lh.loaihinh_tb, count(DISTINCT a.thuebao_id) lan1
                    from baohong_LCI.baohong a , baohong_LCI.giaophieu b ,CSS_LCI.db_thuebao c ,
                                            baohong_LCI.nguyennhan e, baohong_LCI.ct_hong f,
                            css_LCI.dichvu_vt dvvt, css_LCI.loaihinh_tb lh
                    where a.baohong_id = b.baohong_id
                         and a.thuebao_id =c.thuebao_id
                         and b.huonggiao_id IN (SELECT huonggiao_id from css_LCI.huonggiao WHERE ttbh_id = 3)
             and b.phieu_id=e.phieu_id
             and e.cthong_id =f.cthong_id
                         --and c.thuebao_id = tbdv.thuebao_id 
                         --and tbdv.loaidv_id =5
                         and c.dichvuvt_id = dvvt.dichvuvt_id 
                         and a.loaitb_id =lh.loaitb_id 
                 and a.ttbh_id = 6
                         and b.ttph_id <> 3
                         --AND c.trangthaitb_id = 1
                         and a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                         and a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                         and a.thuebao_id in (
                                                Select a.thuebao_id From baohong_LCI.baohong a  
                                                WHERE a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                                                            AND a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                                                group by a.thuebao_id
                                                HAVING count(a.thuebao_id) = 1
                                                )
                        --and a.dichvuvt_id <>2 
                        --and a.loaitb_id not in (9,10,12,76)
                        --and c.trangthaitb_id not in (7,8,9)
                group by c.donvi_id, lh.loaihinh_tb
                order by c.donvi_id, lh.loaihinh_tb

            ) lan1 ON nhom.donvi_id = lan1.DONVI_ID AND tongbaoloi.loaihinh_tb = lan1.loaihinh_tb
LEFT JOIN ( 
               Select c.donvi_id ,lh.loaihinh_tb, count(DISTINCT a.thuebao_id) lan2
                    from baohong_LCI.baohong a , baohong_LCI.giaophieu b ,CSS_LCI.db_thuebao c ,
                                            baohong_LCI.nguyennhan e, baohong_LCI.ct_hong f,
                                    css_LCI.dichvu_vt dvvt, css_LCI.loaihinh_tb lh
                    where a.baohong_id = b.baohong_id
                         and a.thuebao_id =c.thuebao_id
                         and b.huonggiao_id IN (SELECT huonggiao_id from css_LCI.huonggiao WHERE ttbh_id = 3)
             and b.phieu_id=e.phieu_id
             and e.cthong_id =f.cthong_id
                         --and c.thuebao_id = tbdv.thuebao_id 
                         --and tbdv.loaidv_id =5
                         and c.dichvuvt_id = dvvt.dichvuvt_id 
                         and a.loaitb_id =lh.loaitb_id 
                         and a.ttbh_id = 6
                         and b.ttph_id <> 3
                         --AND c.trangthaitb_id = 1
                         and a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                         and a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                         and a.thuebao_id in (
                                                Select a.thuebao_id From baohong_LCI.baohong a  
                                                WHERE a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                                                            AND a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                                                group by a.thuebao_id
                                                HAVING count(a.thuebao_id) = 2
                                                )
                        --and a.dichvuvt_id <>2 
                        --and a.loaitb_id not in (9,10,12,76)
                        --and c.trangthaitb_id not in (7,8,9)
            group by c.donvi_id, lh.loaihinh_tb
            order by c.donvi_id, lh.loaihinh_tb

            ) lan2 ON nhom.donvi_id = lan2.DONVI_ID AND tongbaoloi.loaihinh_tb = lan2.loaihinh_tb
LEFT JOIN ( 
               Select c.donvi_id ,lh.loaihinh_tb, count(DISTINCT a.thuebao_id) lan3
                    from baohong_LCI.baohong a , baohong_LCI.giaophieu b ,CSS_LCI.db_thuebao c ,
                                            baohong_LCI.nguyennhan e, baohong_LCI.ct_hong f,
                                css_LCI.dichvu_vt dvvt, css_LCI.loaihinh_tb lh
                    where a.baohong_id = b.baohong_id
                         and a.thuebao_id =c.thuebao_id
                         and b.huonggiao_id IN (SELECT huonggiao_id from css_LCI.huonggiao WHERE ttbh_id = 3)
             and b.phieu_id=e.phieu_id
             and e.cthong_id =f.cthong_id
                         --and c.thuebao_id = tbdv.thuebao_id 
                         --and tbdv.loaidv_id =5
                         and c.dichvuvt_id = dvvt.dichvuvt_id 
                         and a.loaitb_id =lh.loaitb_id 
                         and a.ttbh_id = 6
                         and b.ttph_id <> 3
                         --AND c.trangthaitb_id = 1
                         and a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                         and a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                         and a.thuebao_id in (
                                                Select a.thuebao_id From baohong_LCI.baohong a  
                                                WHERE a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                                                            AND a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                                                group by a.thuebao_id
                                                HAVING count(a.thuebao_id) = 3
                                                )
                        --and a.dichvuvt_id <>2 
                        --and a.loaitb_id not in (9,10,12,76)
                        --and c.trangthaitb_id not in (7,8,9)
            group by c.donvi_id, lh.loaihinh_tb
            order by c.donvi_id, lh.loaihinh_tb

            ) lan3 ON nhom.donvi_id = lan3.DONVI_ID AND tongbaoloi.loaihinh_tb = lan3.loaihinh_tb
LEFT JOIN ( 
               Select c.donvi_id ,lh.loaihinh_tb, count(DISTINCT a.thuebao_id) lan4
                    from baohong_LCI.baohong a , baohong_LCI.giaophieu b ,CSS_LCI.db_thuebao c ,
                                            baohong_LCI.nguyennhan e, baohong_LCI.ct_hong f,
                                css_LCI.dichvu_vt dvvt, css_LCI.loaihinh_tb lh
                    where a.baohong_id = b.baohong_id
                         and a.thuebao_id =c.thuebao_id
                         and b.huonggiao_id IN (SELECT huonggiao_id from css_LCI.huonggiao WHERE ttbh_id = 3)
             and b.phieu_id=e.phieu_id
             and e.cthong_id =f.cthong_id
                         --and c.thuebao_id = tbdv.thuebao_id 
                         --and tbdv.loaidv_id =5
                         and c.dichvuvt_id = dvvt.dichvuvt_id 
                         and a.loaitb_id =lh.loaitb_id 
                         and a.ttbh_id = 6
                         and b.ttph_id <> 3
                         --AND c.trangthaitb_id = 1
                         and a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                         and a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                         and a.thuebao_id in (
                                                Select a.thuebao_id From baohong_LCI.baohong a  
                                                WHERE a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                                                            AND a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                                                group by a.thuebao_id
                                                HAVING count(a.thuebao_id) = 4
                                                )
                        --and a.dichvuvt_id <>2 
                        --and a.loaitb_id not in (9,10,12,76)
                        --and c.trangthaitb_id not in (7,8,9)
            group by c.donvi_id, lh.loaihinh_tb
            order by c.donvi_id, lh.loaihinh_tb

            ) lan4 ON nhom.donvi_id = lan4.DONVI_ID AND tongbaoloi.loaihinh_tb = lan4.loaihinh_tb
LEFT JOIN ( 
               Select c.donvi_id ,lh.loaihinh_tb, count(DISTINCT a.thuebao_id) lan5
                    from baohong_LCI.baohong a , baohong_LCI.giaophieu b ,CSS_LCI.db_thuebao c ,
                                            baohong_LCI.nguyennhan e, baohong_LCI.ct_hong f,
                            css_LCI.dichvu_vt dvvt, css_LCI.loaihinh_tb lh
                    where a.baohong_id = b.baohong_id
                         and a.thuebao_id =c.thuebao_id
                         and b.huonggiao_id IN (SELECT huonggiao_id from css_LCI.huonggiao WHERE ttbh_id = 3)
             and b.phieu_id=e.phieu_id
             and e.cthong_id =f.cthong_id
                         --and c.thuebao_id = tbdv.thuebao_id 
                         --and tbdv.loaidv_id =5
                         and c.dichvuvt_id = dvvt.dichvuvt_id 
                         and a.loaitb_id =lh.loaitb_id 
                         and a.ttbh_id = 6
                         and b.ttph_id <> 3
                         --AND c.trangthaitb_id = 1
                         and a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                         and a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                         and a.thuebao_id in (
                                                Select a.thuebao_id From baohong_LCI.baohong a  
                                                WHERE a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                                                            AND a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                                                group by a.thuebao_id
                                                HAVING count(a.thuebao_id) = 5
                                                )
                            --and a.dichvuvt_id <>2 
                            --and a.loaitb_id not in (9,10,12,76)
                            --and c.trangthaitb_id not in (7,8,9)
                    group by c.donvi_id, lh.loaihinh_tb
                    order by c.donvi_id, lh.loaihinh_tb

                ) lan5 ON nhom.donvi_id = lan5.DONVI_ID AND tongbaoloi.loaihinh_tb = lan5.loaihinh_tb
LEFT JOIN ( 
               Select c.donvi_id ,lh.loaihinh_tb, count(DISTINCT a.thuebao_id) lan6
                    from baohong_LCI.baohong a , baohong_LCI.giaophieu b ,CSS_LCI.db_thuebao c ,
                                            baohong_LCI.nguyennhan e, baohong_LCI.ct_hong f,
                                css_LCI.dichvu_vt dvvt, css_LCI.loaihinh_tb lh
                    where a.baohong_id = b.baohong_id
                         and a.thuebao_id =c.thuebao_id
                         and b.huonggiao_id IN (SELECT huonggiao_id from css_LCI.huonggiao WHERE ttbh_id = 3)
             and b.phieu_id=e.phieu_id
             and e.cthong_id =f.cthong_id
                         --and c.thuebao_id = tbdv.thuebao_id 
                         --and tbdv.loaidv_id =5
                         and c.dichvuvt_id = dvvt.dichvuvt_id 
                         and a.loaitb_id =lh.loaitb_id 
                         and a.ttbh_id = 6
                         and b.ttph_id <> 3
                         --AND c.trangthaitb_id = 1
                         and a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                         and a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                         and a.thuebao_id in (
                                                Select a.thuebao_id From baohong_LCI.baohong a  
                                                WHERE a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                                                            AND a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                                                group by a.thuebao_id
                                                HAVING count(a.thuebao_id) = 6
                                                )
                            --and a.dichvuvt_id <>2 
                            --and a.loaitb_id not in (9,10,12,76)
                            --and c.trangthaitb_id not in (7,8,9)
                    group by c.donvi_id, lh.loaihinh_tb
                    order by c.donvi_id, lh.loaihinh_tb

                ) lan6 ON nhom.donvi_id = lan6.DONVI_ID AND tongbaoloi.loaihinh_tb = lan6.loaihinh_tb
LEFT JOIN ( 
               Select c.donvi_id ,lh.loaihinh_tb, count(distinct a.thuebao_id) lan7
                    from baohong_LCI.baohong a , baohong_LCI.giaophieu b ,CSS_LCI.db_thuebao c ,
                            baohong_LCI.nguyennhan e, baohong_LCI.ct_hong f,
                            css_LCI.dichvu_vt dvvt, css_LCI.loaihinh_tb lh
                    where a.baohong_id = b.baohong_id
                         and a.thuebao_id =c.thuebao_id
                         and b.huonggiao_id IN (SELECT huonggiao_id from css_LCI.huonggiao WHERE ttbh_id = 3)
                         and b.phieu_id=e.phieu_id
                         and e.cthong_id =f.cthong_id
                         --and c.thuebao_id = tbdv.thuebao_id 
                         --and tbdv.loaidv_id =5
                         and c.dichvuvt_id = dvvt.dichvuvt_id 
                         and a.loaitb_id =lh.loaitb_id 
                         and a.ttbh_id = 6
                         and b.ttph_id <> 3
                         --AND c.trangthaitb_id = 1
                         and a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                         and a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                         and a.thuebao_id in (
                                                Select a.thuebao_id From baohong_LCI.baohong a  
                                                WHERE a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                                                            AND a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                                                group by a.thuebao_id
                                                HAVING count(a.thuebao_id) = 7
                                                )
                            --and a.dichvuvt_id <>2 
                            --and a.loaitb_id not in (9,10,12,76)
                            --and c.trangthaitb_id not in (7,8,9)
                    group by c.donvi_id, lh.loaihinh_tb
                    order by c.donvi_id, lh.loaihinh_tb

                ) lan7 ON nhom.donvi_id = lan7.DONVI_ID AND tongbaoloi.loaihinh_tb = lan7.loaihinh_tb
LEFT JOIN ( 
               Select c.donvi_id ,lh.loaihinh_tb, count(distinct a.thuebao_id) lan8
                    from baohong_LCI.baohong a , baohong_LCI.giaophieu b ,CSS_LCI.db_thuebao c ,css_LCI.dbtb_dv tbdv,
                            baohong_LCI.nguyennhan e, baohong_LCI.ct_hong f,
                                css_LCI.dichvu_vt dvvt, css_LCI.loaihinh_tb lh
                    where a.baohong_id = b.baohong_id
                         and a.thuebao_id =c.thuebao_id
                         and b.huonggiao_id IN (SELECT huonggiao_id from css_LCI.huonggiao WHERE ttbh_id = 3)
                         and b.phieu_id=e.phieu_id
                         and e.cthong_id =f.cthong_id
                         and c.thuebao_id = tbdv.thuebao_id 
                         and tbdv.loaidv_id =5
                         and c.dichvuvt_id = dvvt.dichvuvt_id 
                         and a.loaitb_id =lh.loaitb_id 
                         and a.ttbh_id = 6
                         and b.ttph_id <> 3
                         --AND c.trangthaitb_id = 1
                         and a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                         and a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                         and a.thuebao_id in (
                                                Select a.thuebao_id From baohong_LCI.baohong a  
                                                WHERE a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                                                            AND a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                                                group by a.thuebao_id
                                                HAVING count(a.thuebao_id) = 8
                                                )
                            --and a.dichvuvt_id <>2 
                            --and a.loaitb_id not in (9,10,12,76)
                            --and c.trangthaitb_id not in (7,8,9)
                    group by c.donvi_id, lh.loaihinh_tb
                    order by c.donvi_id, lh.loaihinh_tb

                ) lan8 ON nhom.donvi_id = lan8.DONVI_ID AND tongbaoloi.loaihinh_tb = lan8.loaihinh_tb
LEFT JOIN ( 
               Select c.donvi_id ,lh.loaihinh_tb, count(distinct a.thuebao_id) lan9
                    from baohong_LCI.baohong a , baohong_LCI.giaophieu b ,CSS_LCI.db_thuebao c ,css_LCI.dbtb_dv tbdv,
                            baohong_LCI.nguyennhan e, baohong_LCI.ct_hong f,
                                css_LCI.dichvu_vt dvvt, css_LCI.loaihinh_tb lh
                    where a.baohong_id = b.baohong_id
                         and a.thuebao_id =c.thuebao_id
                         and b.huonggiao_id IN (SELECT huonggiao_id from css_LCI.huonggiao WHERE ttbh_id = 3)
                         and b.phieu_id=e.phieu_id
                         and e.cthong_id =f.cthong_id
                         and c.thuebao_id = tbdv.thuebao_id 
                         and tbdv.loaidv_id =5
                         and c.dichvuvt_id = dvvt.dichvuvt_id 
                         and a.loaitb_id =lh.loaitb_id 
                         and a.ttbh_id = 6
                         and b.ttph_id <> 3
                         --AND c.trangthaitb_id = 1
                         and a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                         and a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                         and a.thuebao_id in (
                                                Select a.thuebao_id From baohong_LCI.baohong a  
                                                WHERE a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                                                            AND a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                                                group by a.thuebao_id
                                                HAVING count(a.thuebao_id) = 9
                                                )
                            --and a.dichvuvt_id <>2 
                            --and a.loaitb_id not in (9,10,12,76)
                            --and c.trangthaitb_id not in (7,8,9)
                    group by c.donvi_id, lh.loaihinh_tb
                    order by c.donvi_id, lh.loaihinh_tb

                ) lan9 ON nhom.donvi_id = lan9.DONVI_ID AND tongbaoloi.loaihinh_tb = lan9.loaihinh_tb

LEFT JOIN ( 
               Select c.donvi_id ,lh.loaihinh_tb, count(distinct a.thuebao_id) lan10
                    from baohong_LCI.baohong a , baohong_LCI.giaophieu b ,CSS_LCI.db_thuebao c ,css_LCI.dbtb_dv tbdv,
                            baohong_LCI.nguyennhan e, baohong_LCI.ct_hong f,
                                css_LCI.dichvu_vt dvvt, css_LCI.loaihinh_tb lh
                    where a.baohong_id = b.baohong_id
                         and a.thuebao_id =c.thuebao_id
                         and b.huonggiao_id IN (SELECT huonggiao_id from css_LCI.huonggiao WHERE ttbh_id = 3)
                         and b.phieu_id=e.phieu_id
                         and e.cthong_id =f.cthong_id
                         and c.thuebao_id = tbdv.thuebao_id 
                         and tbdv.loaidv_id =5
                         and c.dichvuvt_id = dvvt.dichvuvt_id 
                         and a.loaitb_id =lh.loaitb_id 
                         and a.ttbh_id = 6
                         and b.ttph_id <> 3
                         --AND c.trangthaitb_id = 1
                         and a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                         and a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                         and a.thuebao_id in (
                                                Select a.thuebao_id From baohong_LCI.baohong a  
                                                WHERE a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                                                            AND a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                                                group by a.thuebao_id
                                                HAVING count(a.thuebao_id) = 10
                                                )
                            --and a.dichvuvt_id <>2 
                            --and a.loaitb_id not in (9,10,12,76)
                            --and c.trangthaitb_id not in (7,8,9)
                    group by c.donvi_id, lh.loaihinh_tb
                    order by c.donvi_id, lh.loaihinh_tb

                ) lan10 ON nhom.donvi_id = lan10.DONVI_ID AND tongbaoloi.loaihinh_tb = lan10.loaihinh_tb
LEFT JOIN ( 
               Select c.donvi_id ,lh.loaihinh_tb, count(distinct a.thuebao_id) lan11
                    from baohong_LCI.baohong a , baohong_LCI.giaophieu b ,CSS_LCI.db_thuebao c ,css_LCI.dbtb_dv tbdv,
                            baohong_LCI.nguyennhan e, baohong_LCI.ct_hong f,
                            css_LCI.dichvu_vt dvvt, css_LCI.loaihinh_tb lh
                    where a.baohong_id = b.baohong_id
                         and a.thuebao_id =c.thuebao_id
                         and b.huonggiao_id IN (SELECT huonggiao_id from css_LCI.huonggiao WHERE ttbh_id = 3)
                         and b.phieu_id=e.phieu_id
                         and e.cthong_id =f.cthong_id
                         and c.thuebao_id = tbdv.thuebao_id 
                         and tbdv.loaidv_id =5
                         and c.dichvuvt_id = dvvt.dichvuvt_id 
                         and a.loaitb_id =lh.loaitb_id 
                         and a.ttbh_id = 6
                         and b.ttph_id <> 3
                         --AND c.trangthaitb_id = 1
                         and a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                         and a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                         and a.thuebao_id in (
                                                Select a.thuebao_id From baohong_LCI.baohong a  
                                                WHERE a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                                                            AND a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                                                group by a.thuebao_id
                                                HAVING count(a.thuebao_id) = 11
                                                )
                            --and a.dichvuvt_id <>2 
                            --and a.loaitb_id not in (9,10,12,76)
                            --and c.trangthaitb_id not in (7,8,9)
                    group by c.donvi_id, lh.loaihinh_tb
                    order by c.donvi_id, lh.loaihinh_tb

                ) lan11 ON nhom.donvi_id = lan11.DONVI_ID AND tongbaoloi.loaihinh_tb = lan11.loaihinh_tb
LEFT JOIN ( 
               Select c.donvi_id ,lh.loaihinh_tb, count(distinct a.thuebao_id) lan12
                    from baohong_LCI.baohong a , baohong_LCI.giaophieu b ,CSS_LCI.db_thuebao c ,css_LCI.dbtb_dv tbdv,
                            baohong_LCI.nguyennhan e, baohong_LCI.ct_hong f,
                                css_LCI.dichvu_vt dvvt, css_LCI.loaihinh_tb lh
                    where a.baohong_id = b.baohong_id
                         and a.thuebao_id =c.thuebao_id
                         and b.huonggiao_id IN (SELECT huonggiao_id from css_LCI.huonggiao WHERE ttbh_id = 3)
                         and b.phieu_id=e.phieu_id
                         and e.cthong_id =f.cthong_id
                         and c.thuebao_id = tbdv.thuebao_id 
                         and tbdv.loaidv_id =5
                         and c.dichvuvt_id = dvvt.dichvuvt_id 
                         and a.loaitb_id =lh.loaitb_id 
                         and a.ttbh_id = 6
                         and b.ttph_id <> 3
                         --AND c.trangthaitb_id = 1
                         and a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                         and a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                         and a.thuebao_id in (
                                                Select a.thuebao_id From baohong_LCI.baohong a  
                                                WHERE a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                                                            AND a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                                                group by a.thuebao_id
                                                HAVING count(a.thuebao_id) = 12
                                                )
                            --and a.dichvuvt_id <>2 
                            --and a.loaitb_id not in (9,10,12,76)
                            --and c.trangthaitb_id not in (7,8,9)
                    group by c.donvi_id, lh.loaihinh_tb
                    order by c.donvi_id, lh.loaihinh_tb
                ) lan12 ON nhom.donvi_id = lan12.DONVI_ID AND tongbaoloi.loaihinh_tb = lan12.loaihinh_tb
LEFT JOIN ( 
               Select c.donvi_id ,lh.loaihinh_tb, count(distinct a.thuebao_id) lan13
                    from baohong_LCI.baohong a , baohong_LCI.giaophieu b ,CSS_LCI.db_thuebao c ,css_LCI.dbtb_dv tbdv,
                            baohong_LCI.nguyennhan e, baohong_LCI.ct_hong f,
                            css_LCI.dichvu_vt dvvt, css_LCI.loaihinh_tb lh
                    where a.baohong_id = b.baohong_id
                         and a.thuebao_id =c.thuebao_id
                         and b.huonggiao_id IN (SELECT huonggiao_id from css_LCI.huonggiao WHERE ttbh_id = 3)
                         and b.phieu_id=e.phieu_id
                         and e.cthong_id =f.cthong_id
                         and c.thuebao_id = tbdv.thuebao_id 
                         and tbdv.loaidv_id =5
                         and c.dichvuvt_id = dvvt.dichvuvt_id 
                         and a.loaitb_id =lh.loaitb_id 
                         and a.ttbh_id = 6
                         and b.ttph_id <> 3
                         --AND c.trangthaitb_id = 1
                         and a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                         and a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                         and a.thuebao_id in (
                                                Select a.thuebao_id From baohong_LCI.baohong a  
                                                WHERE a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                                                            AND a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                                                group by a.thuebao_id
                                                HAVING count(a.thuebao_id) = 13
                                                )
                            --and a.dichvuvt_id <>2 
                            --and a.loaitb_id not in (9,10,12,76)
                            --and c.trangthaitb_id not in (7,8,9)
                    group by c.donvi_id, lh.loaihinh_tb
                    order by c.donvi_id, lh.loaihinh_tb

                ) lan13 ON nhom.donvi_id = lan13.DONVI_ID AND tongbaoloi.loaihinh_tb = lan13.loaihinh_tb
LEFT JOIN ( 
               Select c.donvi_id ,lh.loaihinh_tb, count(distinct a.thuebao_id) lan14
                    from baohong_LCI.baohong a , baohong_LCI.giaophieu b ,CSS_LCI.db_thuebao c ,css_LCI.dbtb_dv tbdv,
                            baohong_LCI.nguyennhan e, baohong_LCI.ct_hong f,
                            css_LCI.dichvu_vt dvvt, css_LCI.loaihinh_tb lh
                    where a.baohong_id = b.baohong_id
                         and a.thuebao_id =c.thuebao_id
                         and b.huonggiao_id IN (SELECT huonggiao_id from css_LCI.huonggiao WHERE ttbh_id = 3)
                         and b.phieu_id=e.phieu_id
                         and e.cthong_id =f.cthong_id
                         and c.thuebao_id = tbdv.thuebao_id 
                         and tbdv.loaidv_id =5
                         and c.dichvuvt_id = dvvt.dichvuvt_id 
                         and a.loaitb_id =lh.loaitb_id 
                         and a.ttbh_id = 6
                         and b.ttph_id <> 3
                         --AND c.trangthaitb_id = 1
                         and a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                         and a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                         and a.thuebao_id in (
                                                Select a.thuebao_id From baohong_LCI.baohong a  
                                                WHERE a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                                                            AND a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                                                group by a.thuebao_id
                                                HAVING count(a.thuebao_id) = 14
                                                )
                            --and a.dichvuvt_id <>2 
                            --and a.loaitb_id not in (9,10,12,76)
                            --and c.trangthaitb_id not in (7,8,9)
                    group by c.donvi_id, lh.loaihinh_tb
                    order by c.donvi_id, lh.loaihinh_tb

                ) lan14 ON nhom.donvi_id = lan14.DONVI_ID AND tongbaoloi.loaihinh_tb = lan14.loaihinh_tb
LEFT JOIN ( 
               Select c.donvi_id ,lh.loaihinh_tb, count(distinct a.thuebao_id) lan15
                    from baohong_LCI.baohong a , baohong_LCI.giaophieu b ,CSS_LCI.db_thuebao c ,css_LCI.dbtb_dv tbdv,
                            baohong_LCI.nguyennhan e, baohong_LCI.ct_hong f,
                            css_LCI.dichvu_vt dvvt, css_LCI.loaihinh_tb lh
                    where a.baohong_id = b.baohong_id
                         and a.thuebao_id =c.thuebao_id
                         and b.huonggiao_id IN (SELECT huonggiao_id from css_LCI.huonggiao WHERE ttbh_id = 3)
                         and b.phieu_id=e.phieu_id
                         and e.cthong_id =f.cthong_id
                         and c.thuebao_id = tbdv.thuebao_id 
                         and tbdv.loaidv_id = 5
                         and c.dichvuvt_id = dvvt.dichvuvt_id 
                         and a.loaitb_id =lh.loaitb_id 
                         and a.ttbh_id = 6
                         and b.ttph_id <> 3
                         --AND c.trangthaitb_id = 1
                         and a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                         and a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                         and a.thuebao_id in (
                                                Select a.thuebao_id From baohong_LCI.baohong a  
                                                WHERE a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                                                            AND a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                                                group by a.thuebao_id
                                                HAVING count(a.thuebao_id) = 15
                                                )
                            --and a.dichvuvt_id <>2 
                            --and a.loaitb_id not in (9,10,12,76)
                            --and c.trangthaitb_id not in (7,8,9)
                    group by c.donvi_id, lh.loaihinh_tb
                    order by c.donvi_id, lh.loaihinh_tb

                ) lan15 ON nhom.donvi_id = lan15.DONVI_ID AND tongbaoloi.loaihinh_tb = lan15.loaihinh_tb
LEFT JOIN ( 
               Select c.donvi_id ,lh.loaihinh_tb, count(distinct a.thuebao_id) lan16
                    from baohong_LCI.baohong a , baohong_LCI.giaophieu b ,CSS_LCI.db_thuebao c ,css_LCI.dbtb_dv tbdv,
                            baohong_LCI.nguyennhan e, baohong_LCI.ct_hong f,
                            css_LCI.dichvu_vt dvvt, css_LCI.loaihinh_tb lh
                    where a.baohong_id = b.baohong_id
                         and a.thuebao_id =c.thuebao_id
                         and b.huonggiao_id IN (SELECT huonggiao_id from css_LCI.huonggiao WHERE ttbh_id = 3)
                         and b.phieu_id=e.phieu_id
                         and e.cthong_id =f.cthong_id
                         and c.thuebao_id = tbdv.thuebao_id 
                         and tbdv.loaidv_id =5
                         and c.dichvuvt_id = dvvt.dichvuvt_id 
                         and a.loaitb_id =lh.loaitb_id 
                         and a.ttbh_id = 6
                         and b.ttph_id <> 3
                         --AND c.trangthaitb_id = 1
                         and a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                         and a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                         and a.thuebao_id in (
                                                Select a.thuebao_id From baohong_LCI.baohong a  
                                                WHERE a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                                                            AND a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                                                group by a.thuebao_id
                                                HAVING count(a.thuebao_id) = 16
                                                )
                            --and a.dichvuvt_id <>2 
                            --and a.loaitb_id not in (9,10,12,76)
                            --and c.trangthaitb_id not in (7,8,9)
                    group by c.donvi_id, lh.loaihinh_tb
                    order by c.donvi_id, lh.loaihinh_tb

                ) lan16 ON nhom.donvi_id = lan16.DONVI_ID AND tongbaoloi.loaihinh_tb = lan16.loaihinh_tb
LEFT JOIN ( 
               Select c.donvi_id ,lh.loaihinh_tb, count(distinct a.thuebao_id) lan17
                    from baohong_LCI.baohong a , baohong_LCI.giaophieu b ,CSS_LCI.db_thuebao c ,css_LCI.dbtb_dv tbdv,
                            css_LCI.dichvu_vt dvvt, css_LCI.loaihinh_tb lh
                    where a.baohong_id = b.baohong_id
                         and a.thuebao_id =c.thuebao_id
                         and b.huonggiao_id IN (SELECT huonggiao_id from css_LCI.huonggiao WHERE ttbh_id = 3)
                         and c.thuebao_id = tbdv.thuebao_id 
                         and tbdv.loaidv_id =5
                         and c.dichvuvt_id = dvvt.dichvuvt_id 
                         and a.loaitb_id =lh.loaitb_id 
                         and a.ttbh_id = 6
                         and b.ttph_id <> 3
                         --AND c.trangthaitb_id = 1
                         and a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                         and a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                         and a.thuebao_id in (
                                                Select a.thuebao_id From baohong_LCI.baohong a  
                                                WHERE a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                                                            AND a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                                                group by a.thuebao_id
                                                HAVING count(a.thuebao_id) = 17
                                                )
                            --and a.dichvuvt_id <>2 
                            --and a.loaitb_id not in (9,10,12,76)
                            --and c.trangthaitb_id not in (7,8,9)
                    group by c.donvi_id, lh.loaihinh_tb
                    order by c.donvi_id, lh.loaihinh_tb

                ) lan17 ON nhom.donvi_id = lan17.DONVI_ID AND tongbaoloi.loaihinh_tb = lan17.loaihinh_tb
LEFT JOIN ( 
               Select c.donvi_id ,lh.loaihinh_tb, count(distinct a.thuebao_id) lan18
                    from baohong_LCI.baohong a , baohong_LCI.giaophieu b ,CSS_LCI.db_thuebao c ,css_LCI.dbtb_dv tbdv,
                            css_LCI.dichvu_vt dvvt, css_LCI.loaihinh_tb lh
                    where a.baohong_id = b.baohong_id
                         and a.thuebao_id =c.thuebao_id
                         and b.huonggiao_id IN (SELECT huonggiao_id from css_LCI.huonggiao WHERE ttbh_id = 3)
                         and c.thuebao_id = tbdv.thuebao_id 
                         and tbdv.loaidv_id =5
                         and c.dichvuvt_id = dvvt.dichvuvt_id 
                         and a.loaitb_id =lh.loaitb_id 
                         and a.ttbh_id = 6
                         and b.ttph_id <> 3
                         --AND c.trangthaitb_id = 1
                         and a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                         and a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                         and a.thuebao_id in (
                                                Select a.thuebao_id From baohong_LCI.baohong a  
                                                WHERE a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                                                            AND a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                                                group by a.thuebao_id
                                                HAVING count(a.thuebao_id) = 18
                                                )
                            --and a.dichvuvt_id <>2 
                            --and a.loaitb_id not in (9,10,12,76)
                            --and c.trangthaitb_id not in (7,8,9)
                    group by c.donvi_id, lh.loaihinh_tb
                    order by c.donvi_id, lh.loaihinh_tb

                ) lan18 ON nhom.donvi_id = lan18.DONVI_ID AND tongbaoloi.loaihinh_tb = lan18.loaihinh_tb

LEFT JOIN ( 
               Select c.donvi_id ,lh.loaihinh_tb, count(distinct a.thuebao_id) lan19
                    from baohong_LCI.baohong a , baohong_LCI.giaophieu b ,CSS_LCI.db_thuebao c ,css_LCI.dbtb_dv tbdv,
                            css_LCI.dichvu_vt dvvt, css_LCI.loaihinh_tb lh
                    where a.baohong_id = b.baohong_id
                         and a.thuebao_id =c.thuebao_id
                         and b.huonggiao_id IN (SELECT huonggiao_id from css_LCI.huonggiao WHERE ttbh_id = 3)
                         and c.thuebao_id = tbdv.thuebao_id 
                         and tbdv.loaidv_id = 5
                         and c.dichvuvt_id = dvvt.dichvuvt_id 
                         and a.loaitb_id =lh.loaitb_id 
                         and a.ttbh_id = 6
                         and b.ttph_id <> 3
                         --AND c.trangthaitb_id = 1
                         and a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                         and a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                         and a.thuebao_id in (
                                                Select a.thuebao_id From baohong_LCI.baohong a  
                                                WHERE a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                                                            AND a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                                                group by a.thuebao_id
                                                HAVING count(a.thuebao_id) = 19
                                                )
                            --and a.dichvuvt_id <>2 
                            --and a.loaitb_id not in (9,10,12,76)
                            --and c.trangthaitb_id not in (7,8,9)
                    group by c.donvi_id, lh.loaihinh_tb
                    order by c.donvi_id, lh.loaihinh_tb

                ) lan19 ON nhom.donvi_id = lan19.DONVI_ID AND tongbaoloi.loaihinh_tb = lan19.loaihinh_tb
LEFT JOIN ( 
               Select c.donvi_id ,lh.loaihinh_tb, count(distinct a.thuebao_id) lan20
                    from baohong_LCI.baohong a , baohong_LCI.giaophieu b ,CSS_LCI.db_thuebao c ,css_LCI.dbtb_dv tbdv,
                            css_LCI.dichvu_vt dvvt, css_LCI.loaihinh_tb lh
                    where a.baohong_id = b.baohong_id
                         and a.thuebao_id =c.thuebao_id
                         and b.huonggiao_id IN (SELECT huonggiao_id from css_LCI.huonggiao WHERE ttbh_id = 3)
                         and c.thuebao_id = tbdv.thuebao_id 
                         and tbdv.loaidv_id = 5
                         and c.dichvuvt_id = dvvt.dichvuvt_id 
                         and a.loaitb_id =lh.loaitb_id 
                         and a.ttbh_id = 6
                         and b.ttph_id <> 3
                         --AND c.trangthaitb_id = 1
                         and a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                         and a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                         and a.thuebao_id in (
                                                Select a.thuebao_id From baohong_LCI.baohong a  
                                                WHERE a.ngay_bh >= TO_DATE('' || vtungay || ' 00:00:00', 'dd/MM/yyyy HH24:MI:SS')
                                                            AND a.ngay_bh <= TO_DATE('' || vdenngay || ' 23:59:59', 'dd/MM/yyyy HH24:MI:SS')
                                                group by a.thuebao_id
                                                HAVING count(a.thuebao_id) = 20
                                                )
                            --and a.dichvuvt_id <>2 
                            --and a.loaitb_id not in (9,10,12,76)
                            --and c.trangthaitb_id not in (7,8,9)
                    group by c.donvi_id, lh.loaihinh_tb
                    order by c.donvi_id, lh.loaihinh_tb

                ) lan20 ON nhom.donvi_id = lan20.DONVI_ID AND tongbaoloi.loaihinh_tb = lan20.loaihinh_tb

WHERE (NHOM.DONVI_ID>0 AND NHOM.DONVI_ID<9)
ORDER BY nhom.DONVI_ID, tongbaoloi.loaihinh_tb
