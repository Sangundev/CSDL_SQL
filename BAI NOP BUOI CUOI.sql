create database TH_TP_HCM

use 

create table LANTHI(
	Lanthi  varchar(6) not null primary key, 
	Namthi int ,
	Ynghia nvarchar(100), 
	NgayBatdau date,
	NgayKetthuc date
);

create table CHANGDUA(
	MaCD varchar(6) not null primary key,
	TenCD nvarchar(100),
	DiemXP nvarchar(100),
	DiemVedich nvarchar(100),
	SoKm int,
	Hinhthuc nvarchar(100),
	Thoigianthuong time,
	Thoigiantoida time
);

create table CT_CHANG_LANTHI(
	MaCD varchar(6) not null, 
	Lanthi varchar(6) not null,
	primary key(MaCD,Lanthi)
);

alter table CT_CHANG_LANTHI add constraint FK_CD_LT foreign key(MaCD)
references CHANGDUA(MaCD)
alter table CT_CHANG_LANTHI add constraint FK_CT_LT foreign key(Lanthi)
references LANTHI(Lanthi)

create table NHATAITRO(
	MaNTT varchar(6) not null primary key, 
	TenNTT nvarchar(100),
	DiachiNTT nvarchar(100),
	DienthoaiNTT varchar(12)
)

create table CT_TAITRO(
	Lanthi  varchar(6) not null, 
	MaNTT  varchar(6) not null, 
	SotienTT  bigint
)
alter table CT_TAITRO add constraint FK_TT_LT foreign key(Lanthi)
references LANTHI(Lanthi)
alter table CT_TAITRO add constraint FK_NTT_LT foreign key(MaNTT)
references NHATAITRO(MaNTT)

create table QUOCGIA(
	MaQG varchar(6) not null primary key, 
	TenQG nvarchar(100) not null
)

create table DOI(
	MaDoi varchar(6) not null primary key, 
	TenDoi nvarchar(100) not null,
	MaQG varchar(6) default null
)
alter table DOI add constraint FK_QG_DOI foreign key (MaQG)
references QUOCGIA(MaQG)
create table VDV(
	MaVDV varchar(6) not null primary key, 
	TenVDV nvarchar(100) not null, 
	NgaysinhVDV date, 
	DiachiVDV nvarchar(100),
	ChucvuVDV nvarchar(100), 
	MaDoi varchar(6) default null, 
	MaEkip varchar(6) default null
)
alter table VDV add constraint FK_VDV_DOI foreign key(MaDoi)
references DOI(MaDoi)
alter table VDV add constraint FK_VDV_Ekip foreign key(MaEkip)
references EKIP(MaEkip)

create table EKIP(
	MaEkip varchar(6) not null primary key,
	TenEkip nvarchar(100) ,
	Bacsi nvarchar(100), 
	Taixe nvarchar(100), 
	HLV nvarchar(100)
);

create table DSTHIDAU(
	Lanthi varchar(6) not null,
	MaVDV varchar(6) not null,
	SoAo int
)
alter table DSTHIDAU add constraint FK_LT_DSTD foreign key (Lanthi)
references LANTHI(Lanthi)
alter table DSTHIDAU add constraint FK_VDV_DSTD foreign key (MaVDV)
references VDV(MaVDV)

create table DANGKY(
	Lanthi varchar(6) not null, 
	MaDoi varchar(6) not null, 
	NgayDangky date
)
alter table DANGKY add constraint FK_LT_DK foreign key (Lanthi)
references LANTHI(Lanthi)
alter table DANGKY add constraint FK_MD_DK foreign key (MaDoi)
references DOI(MaDoi)

create table GIAITHUONG(
	MaGT varchar(6) not null primary key, 
	TenGT nvarchar(100),
	Sotien bigint,
	MaCD varchar(6) default null, 
	Lanthi varchar(6) default null,
	MaVDV varchar(6) default null
) 

alter table GIAITHUONG add constraint FK_CD_GT foreign key(MaCD)
references CHANGDUA(MaCD)
alter table GIAITHUONG add constraint FK_LT_GT foreign key(Lanthi)
references LANTHI(Lanthi)
alter table GIAITHUONG add constraint FK_VDV_GT foreign key(MaVDV)
references VDV(MaVDV)

create table THANHTICH(
	MaCD varchar(6) not null, 
	Lanthi varchar(6) not null,
	MaVDV varchar(6) not null, 
	Thoigian time
)

alter table THANHTICH add constraint FK_CD_TT foreign key(MaCD)
references CHANGDUA(MaCD)
alter table THANHTICH add constraint FK_LT_TT foreign key(Lanthi)
references LANTHI(Lanthi)
alter table THANHTICH add constraint FK_VDV_TT foreign key(MaVDV)
references VDV(MaVDV)

-----------------CAI DT CAC REN BUOC TOAN VEN
---------------------NHAP DU LIEU : THEO QUY TAC 1 TRC NH SAU 
--1 QUOCGIA , NHATAITRO,EKIP
---2 CHANDUA ,DOI,LANTHI 
----3 CON LAI

1)	Cho biết cuộc đua xe đạp đã tổ chức được bao nhiêu lần?
select lanthi from LANTHI 

2)	Cho biết lần thi nào có thời gian diễn ra dài nhất (NgàyKetthuc – NgayBatdau)?
select 
from 
where 
3)	Trong các lần thi, nhà tài trợ nào đã tài trợ số tiền nhiều nhất? Thông tin hiển thị: MaNTT, TenNTT, Lanthi, SotienTT.
 select top 1 a.MaNTT,a.tenntt,b.lanthi,b.sotientt
 from NHATAITRO a, CT_TAITRO b
 where a.mantt=b.mantt
 order by b.sotientt desc
4)	Cho biết cuộc đua lần thứ 22 có bao nhiêu chặng?
select a.lanthi , b.tencd
from LANTHI a, CHANGDUA b,CT_CHANG_LANTHI c
where  a.lanthi = c.lanthi and b.macd=c.macd and a.lanthi =22

5)	Có bao nhiêu VĐV tham dự chặn đua lần thứ 22?
select count(a.tenvdv) as VDV
from VDV a, DSTHIDAU b
where a.mavdv=b.mavdv and b.lanthi =22

6)	Hiển thị thông tin các đội tham dự cuộc đua lần thứ 22. Thông tin gồm: MaDoi, TenDoi, TenQG.

select a.madoi, a.tendoi,b.tenqg ,c.lanthi
from doi a,quocgia b , dangky c
where a.maqg=b.maqg and c.madoi=a.madoi and c.lanthi=22

7)	Hiển thị thông tin các êkíp của đội ‘ADC Truyền hình Vĩnh Long’.
select *
from ekip 
where tenekip = N'ADC Truyền hình Vĩnh Long'

8)	Cho biết tổng số tiền thưởng của lần thi thứ 22.
select sum(sotien) stt
from GIAITHUONG
where lanthi=22
9)	Cho biết thông tin của cầu thủ đạt áo vàng (về nhất) chặng thứ nhất của lần thi thứ 22?

select b.mavdv ,b.tenvdv , b.ngaysinhvdv
from giaithuong a, vdv b
where a.mavdv = b.mavdv and a.tenvdv=N'Áo vàng' and a.lanthi =22 

10)	Cho biết thông tin của cầu thủ đạt áo xanh (về nhì) chặng thứ nhất của lần thi thứ 22?

select min(thoigian) stt ,b.TenGT
from THANHTICH a,giaithuong b
where thoigian > (select min(thoigian) from thanhtich) and b.TenGT='Áo xanh'
group by b.TenGT

11)	Liệt kê các VĐV đạt áo đỏ (về nhất) trong các chặng có hình thức là ‘Leo đèo’.
create  view T2 as
select min(Thoigian) as STT ,c.TenGT
from THANHTICH a,CHANGDUA b, giaithuong c
where a.MaCD = b.MaCD and c.MaCD=a.MaCD  and Hinhthuc =N'Leo đèo' and c.TenGT=N'Áo đỏ'
group by c.TenGT

12)	Xếp loại VĐV và êkíp cho chặng đua có MaCD là CD02 của lần thi thứ 22.

select a.MaVDV,a.TenVDV,c.Lanthi
from vdv a,ekip b,thanhtich c
where a.MaEkip=b.MaEkip and a.MaVDV=c.MaVDV and c.MaCD='CD02' and c.Lanthi=22

13)	Hiển thị thông tin VĐV đoạt áo vàng chung cuộc (thời gian nhỏ nhất) của lần thi thứ 22.

select min(thoigian) STT 
from giaithuong a,thanhtich b
where a.MaCD=b.MaCD and a.tengt=N'Áo vàng' and a.Lanthi = 22

14)	Cho biết đội đoạt giải nhất, nhì, ba của lần thi thứ 22.

