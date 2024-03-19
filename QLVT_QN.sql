
create database QLVT
go
use QLVT
go
--drop table khachhang
create table KHACHHANG
(
	MAKH	Nvarchar(5)	primary key,
	TENKH	Nvarchar(30)not null,
	DIACHI	Nvarchar(50),
	DT	Nvarchar(15) check (DT like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' or
	                        DT like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' or
							DT like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' or
							DT like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' or
							DT is null),
	EMAIL	Nvarchar(30)
)
go
create table VATTU
(
	MAVT	Nvarchar(5)	primary key,
	TENVT	Nvarchar(30)not null,
	DVT	Nvarchar(20),
	GIAMUA	Numeric check(GIAMUA>0),
	SLTON	Numeric check(SLTON>=0)
)
go
create table HOADON
(
	MAHD	Nvarchar(10)	primary key,
	NGAY	DateTime check (NGAY<Getdate()),
	MAKH	Nvarchar(5) foreign key references KHACHHANG,
	TONGTG	Numeric
)
go
create table CHITIETHOADON
(
	MAHD	Nvarchar(10)foreign key references HOADON,
	MAVT	Nvarchar(5)foreign key references VATTU,
	SL	Numeric check(SL>0),
	KHUYENMAI	Numeric,
	GIABAN	Numeric,
	primary key (MAHD,MAVT)
)
go

Insert into VATTU(MAVT,TENVT,DVT,GIAMUA,SLTON) values('VT01','XI MANG','BAO',50000,5000)
Insert into VATTU(MAVT,TENVT,DVT,GIAMUA,SLTON) values('VT02','CAT','KHOI',45000,50000)
Insert into VATTU(MAVT,TENVT,DVT,GIAMUA,SLTON) values('VT03','GACH ONG','VIEN',120,800000)
Insert into VATTU(MAVT,TENVT,DVT,GIAMUA,SLTON) values('VT04','GACH THE','VIEN',110,800000)
Insert into VATTU(MAVT,TENVT,DVT,GIAMUA,SLTON) values('VT05','DA LON','KHOI',25000,100000)
Insert into VATTU(MAVT,TENVT,DVT,GIAMUA,SLTON) values('VT06','DA NHO','KHOI',33000,100000)
Insert into VATTU(MAVT,TENVT,DVT,GIAMUA,SLTON) values('VT07','LAM GIO','CAI',15000,50000)

Insert into KHACHHANG(MAKH,TENKH,DIACHI,DT,EMAIL) values('KH01','NGUYEN THI BE','TAN BINH','84578954','bnt@yahoo.com')
Insert into KHACHHANG(MAKH,TENKH,DIACHI,DT,EMAIL) values('KH02','LE HOANG NAM','BINH CHANH','98789875','namlehoang@abc.com.vn')
Insert into KHACHHANG(MAKH,TENKH,DIACHI,DT,EMAIL) values('KH03','TRAN THI CHIEU','TAN BINH','84578956',null)
Insert into KHACHHANG(MAKH,TENKH,DIACHI,DT,EMAIL) values('KH04','MAI THI QUE ANH','BINH CHANH',null,null)
Insert into KHACHHANG(MAKH,TENKH,DIACHI,DT,EMAIL) values('KH05','LE VAN SANG','QUAN 10',null,'sanglv@hcm.vnn.vn')
Insert into KHACHHANG(MAKH,TENKH,DIACHI,DT,EMAIL) values('KH06','TRAN HOANG KHAI','TAN BINH','84578979',null)

Insert into HOADON(MAHD,NGAY,MAKH,TONGTG) values('HD001',convert(DateTime,'12/05/2000',103),'KH01',null)
Insert into HOADON(MAHD,NGAY,MAKH,TONGTG) values('HD002',convert(DateTime,'25/05/2000',103),'KH02',null)
Insert into HOADON(MAHD,NGAY,MAKH,TONGTG) values('HD003',convert(DateTime,'25/05/2000',103),'KH01',null)
Insert into HOADON(MAHD,NGAY,MAKH,TONGTG) values('HD004',convert(DateTime,'25/05/2000',103),'KH04',null)
Insert into HOADON(MAHD,NGAY,MAKH,TONGTG) values('HD005',convert(DateTime,'26/05/2000',103),'KH04',null)
Insert into HOADON(MAHD,NGAY,MAKH,TONGTG) values('HD006',convert(DateTime,'02/06/2000',103),'KH03',null)
Insert into HOADON(MAHD,NGAY,MAKH,TONGTG) values('HD007',convert(DateTime,'22/06/2000',103),'KH04',null)
Insert into HOADON(MAHD,NGAY,MAKH,TONGTG) values('HD008',convert(DateTime,'25/06/2000',103),'KH03',null)
Insert into HOADON(MAHD,NGAY,MAKH,TONGTG) values('HD009',convert(DateTime,'15/08/2000',103),'KH04',null)
Insert into HOADON(MAHD,NGAY,MAKH,TONGTG) values('HD010',convert(DateTime,'30/09/2000',103),'KH01',null)
Insert into HOADON(MAHD,NGAY,MAKH,TONGTG) values('HD011',convert(DateTime,'27/12/2000',103),'KH06',null)
Insert into HOADON(MAHD,NGAY,MAKH,TONGTG) values('HD012',convert(DateTime,'27/12/2000',103),'KH01',null)

Insert into CHITIETHOADON(MAHD,MAVT,SL,KHUYENMAI,GIABAN) values('HD001','VT01',5,null,52000)
Insert into CHITIETHOADON(MAHD,MAVT,SL,KHUYENMAI,GIABAN) values('HD001','VT05',10,null,30000)
Insert into CHITIETHOADON(MAHD,MAVT,SL,KHUYENMAI,GIABAN) values('HD002','VT03',10000,null,150)
Insert into CHITIETHOADON(MAHD,MAVT,SL,KHUYENMAI,GIABAN) values('HD003','VT02',20,null,55000)
Insert into CHITIETHOADON(MAHD,MAVT,SL,KHUYENMAI,GIABAN) values('HD004','VT03',50000,null,150)
Insert into CHITIETHOADON(MAHD,MAVT,SL,KHUYENMAI,GIABAN) values('HD004','VT04',20000,null,120)
Insert into CHITIETHOADON(MAHD,MAVT,SL,KHUYENMAI,GIABAN) values('HD005','VT05',10,null,30000)
Insert into CHITIETHOADON(MAHD,MAVT,SL,KHUYENMAI,GIABAN) values('HD005','VT06',15,null,35000)
Insert into CHITIETHOADON(MAHD,MAVT,SL,KHUYENMAI,GIABAN) values('HD005','VT07',20,null,17000)
Insert into CHITIETHOADON(MAHD,MAVT,SL,KHUYENMAI,GIABAN) values('HD006','VT04',10000,null,120)
Insert into CHITIETHOADON(MAHD,MAVT,SL,KHUYENMAI,GIABAN) values('HD007','VT04',20000,null,125)
Insert into CHITIETHOADON(MAHD,MAVT,SL,KHUYENMAI,GIABAN) values('HD008','VT01',100,null,55000)
Insert into CHITIETHOADON(MAHD,MAVT,SL,KHUYENMAI,GIABAN) values('HD008','VT02',20,null,47000)
Insert into CHITIETHOADON(MAHD,MAVT,SL,KHUYENMAI,GIABAN) values('HD009','VT02',25,null,48000)
Insert into CHITIETHOADON(MAHD,MAVT,SL,KHUYENMAI,GIABAN) values('HD010','VT01',25,null,57000)
Insert into CHITIETHOADON(MAHD,MAVT,SL,KHUYENMAI,GIABAN) values('HD011','VT01',20,null,55000)
Insert into CHITIETHOADON(MAHD,MAVT,SL,KHUYENMAI,GIABAN) values('HD011','VT02',20,null,45000)
Insert into CHITIETHOADON(MAHD,MAVT,SL,KHUYENMAI,GIABAN) values('HD012','VT01',20,null,55000)
Insert into CHITIETHOADON(MAHD,MAVT,SL,KHUYENMAI,GIABAN) values('HD012','VT02',10,null,48000)
Insert into CHITIETHOADON(MAHD,MAVT,SL,KHUYENMAI,GIABAN) values('HD012','VT03',10000,null,150)

create function F4 (@n int )
returns table 
as
return (select a.mavt ,a.tenvt,sum(b.sl) slban
from vattu a,chitiethoadon b , hoadon c
where a.mavt=b.mavt and b.mahd = c.mahd and 
year(NGAY)=@n
group by a.mavt ,tenvt)



create function F3 (@t int ,@n int )
returns table
as
return (select a.makh ,a.tenkh, sum(SL) slbantrongnam 
from khachhang a,hoadon c,chitiethoadon b
where a.MAKH=c.MAKH and c.MAHD = b.MAHD and
month(ngay)=@t and year(ngay)=@n 
group by a.makh ,a.tenkh)
select * 
exec dbo.F3(2000)




--Tạo function f7 để trả về một table chứa tên các khách hàng,
-- số lượng hoa đơn đã mua và tổng trị giá của các hoa đơn đó
-- trong năm, với năm là tham số truyền vào. Nếu năm là null 
-- thì tính tất cả các năm.
create function F7 (@n int)
returns @dskh table (
  tenkh nvarchar(30),
  soluonghd int,
  tongtrigia bigint)
as
begin
  if @n is null
     insert @dskh select a.TENKH, count(b.MAHD), sum(sl*GIABAN) 
	  from KHACHHANG a, HOADON b, CHITIETHOADON c
	  where a.MAKH = b.MAKH and b.MAHD=c.MAHD 
	  group by  a.TENKH
  else
     insert @dskh select a.TENKH, count(b.MAHD), sum(sl*GIABAN) 
	  from KHACHHANG a, HOADON b, CHITIETHOADON c
	  where a.MAKH = b.MAKH and b.MAHD=c.MAHD and 
	        year(NGAY)=@n 
	  group by  a.TENKH
  return
end
select * from dbo.f7(null)
------------------------------------------------------------------------------
alter function F6 (@n int)
returns @dsvt table (
  tenvt nvarchar(30),
  tongslban  bigint)
as
begin
  if not exists (select* from hoadon where year(NGAY) = @n)
     insert @dsvt select a.TENVT, NULL 
	  from vattu a, HOADON b, CHITIETHOADON c
	  where a.MAVT = c.MAVT and b.MAHD=c.MAHD 
	  group by  a.TENVT
  else
     insert @dsvt select a.TENVT, sum(sl) 
	  from vattu a, HOADON b, CHITIETHOADON c
	  where a.MAVT = c.MAVT and b.MAHD=c.MAHD and 
	        year(NGAY)=@n 
	  group by  a.TENVT
  return
end
select * from dbo.f6(2000)








------Tạo function f7 để trả về một table chứa tên các khách hàng,l--Tạo function f7 để trả về một table chứa tên các khách hàng,
-- số lượng hoa đơn đã mua và tổng trị giá của các hoa đơn đó
-- trong năm, với năm là tham số truyền vào. Nếu năm là null 
-- thì tính tất cả các năm.
alter function F6 (@n int)
returns @dsvt table (
  tenvt nvarchar(30),
  tongslban  bigint)
as
begin
  if not exists (select* from hoadon where year(NGAY) = @n)
     insert @dsvt select a.TENVT, NULL 
	  from vattu a, HOADON b, CHITIETHOADON c
	  where a.MAVT = c.MAVT and b.MAHD=c.MAHD 
	  group by  a.TENVT
  else
     insert @dsvt select a.TENVT, sum(sl) 
	  from vattu a, HOADON b, CHITIETHOADON c
	  where a.MAVT = c.MAVT and b.MAHD=c.MAHD and 
	        year(NGAY)=@n 
	  group by  a.TENVT
  return
end
select * from dbo.f6(2000)

---Viết hàm để trả về số lượng khách hàng ở địa chỉ là tham số truyền vào
alter function F7 (@DT nvarchar(50))
returns @dskh table (
  tenkh nvarchar(30),
  slkh  bigint)
as
begin
     insert into @dskh select a.TENKH, count(c.SL) 
	  from KHACHHANG a, HOADON b, CHITIETHOADON c
	  where a.MAKH = b.MAKH and b.MAHD=c.MAHD and a.DIACHI=@DT
	  group by  a.TENKH
  return
end
select * from dbo.f7('TAN BINH')


-----Viết hàm để lấy ra danh sách khách hàng ở địa chỉ là tham số truyền vào.


-----Đếm số lượng khách hàng mua hàng trong năm với năm là tham số truyền vào. Nếu năm không truyền vào, thì đếm tất cả khách hàng.
create 
alter function F10 (@n int)
returns @dslkh table (
  tenvt nvarchar(30),
  slkhm  bigint)
as
begin
  if not exists (select* from hoadon where year(NGAY) = @n)
     insert @dslkh select a.TENKH,count(sl)
	  from KHACHHANG a, HOADON b, CHITIETHOADON c
	  where a.MAKH = b.MAKH and b.MAHD=c.MAHD 
	  group by  a.TENKH
  else
     insert @dslkh select a.TENKH, count(sl) 
	  from KHACHHANG a, HOADON b, CHITIETHOADON c
	  where a.MAKH = b.MAKH and b.MAHD=c.MAHD and 
	        year(NGAY)=@n 
	  group by  a.TENKH
  return
end
select * from dbo.f10(2000)
/////////////////////////
---Viết hàm để trả về số lượng khách hàng ở địa chỉ là tham số truyền vào
create function F7 (@DT nvarchar(50))
returns int
as
begin
	declare @sl int
	select @sl=COUNT(MAKH)
	from KHACHHANG
	where DIACHI=@DT
  return @sl
end
select* from dbo.f7('TAN BINH')
-----Đếm số lượng khách hàng mua hàng trong năm với năm là tham số truyền vào. 
--Nếu năm không truyền vào, thì đếm tất cả khách hàng.
create
function F10 (@n int)
returns int
as
begin
	declare @sl int
	if not exists (select * from hoadon where year(NGAY) = @n)
	select @sl=COUNT(MAKH)
	from KHACHHANG
	  
  else
  select @sl=count(a.MAKH)
		from KHACHHANG a, HOADON b
		where a.MAKH = b.MAKH and YEAR(b.NGAY) = @n
  return @sl
end
select* from dbo.f10('')
--Viết hàm để lấy ra danh sách khách hàng ở địa chỉ là tham số truyền vào.
create function f11 (@dc Nvarchar(50))  
	returns @dskh table (
  tenkh nvarchar(30))
As
Begin
    insert @dskh select TENKH
	from KHACHHANG 
   where DIACHI = @dc
   return 
end
Select * from dbo.f11(N'BINH CHANH')
-- Tạo trigger T3 không cho phép sửa địa chỉ kh thành NULL
create trigger T3 on khachhang
for update
as
begin
   if update(DIACHI)
     if exists (select * from inserted where DIACHI is NULL)
	   begin
	     print N'Báo lỗi'
		 rollback tran
	   end
end
update KHACHHANG set DIACHI=NULL where MAKH='KH06'
--Tạo trigger không cho phép hai vật tư trùng tên 
drop trigger T1
alter trigger T1 on vattu
for insert, update
as
  begin
    if (select count(*) from inserted a, VATTU b
	   where a.TENVT=b.TENVT)>1
	   begin
	     print N'Không được có 2 vật tư trùng tên'
		 rollback Tran
	   end
  end
insert into vattu values ( 'VT16',N'CAT','KHOI',45000,3000)
--Tạo trigger để không cho phép xoá cùng lúc nhiều hơn một 
--khách hàng
create trigger T2 on khachhang
for delete
as
begin
  if(select count(*) from deleted)>1
    begin
	  print N'không được phép xóa nhiều khách hàng'
	  rollback Tran
	end
end
delete from KHACHHANG where MAKH in ('KH07')