use DLVN

select A.TEN_T_TP,A.DS,A.MIEN
from TINH_TP A
where MIEN = N'BẮC' and a.DT > 5000

select * from TINH_TP
select TEN_T_TP, DS from TINH_TP where DT >= 500

declare @d_t float;
set @d_t = 200;
select TEN_T_TP, DS from TINH_TP where DT >= @d_t 

select a.TEN_T_TP, a.DT,a.MIEN
from TINH_TP a
where mien = 'nam'

select a.TEN_T_TP ,b.NUOC
from TINH_TP a , BIENGIOI b
where a.MA_T_TP = b.MA_T_TP

select sum(a.dt)/count(a.MA_T_TP) 'dien tich tb'
from TINH_TP a

select a.DS , a.TEN_T_TP
from TINH_TP a
where a.DS > 7000

select a.DS,a.TEN_T_TP
from TINH_TP a
where mien=N'bắc'

select a.TEN_T_TP , b.NUOC 
from TINH_TP a , BIENGIOI b
where a.MA_T_TP = b.MA_T_TP and mien=N'nam'

select a.TEN_T_TP
from TINH_TP a , LANGGIENG b, TINH_TP C
where a.MA_T_TP=b.MA_T_TP and c.TEN_T_TP=N'Long An' and b.LG=c.MA_T_TP

select ten_t_tp, DT
from TINH_TP
where dt>=all(select DT from TINH_TP)

select top 1 with ties a.TEN_T_TP ,count(b.LG) SLTG
from TINH_TP a, LANGGIENG b
where a.MA_T_TP = b.MA_T_TP
group by a.TEN_T_TP
order by SLTG desc

-- ten tinh co dien tich lon t2
select top 1 with ties max(DT) dtt ,TEN_T_TP
from TINH_TP
where DT < (select max(DT) from TINH_TP)
group by TEN_T_TP 
order by dtt desc

-- dt lown t2
select max(DS)
from TINH_TP
where DS < (select max(DS) from TINH_TP)
-- top 2 tinh cos dien tich lown nhat (be nhat bo desc)
select top 2 with ties TEN_T_TP , DT
from TINH_TP
order by DT desc



