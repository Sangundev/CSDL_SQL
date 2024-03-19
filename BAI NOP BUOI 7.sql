create database QL_NS
use QL_NS

set dateformat dmy

create table PHONGBAN(
	MaPB varchar(6) not null primary key, 
	TenPB nvarchar(100), 
	DienthoaiPB nvarchar(12))

 create table CHUCVU(
	 MaCV varchar(6) not null primary key, 
	 TenCV nvarchar(100), 
	 HesoLuong int , 
	 PhucapCV int )

create table QDCV(
	SoQDCV varchar(6) not null,
	NgayQDCV date, 
	MaCV varchar(6) not null
	primary key(MaCV,SoQDCV))

alter table QDCV add constraint FK_QDCV foreign key(MaCV)
references CHUCVU(MaCV);

create table NV(
	MaNV varchar(6) not null primary key,
	HotenNV nvarchar(100) not null, 
	NgaysinhNV date, 
	DiachiNV nvarchar(100), 
	DienthoaiNV varchar(12), 
	gioitinh nvarchar(5) not null,
	tuoi varchar(3) not null,
	MaPB varchar(6) default null,
	MaCV varchar(6) default null)

alter table NV add constraint FK_NV foreign key(MaPB)
references PHONGBAN(MaPB);
alter table NV add constraint FK_CV foreign key(MaCV)
references CHUCVU(MaCV);

create table QDTD(
	SoQDTD varchar(6) not null, 
	MaNV varchar(6) not null, 
	NgayQDTD  date,
	TgianThuviec varchar(12), 
	LuongThuviec bigint, 
	Noidung nvarchar(100)
	primary key(SoQDTD,MaNV))

alter table QDTD add constraint FK_QTNV foreign key(MaNV)
references NV(MaNV);

create table HOPDONG(
	SoHD varchar(6) not null primary key , 
	NgaykyHD date, 
	MaNV varchar(6) default null, 
	MaLoaiHD varchar(6) default null)

alter table HOPDONG add constraint FK_HD_NV foreign key(MaNV)
references NV(MaNV);

 create table LOAIHD(
	 MaLoaiHD varchar(6) not null primary key, 
	 TenLoaiHD nvarchar(100), 
	 ThoihanHD nvarchar(100))

 alter table HOPDONG add constraint FK_HD_ML foreign key(MaLoaiHD)
references LOAIHD(MaLoaiHD);

 create table QDLUONG(
	 SoQDL varchar(6) not null primary key, 
	 NgayQDL date, 
	 MucLCB nvarchar(100),
	 MaNV varchar(6) default null)

alter table QDLUONG add constraint FK_QDLUONG foreign key(MaNV)
references NV(MaNV);

create table PHUCAP(
	MaPC varchar(6) not null primary key, 
	TenPC nvarchar(100))

create table CT_PC_QDL(
	MaPC varchar(6) not null, 
	SoQDL varchar(6) not null
	primary key(SoQDL,MaPC))

alter table CT_PC_QDL add constraint FK_CT_PC foreign key(MaPC)
references PHUCAP(MaPC);
alter table CT_PC_QDL add constraint FK_CT_QDL foreign key(SoQDL)
references QDLUONG(SoQDL);

create table BCC(
	MaBCC varchar(6) not null primary key, 
	TuNgay date, 
	DenNgay date)

create table CT_BCC_NV(
	MaBCC varchar(6) not null,
	MaNV varchar(6) not null
	primary key(MaBCC,MaNV))

alter table CT_BCC_NV add constraint FK_CT_BCC_NV foreign key(MaBCC)
references BCC(MaBCC);
alter table CT_BCC_NV add constraint FK_CT_NV foreign key(MaNV)
references NV(MaNV);

create table PHIEUPT(
	SoPPT varchar(6) not null primary key, 
	NgayPT date, 
	HinhthucPT varchar(100))

create table CT_PPT_NV(
	SoPPT varchar(6) not null, 
	MaNV varchar(6) not null
	primary key(SoPPT,MaNV))

alter table CT_PPT_NV add constraint FK_CT_PPT_NV foreign key(SoPPT)
references PHIEUPT(SoPPT);
alter table CT_PPT_NV add constraint FK_PTT_NV foreign key(MaNV)
references NV(MaNV);
 ----------------- cai dat rang buôc -----------------------------------------------------------------
 alter table TINH add constraint RB1_DS_DT check (DIENTICH > 0 AND DANSO > 0 )
alter table LANGGIENG add constraint RB2_LG check (MATINH <> LG )
alter table TINH add constraint RB1_TENTINH UNIQUE (TENTINH )
alter table MIEN add constraint RB1_TENMIEN UNIQUE (TENMIEN)
alter table NUOC add constraint RB1_TENNUOC UNIQUE (TENNUOC )
---------- nhap du lieu 1 truoc nhieu sau 
--1 chucvu,loaihd,QDLUONG,PHUCAP,PHONGBAN,BCC,PHIEUPT
---2 NV
-----3 CON LAI

---------------------THAO TAC TREN SQL----------------------------
1)	Hiện tại công ty có bao nhiêu nhân viên?
select COUNT(MANV) SNV from NV
2)	Cho biết tổng số phòng ban của công ty?
select count(MAPB) TPB from phongban
3)	Liệt kê danh sách các nhân viên công tác tại công ty >= 3 năm.
select 
from NV a, QDTD b
where a.manv = b.manv and year()
4)	Liệt kê toàn bộ nhân viên và hệ số lương hiện tại thuộc tất cả các phòng ban, 
danh sách được sắp xếp giảm dần theo hệ số lương và tăng dần theo tên nhân viên.
select a.hotennv , b.hesoluong, c.tenpb
from NV a,CHUCVU b,PHONGBAN c
where a.macv=b.macv and a.mapb=c.mapb
order by b.hesoluong desc
5)	Hiển thị danh sách họ tên các nhân viên nữ cùng hệ số lương tương ứng
ở tất cả các phòng ban có trình độ Đại học và đã là Đảng viên.

6)	Hiển thị danh sách các nhân viên có hệ số lương >= 3 của phòng ‘Kế hoạch Tài chính’.

select a.manv,a.hotennv ,b.hesoluong
from NV a , CHUCVU b , PHONGBAN c
where a.macv=b.macv and a.mapb=c.mapb and c.tenpb = N'Kế hoạch Tài chính'and b.hesoluong > 3

7)	Liệt kê họ tên nhân viên, ngày sinh, giới tính có địa chỉ ở ‘TP.HCM’.

select a.hotennv,a.ngaysinhnv,a.gioitinh
from nv a
where a.DiachiNV not in ('%TP.HCM%')

8)	Hiển thị danh sách các trưởng phòng của công ty.

select a.hotennv , b.tencv
from nv a, chucvu b
where a.macv=b.macv and b.tencv='trưởng phòng'

9)	Liệt kê danh sách nhân viên đến tuối chờ nghỉ hưu (Nam >= 60, Nữ >= 55).
create view T1 as
select a.hotennv,a.tuoi
from nv a
where a.gioitinh = N'Nam' and a.tuoi >= 60 

create view T2 as
select a.hotennv,a.tuoi from nv a
where a.gioitinh = N'Nữ' and a.tuoi >= 55 

select* from T1 , T2

10)	Thống kê sĩ số NV của từng phòng ban tính đến thời điểm hiện tại.
select b.tenpb , count(a.manv) stt 
from NV a ,PHONGBAN b
where  a.mapb=b.mapb
group by b.tenpb

11)	Liệt kê quá trình công tác của nhân viên ‘Nguyễn Văn A’ sắp xếp theo thời gian tăng dần.

select 
from 
where 

12)	Liệt kê họ tên các nhân viên đã hoặc đang đảm nhiệm chức vụ ‘Phó phòng’.

select a.hotennv,b.tencv
from NV a, CHUCVU b 
where a.macv=b.macv and b.tencv = 'Phó phòng'

13)	Liệt kê danh sách các nhân viên và số lần ký hợp đồng tương ứng. 
Thông tin hiển thị: Họ tên, Số lần ký HĐ.

select a.hotennv,count(sohd) slk
from NV a,HOPDONG b
where a.manv=b.manv
group by a.hotennv

14)	Hiển thị danh sách nhân viên sắp hết hạn hợp đồng 
(dựa vào NgaykyHD và ThoihanHD, <= 30 ngày so với ngày hiện tại).

select a.hotennv
from NV a, HOPDONG b , LOAIHD c
where a.manv = b.manv and b.MaLoaiHD=c.MaLoaiHD and 

15)	Cho biết nhân viên có MucLCB cao nhất của công ty.

select top 1 a.hotennv , b.MucLCB
from NV a, QDLUONG b
where a.manv=b.manv
order by b.muclcb

16)	Tính lương NV theo tháng, năm.



17)	Hiển thị danh sách bảng lương của toàn bộ NV trong tháng 10/2010.

select a.hotennv , b.MucLCB
from NV a, QDLUONG b
where a.manv=b.manv and month(NgayQDL)=10 and year(NgayQDL)=2010

18)	Liệt kê các phiếu phụ trội của tất cả NV trong tháng 10/2010.
