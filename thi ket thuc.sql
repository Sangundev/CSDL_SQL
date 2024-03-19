create database QL_AMNHAC1
use QL_AMNHAC1
set dateformat dmy

create table NHACSI(
MANS varchar(6) not null  primary key, 
TENNS nvarchar(100)) 

create  table  BAIHAT(
MABH varchar(6) not null  primary key, 
TENBH nvarchar(100), 
NAMST date, 
MANS varchar(6) default  null) 

alter table BAIHAT add constraint FK_NSbh foreign key (MANS)
references NHACSI(MANS)

alter table BAIHAT drop constraint FK_NSbh

create table CASI(
MACS varchar(6) not null  primary key, 
TENCS nvarchar(100)
)

create table THONGTINBIEUDIEN(
MABD varchar(6) not null  primary key,
MABH varchar(6) default  null, 
MACS varchar(6) default  null,
NGAYBD date )

alter table THONGTINBIEUDIEN add constraint FK_BH foreign key (MABH)
references BAIHAT(MABH)

alter table THONGTINBIEUDIEN add constraint FK_MACS foreign key (MACS)
references CASI(MACS)

insert into NHACSI values ('NS01',N'TRỊNH CÔNG SƠN')
insert into NHACSI values ('NS02',N'PHẠM MINH TUẤN ')
insert into NHACSI values ('NS03',N'PHAM HUỲNH ĐIỂU')
insert into NHACSI values ('NS04',N'THẾ HIỂN')

insert into  BAIHAT values ('BH01',N'HẠ TRẮNG ','1961','NS01')
insert into  BAIHAT values ('BH02',N'THUYÈN VÀ BIỂN ','1981','NS03')
insert into  BAIHAT values ('BH03',N'BẾN NHỚ ','1962','NS01')
insert into  BAIHAT values ('BH04',N'NHÁNH LAN RỪNG ','1986','NS04')
insert into  BAIHAT values ('BH05',N'ĐẤT NƯỚC ','1984','NS02')

insert into  CASI values ('CS01',N'QUANG DŨNG ')
insert into  CASI values ('CS02',N'MỸ TÂM ')
insert into  CASI values ('CS03',N'ĐÀM VĨNH HƯNG ')
insert into  CASI values ('CS04',N'QUANG LÝ ')
insert into  CASI values ('CS05',N'THANH THÚY ')

insert into  THONGTINBIEUDIEN values ('01','BH01', 'CS01','2013-02-03')
insert into  THONGTINBIEUDIEN values ('02','BH02', 'CS04','2013-03-08')
insert into  THONGTINBIEUDIEN values ('03','BH04', 'CS01','2013-05-19')
insert into  THONGTINBIEUDIEN values ('04','BH01', 'CS02','2013-12-25')
insert into  THONGTINBIEUDIEN values ('05','BH02', 'CS03','2014-02-03')
insert into  THONGTINBIEUDIEN values ('06','BH02', 'CS01','2014-04-30')
insert into  THONGTINBIEUDIEN values ('07','BH01', 'CS03','2013-04-30')


---- TRUUY VẤN 
a. Tạo truy vấn tìm các bài hát sáng tác sau năm 1975 của nhạc sĩ Phạm Minh Tuấn.
Thông tin hiển thị kết quả gồm: MABH, TENBH, TENNS, NAMST. (1 điểm)

select a.MABH,a.MANS,a.NAMST,a.MANS
from BAIHAT a, NHACSI b
WHERE YEAR(NAMST)<1975 and b.TENNS = N'PHẠM MINH TUẤN'

b. Tạo truy vấn tìm nhạc sĩ sáng tác nhiều ca khúc nhất. Thông tin hiển thị kết quả gồm: MANS, TENNS, SOCAKHUC (
số ca khúc được tính: mỗi lần sáng tác một bài hát được tính là 1 ca khúc) (1 điểm)

select top 1 a.MANS , b.TENNS, count(a.MANS) sock
from BAIHAT a, NHACSI b
WHERE a.MANS=b.MANS 
group by  a.MANS , b.TENNS

c. Tạo truy vấn tìm các ca sĩ chưa biểu diễn 
bài hát nào của nhạc sĩ Trịnh Công Sơn. Thông tin hiển thị kết quả gồm: MACS, TENCS (1 điểm) 

Select distinct d.MACS , b.TENNS
from thongtinbieudien a, nhacsi b , baihat c , casi d
where a.MABH=c.MABH and c.MANS= b.MANS AND d.MACS=a.MACS and b.TENNS not in (N'TRỊNH CÔNG SƠN')


d. Tạo truy vấn thống kê số ca sĩ biểu diễn từng ca khúc trong từng năm. Thông tin hiển thị kế
t quả như sau: (2 điểm)

e. Tạo truy vấn thống kê số lượng bài hát trước và sau năm 1975 và tổng số bài hát. Thông tin hiển thị 
kết quả gồm: TRƯỚC NĂM 1975, SAU NĂM 1975, TỔNG SỐ BÀI HÁT (2 điểm)


cho thông tin nhạc sĩ có nhiều tác phấm nhất 
select a.MANS , b.TENNS, count(a.MANS) sock
from BAIHAT a, NHACSI b
WHERE a.MANS=b.MANS 
group by  a.MANS , b.TENNS

select top 1 a.MANS , b.TENNS, count(a.MANS) sock
from BAIHAT a, NHACSI b
WHERE a.MANS=b.MANS 
group by  a.MANS , b.TENNS