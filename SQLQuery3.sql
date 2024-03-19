
create database QLGD
go
use QLGD
go
create table Khoa(
makhoa varchar(8) primary key,
tenkhoa nvarchar (30))

create table Monhoc(
mamh varchar(8) primary key,
tenmh nvarchar(30),
makhoa varchar(8) foreign key (makhoa)references Khoa(makhoa))
create table Giangvien(
magv varchar(8) primary key,
tengv nvarchar(30),
luongcb bigint,
makhoa varchar(8) foreign key (makhoa)references Khoa(makhoa))

create table Giangday(
magv varchar(8) foreign key (magv)references Giangvien(magv),
mamh varchar(8) foreign key (mamh)references Monhoc(mamh),
primary key (magv,mamh) )

insert into Khoa values ('CNTT', N'Công Nghệ Thông Tin')
insert into Khoa values ('QTKD', N'Quản Trị Kinh Doanh')
insert into Khoa values ('KTMT', N'Kiến Trúc Mỹ Thuật')

insert into Monhoc values ('TH1',N'Tin Học 1','CNTT') 
insert into Monhoc values ('CSDL',N'Cơ sở dữ liệu','CNTT') 
insert into Monhoc values ('QT1',N'Quản Trị 1','QTKD') 
insert into Monhoc values ('QT2',N'Quản Trị 2','QTKD') 
insert into Monhoc values ('MT1',N'Mỹ Thuật 1','KTMT') 
insert into Monhoc values ('KT1',N'Kiến Trúc 1','KTMT') 

insert into Giangvien values ('GV1',N'Lê Văn Trung',12000,'CNTT')
insert into Giangvien values ('GV2',N'Nguyễn Bạch Thanh Tùng',14000,'CNTT') 
insert into Giangvien values ('GV3',N'Tạ Hữu Thính',13000,'CNTT') 
insert into Giangvien values ('GV4',N'Lâm Trường Giang',15000,'QTKD')
insert into Giangvien values ('GV5',N'Nguyễn Hoàng Hạc',11000,'QTKD')
insert into Giangvien values ('GV6',N'Nguyễn Văn Hoàng',18000,'KTMT')
insert into Giangvien values ('GV7',N'Nguyễn Chí Trai',14000,'KTMT')

insert into Giangday values ('GV1','TH1')
insert into Giangday values ('GV1','CSDL')
insert into Giangday values ('GV2','TH1')
insert into Giangday values ('GV4','QT1')
insert into Giangday values ('GV4','QT2')
insert into Giangday values ('GV5','QT1')
insert into Giangday values ('GV6','MT1')
insert into Giangday values ('GV7','KT1')




1- Tạo view có tên V1, gồm các field: MaKhoa, TenKhoa, SLMH để thống kê số lượng môn học của Khoa đang quản lý. 
 create view V1 as
 select a.makhoa ,tenkhoa,count(mamh) slmh from khoa a, monhoc b
 where a.makhoa=b.makhoa
 group by a.makhoa,tenkhoa

 select* from V1

2- Tạo view có tên V2, gồm các thông tin: MaKhoa, TenKhoa, SLGV để thống kê số lượng GV của Khoa đang có.
create 
ALTER view V2 as
 select a.makhoa ,tenkhoa,count(c.magv) SLGV from khoa a, monhoc b,giangvien c
 where a.makhoa=b.makhoa and c.makhoa=b.makhoa
 group by a.makhoa,tenkhoa

 select * from V2

3- Tạo view V3 cho biết tên các giảng viên có mức lương cao thứ 2.
ALTER view V3 as
 select top 1 with ties c.tengv ,max(c.luongcb) ML from giangvien c
 where max < (select max(c.luongcb) from giangvien)
 group by c.tengv
 order by ML

 select * from V2