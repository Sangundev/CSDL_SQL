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

----
--1- Tạo view có tên V1, gồm các 
---field: MaKhoa, TenKhoa, SLMH để thống kê số 
----lượng môn học của Khoa đang quản lý. 
create view V1 as
select a.MaKhoa,a. TenKhoa, count(b.mamh) SLMH
from khoa a, monhoc b
where a.makhoa=b.makhoa
group by a.MaKhoa,a. TenKhoa

select * from V1
--2- Tạo view có tên V2, gồm các thông tin:
---MaKhoa, TenKhoa, SLGV 
---để thống kê số lượng GV của Khoa đang có.
create view V2 as
select a.maKhoa, a.TenKhoa,count(b.magv) SLGV
from khoa a , giangvien b
where a.makhoa=b.makhoa 
group by a.maKhoa, a.TenKhoa

select * from V2
--3- Tạo view V3 cho biết tên các giảng viên 
---có mức lương cao thứ 2.
create view V3 as
select top 1 with ties tengv ,max(luongcb) LCB
from Giangvien
where luongcb < (select max(luongcb) from Giangvien)
group by tengv
order by max(luongcb) desc

select * from V3

-- proc
--3- Tạo stored procedure P1 sử dụng cursor 
---để cho biết danh sách các môn học 
----của một khoa với mã khoa là tham số truyền vào.
create 
alter proc P1 @ma nvarchar(30) output
as
select tenmh from monhoc a, khoa b 
                           where a.makhoa=b.makhoa and a.makhoa in(
						   select makhoa from khoa where makhoa=@ma)
exec P1 'CNTT'


--4. Tạo stored procedure P2 với mã GV là tham số truyền vào, 
---tham số trả về là danh sách GV cùng tham gia giảng dạy 
----các môn học với GV có tham số truyền vào(magv)

create
alter proc P2 @ma nvarchar(7) 
as
select a.magv , a.tengv ,b.mamh from giangvien a , Giangday b 
								where a.magv=b.magv and b.mamh in 
						(select mamh from Giangday where magv=@ma)
						and a.magv<>@ma
exec P2 'GV1'

--5- Tạo function F1 để cho biết tên khoa phụ trách một môn 
---học với mã môn học là tham số truyền vào.

create function F1 (@ma nvarchar(6))
returns table
as
return (select a.tenkhoa from khoa a,monhoc b where a.makhoa=b.makhoa
and b.mamh in (select mamh from monhoc where mamh=@ma ))

select* from F1 ('TH1')
---6- Tạo function F2 để trả về danh sách GV cùng khoa 
--với GV có mã là tham số truyền vào.
 create 
 alter function F2 (@ma nvarchar(7))
 returns table 
 as
 return (select a.magv ,a.tengv  from giangvien a , khoa b 
 where a.makhoa=b.makhoa and a.makhoa in (select makhoa from giangvien 
											where magv=@ma))
select* from F2 ('GV6')
--7- Tạo function F3 cho biết thu nhập của 
---giảng viên trong khoa với mã khoa là tham số truyền vào
create function F3 (@ma nvarchar(7))
returns table
as
return (select a.makhoa,a.tengv,a.luongcb from giangvien a ,khoa b  
		where a.makhoa=b.makhoa and a.makhoa in (select makhoa 
												from giangvien
												where magv=@ma))
select * from F3 ('GV3')

---------triger ---------------
--8. Tạo trigger T1 để cho phép mỗi GV chỉ dạy tối đa là 5 môn học.
create trigger T1 on giangvien
for insert , update 
as 
begin 
if(select count(*) from inserted a, giangday b 
where a.magv=b.magv 
group by b.mamh ) > 5
begin 
print ' khong hop le '
rollback tran
end 
end

--9. Tạo trigger T2 để kiểm tra qui tắc ràng buộc
---sau: giảng viên chỉ giảng dạy những môn do khoa của họ phụ trách. 
create trigger T2 on giangday 
for insert , update 
as
begin 
if(select count(*) from inserted a where a.mamh in (
select mamh from giangvien b, monhoc c 
where a.magv=b.magv and b.makhoa=c.makhoa ))=0
begin 
print ' khong dung '
rollback tran
end 
end
--10. Tạo trigger T3 kiểm tra ràng buộc : 
--khi thêm một giảng viên thì phải đảm bảo giảng viên đó đã có môn dạy.
