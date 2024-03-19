create database QLSV1
use QLSV1
set dateformat dmy
 ---------------(tao table )
create table LOP(
MaLop char(7) not null primary key,
TenLop nvarchar(50) not null,
SiSo tinyint
);
create table MONHOC(
MaMH char(7) not null primary key,
TenMH nvarchar(50) not null,
TCLT tinyint ,
TCTH tinyint
);
create table SINHVIEN (
MSSV char(7) not null primary key,
HoTen nvarchar(50) not null,
NTNS date,
Phai bit,
MaLop char(7) 
);
create table DIEMSV(
MSSV char(7) not null,
MaMH char(7) not null,
Diem decimal(3,1)
);
---------------------khoa chinh ------------------------------
alter table DIEMSV add constraint PK_DIEMSV primary key (MSSV,MaMH);--

-----------------tao khoa ngoai ----------------------------------
 alter table SINHVIEN add constraint FK_DIEMSV FOREIGN KEY (MaLop) references LOP(MaLop);---
 alter table DIEMSV add constraint FK_DIEM_SV FOREIGN KEY (MSSV) references SINHVIEN(MSSV);
 alter table DIEMSV add constraint FK_DIEM_MH FOREIGN KEY (MaMH) references MONHOC(MaMH);

----------------------- rang buoc toan ven ---------------------------
alter table SINHVIEN add constraint R1_DIEM check(Diem >= 0 and Diem <= 10 )
alter table LOP add constraint R2_SS check (SiSo >= 0)
alter table SINHVIEN add constraint R3_phai check(PHAI = 0 or PHAI <= 1 )
---------------------------- nhapp du liẹu( 1 trc nh sau ) ---------------------------------------
---- MH, lop
------sinh vien 
---------- deim sv

select * from SINHVIEN
select * from LOP
select * from MONHOC
select * from DIEMSV

1-	Thêm một dòng mới vào bảng SINHVIEN với giá trị:
190001	Đào Thị Tuyết Hoa	08/03/2001	0	19DTH02

INSERT INTO SINHVIEN VALUEs ('190001',N'Đào Thị Tuyết Hoa','08/03/2001','0','19DTH02');

2-	Hãy đổi tên môn học ‘Lý thuyết đồ thị ’thành ‘Toán rời rạc’.
update MONHOC
SET TENMH =N'Toán rời rạc'
WHERE TENMH = N'Lý thuyết đồ thị'

3-	Hiển thị tên các môn học không có thực hành.-> SO hoa 

select * from MONHOC
select * from MONHOC WHERE TCTH = O

4-	Hiển thị tên các môn học vừa có lý thuyết, vừa có thực hành.
SELECT * from MONHOC WHERE TCTH > 0		AND TCLT >0
5-	In ra tên các môn học có ký tự đầu của tên là chữ ‘C’.
SELECT * from MONHOC WHERE TENMH LIKE N'C%'

6-	Liệt kê thông tin những sinh viên mà họ chứa chữ ‘Thị’.
SELECT * FROM SINHVIEN WHERE HOTEN LIKE N'%Thị%'

7-	In ra 2 lớp có sĩ số đông nhất (bằng nhiều cách). Hiển thị: Mã lớp, Tên lớp, Sĩ số. Nhận xét?

select * from LOP
select top 2 with ties a.MaLop , a.TenLop , a.SiSo
from LOP a
order by SiSo desc

8-	In danh sách SV theo từng lớp: MSSV, Họ tên SV, Năm sinh, Phái (Nam/Nữ).
select * from SINHVIEN
 select *
 from SINHVIEN
 order by Malop desc

9-	Cho biết những sinh viên có tuổi ≥ 20, thông tin gồm: Họ tên sinh viên, Ngày sinh, Tuổi.

select MSSV , HoTen, DATEDIFF(year, (NTNS), GETDATE()) as [Tuoi]  , Phai, MaLop
from SINHVIEN
where DATEDIFF(year, (NTNS), GETDATE()) >= 20

10-Liệt kê tên các môn học SV đã dự thi nhưng chưa có điểm.
select * from MONHOC
select * from DIEMSV
select a.MaMH
from DIEMSV a
where a.Diem = NULL

11-Liệt kê kết quả học tập của SV có mã số 170001. Hiển thị: MSSV, HoTen, TenMH, Diem.
select *
from SINHVIEN A
WHERE A.MSSV = 170001

12-Liệt kê tên sinh viên và mã môn học mà sv đó đăng ký với điểm trên 7 điểm.
select * from DIEMSV
select * from SINHVIEN

SELECT a.HoTen , b.MaMH
FROM SINHVIEN a , DIEMSV b
WHERE a.MSSV = b.MSSV and b.Diem >= 7

13-Liệt tên môn học cùng số lượng SV đã học và đã có điểm.
select * from SINHVIEN
select * from MONHOC
select * from DIEMSV
select b.TenMH , a.HoTen
from SINHVIEN a , MONHOC b ,DIEMSV c
where a.MSSV = c.MSSV AND b.MaMH = c.MaMH AND c.Diem >0

14-Liệt kê tên SV và điểm trung bình của SV đó.


15-Liệt kê tên sinh viên đạt điểm cao nhất của môn học ‘Kỹ thuật lập trình’.
select top 1 a.HoTen
from SINHVIEN a, DIEMSV b ,MONHOC c
where a.MSSV = b.MSSV and b.MaMH = c.MaMH and c.TenMH = N'Kỹ thuật lập trình' 
order by b.Diem desc

16-Liệt kê tên SV có điểm trung bình cao nhất.


17-Liệt kê tên SV chưa học môn ‘Toán rời rạc’.
select a.HoTen
from SINHVIEN a,MONHOC b,DIEMSV c
where b.MaMH=c.MaMH and a.MSSV  = c.MSSV and b.TenMH = 'Toán rời rạc'

18-Cho biết sinh viên có năm sinh cùng với sinh viên tên ‘Danh’.

select year(NTNS)
from sinhvien 
where hoten like '%Danh'

select * from sinhvien 
where year(NTNS)=(select year(NTNS) from sinhvien  where hoten like '%Danh')

19-Cho biết tổng sinh viên và tổng số sinh viên nữ.


20-Cho biết danh sách các sinh viên rớt ít nhất 1 môn.
select s.hoten 
from sinhvien s, diemsv d 
where s.mssv = d.mssv and d.diem = 0

21-Cho biết MSSV, Họ tên SV đã học và có điểm ít nhất 3 môn.

select s.mssv , s.HoTen , count(mamh) as so_mon_hc
from SINHVIEN s, DIEMSV d
where s.mssv = d.mssv and d.diem >0
group by s.mssv , s.hoten 
having count(mamh) >=3

22-In danh sách sinh viên có điểm môn ‘Kỹ thuật lập trình’ cao nhất theo từng lớp. Group by malop, tenlop
select  s.mssv,s.HoTen,diem ,malop
from sinhvien s,diemsv  d, monhoc m
where s.mssv = d.mssv and d.mamh=m.mamh and tenmh=N'Kỹ thuật lập trình'
and diem >=all (
select diem 
from sinhvien s1,diemsv  d1, monhoc m1
where s1.mssv = d1.mssv and d1.mamh=m1.mamh and tenmh=N'Kỹ thuật lập trình' and s.malop =s1.malop)



23-In danh sách sinh viên có điểm cao nhất theo từng môn, từng lớp.


24-Cho biết những sinh viên đạt điểm cao nhất của từng môn.
25-Cho biết MSSV, Họ tên SV chưa đăng ký học môn nào.
26-Danh sách sinh viên có tất cả các điểm đều 10.
27-Đếm số sinh viên nam, nữ theo từng lớp.

select l.malop,l.tenlop,sum (case phai when 1 then 1 else 0 end ) as sl_nam,sum (case phai when 0 then 1 else 0 end )
 as sl_nu
from sinhvien s, lop l
where s.malop = l.malop
group by l.malop, tenlop

[dem sl nam ] sum (case phai when 1 then 1 else 0 end ) --------------------------neu na la 1 nu ngc lai
[dem sl nu ] sum (case phai when 0 then 1 else 0 end )---------neu nu thi 1 ng lai thi 0

28-Cho biết những sinh viên đã học tất cả các môn nhưng không rớt môn nào.
29-Xoá tất cả những sinh viên chưa dự thi môn nào.
30-Cho biết những môn đã được tất cả các sinh viên đăng ký học.

---------------------------data() lấy năm hiẹn tai



