create database DLVN
GO
USE DLVN
create table TINH_TP(
MA_T_TP varchar(3) primary key ,
TEN_T_TP nvarchar(20),
DT float,
DS bigint,
MIEN nvarchar(10))
create table BIENGIOI(
NUOC nvarchar(15),
MA_T_TP varchar(3) foreign key (MA_T_TP) references TINH_TP(MA_T_TP),
primary key (NUOC,MA_T_TP))
create table LANGGIENG(
MA_T_TP varchar(3) foreign key (MA_T_TP) references TINH_TP(MA_T_TP),
LG varchar(3)
primary key (MA_T_TP,LG))
---rang buôc 
alter table TINH add constraint RB1_DS_DT check (DIENTICH > 0 AND DANSO > 0 )
alter table LANGGIENG add constraint RB2_LG check (MATINH <> LG )
alter table TINH add constraint RB1_TENTINH UNIQUE (TENTINH )
alter table MIEN add constraint RB1_TENMIEN UNIQUE (TENMIEN)
alter table NUOC add constraint RB1_TENNUOC UNIQUE (TENNUOC )
---- nhap tay 
insert into TINH_TP values ('AG',N'An Giang', '3406','2142709','Nam')
insert into BIENGIOI values ('CPC','AG')
insert into LANGGIENG values ('AG','DT' )
------
11. Xuất ra tên tỉnh, TP cùng với dân số của tỉnh, TP:
a) Có diện tích >= 5000 Km2
b) Có diện tích >= [input] (SV nhập một số bất kỳ từ bàn phím)
select A.TEN_T_TP,A.DS,A.MIEN
from TINH_TP A
where MIEN = N'BẮC' and a.DT > 5000


select * from TINH_TP

select * from TINH_TP
select TEN_T_TP, DS from TINH_TP where DT >= 500

declare @d_t float;
set @d_t = 2500;
select a.TEN_T_TP, DS 
from TINH_TP a where DT >= @d_t



2. Xuất ra tên tỉnh, TP cùng với diện tích của tỉnh, TP:
a) Thuộc miền Bắc
b) Thuộc miền nào đó (SV nhập một miền bất kỳ từ bàn phím)

select a.TEN_T_TP, a.DT,a.MIEN
from TINH_TP a
where mien = 'nam'

select A.TEN_T_TP,A.DS,A.MIEN
from TINH_TP A
where MIEN = N'BẮC' and a.DT > 5000

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
------c1
select a.TEN_T_TP
from TINH_TP a , LANGGIENG b, TINH_TP C
where a.MA_T_TP=b.MA_T_TP and c.TEN_T_TP=N'Long An' and b.LG=c.MA_T_TP
----- c2 luw lai create view
create view LG_LongAn as
select L.LG from TINH_TP T, LANGGIENG L
where T.MA_T_TP = L.MA_T_TP and T.TEN_T_TP = 'Long An'

select a.TEN_T_TP
from TINH_TP a, LG_LongAn b
where a.MA_T_TP = b.LG
--- goi ra
select * from TinhLG_LongAn

--- c3
create view LG_LongAn1 as
select MA_T_TP,TEN_T_TP from TINH_TP T1, ( select L.LG from TINH_TP T, LANGGIENG L
where T.MA_T_TP = L.MA_T_TP and T.TEN_T_TP = 'Long An') T2
where T1.MA_T_TP = T2.LG

select * from TinhLG_LongAn1

select top 3 TEN_T_TP, (DS/DT) as MĞ_DS from TINH_TP
order by MĞ_DS DESC
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
--13 
select TEN_T_TP from TINH_TP T ,BIENGIOI B
where T.MA_T_TP = B.MA_T_TP
GROUP BY TEN_T_TP
HAVING COUNT(B.MA_T_TP)>=2