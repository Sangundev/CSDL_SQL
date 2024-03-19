create database QL_rapchieuphim
use QL_rapchieuphim

create table THELOAI(
MATL varchar(5) not null primary key ,
TENTL nvarchar(50));

create table PHIM(
MAPHIM varchar(5) not null primary key, 
TENPHIM nvarchar(50), 
SOLANCHIEU int , 
MATL varchar(5) default null)

alter table PHIM add constraint FK_MATL foreign key(MATL)
references THELOAI(MATL);


create table RAP(
MARAP varchar(5) not null primary key , 
TENRAP nvarchar(50),
DIACHI nvarchar(50)) 

create table LICHCHIEU (
MAXC varchar(5) not null primary key, 
MARAP varchar(5) default null,
MAPHIM varchar(5) default null, 
NGAYCHIEU date,
SOLUONGVE int,
GIAVE int) 

alter table  LICHCHIEU add constraint FK_LC foreign key(MARAP)
references RAP(MARAP);
alter table  LICHCHIEU add constraint FK_MP foreign key(MAPHIM)
references PHIM(MAPHIM);

insert into THELOAI values ('L1','HANHDONG')
insert into THELOAI values ('L2','CHIENTRANH')
insert into THELOAI values ('L3','HAI')

insert into RAP values ('R01','THANG LONG','TANBINH')
insert into RAP values ('R02','HUNG VUONG','QUAN 10')
insert into RAP values ('R03','THONG NHAT','QUAN 1')
insert into RAP values ('R04','GIAI PHONG','PHU NHUAN')

insert into LICHCHIEU values ('01','R01','P01','2013-04-01','150','120000')
insert into LICHCHIEU values ('02','R03','P01','2013-04-01','130','110000')
insert into LICHCHIEU values ('03','R04','P02','2013-04-30','250','170000')
insert into LICHCHIEU values ('04','R02','P02','2013-05-01','100','180000')
insert into LICHCHIEU values ('05','R03','P03','2013-05-19','350','140000')
insert into LICHCHIEU values ('06','R02','P03','2013-06-01','160','160000')
insert into LICHCHIEU values ('07','R01','P04','2013-09-02','90','120000')

insert into PHIM values ('P01','BAY RONG',NULL,'L1')
insert into PHIM values ('P02','CANH DONG HOANG',NULL,'L2')
insert into PHIM values ('P03','KHI DAN ONG CO BAU',NULL,'L3')
insert into PHIM values ('P04','DONG MAU ANH HUNG',NULL,'L4')
insert into PHIM values ('P05','BIET DONG SAI GON',NULL,'L5')
--. Tạo TRIGGER thực hiện yêu cầu sau: 
--Tự động cập nhật số lần chiếu (trong Table PHIM)
--tại các rạp cho từng phim. Nếu phim  chưa được chiếu ở rạp nào 
--thì cập nhật giá trị 0. (0.5 điểm) 

--2.2 . Tạo View tên V1 tìm các rạp chiếu các phim thuộc thể loại chiến tranh được chiếu trong
--tháng 4  năm 2013. Thông tin hiển thị gồm: MÃ RẠP, TÊN RẠP, TÊN PHIM, NGÀY CHIẾU (1 điểm) 
 create view V1 as
 select d.MARAP,d.TENRAP,D.TENRAP,B.NGAYCHIEU
 from THELOAI a,LICHCHIEU b,PHIM c ,RAP d
 where a.MATL=c.MATL and b.MAPHIM=c.MAPHIM and
 b.MARAP=d.MARAP and year(b.NGAYCHIEU)=2013 and month(b.NGAYCHIEU)=4
 and a.TENTL = N'CHIENTRANH'

 select *from V1

 --2.3 Tạo Procedure
-- tên P1 tìm các phim chưa được chiếu. Thông tin hiển thị gồm: MÃ PHIM, TÊN PHIM (0.5 điểm)
create proc P1
as
	BEGIN
		select A.MAPHIM ,A.TENPHIM from PHIM A
		where A.MAPHIM not in (select MAPHIM from LICHCHIEU)
	END
 P1


		select maphim from phim
--2.4 Tạo Function tên F1 trả về tổng số lượng vé theo từng phim,
 --nếu phim nào chưa được chiếu thì  trả về giá trị 0. Tham số là mã phim. (0.5 điểm)

 create function F1 (@maphim varchar(5))
 returns int
as
	BEGIN
		declare @tong_sl int
		if exists (select B.MAPHIM ,A.TENPHIM from PHIM A, LICHCHIEU B
			where A.MAPHIM=B.MAPHIM AND b.MAPHIM=@maphim and
			B.MAPHIM not in (select distinct MAPHIM from LICHCHIEU))
		SET @tong_sl=0
		else
		SET @tong_sl = (select sum(SOLUONGVE) soluongve from LICHCHIEU 
							where MAPHIM=@maphim)
		return @tong_sl
	END
 
 print dbo.F1('P03')