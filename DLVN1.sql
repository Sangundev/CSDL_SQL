create database DLVN1
go
use DLVN1
set dateformat dmy
create table TINH(
MATINH char(2) not null ,
TENTINH varchar(30) not null,
DIENTICH float,
DANSO int,
THIXA varchar(30),
MAMIEN char(2) not null
);
create table MIEN(
MAMIEN char(2) not null, 
TENMIEN varchar(30) not null );

create table BIENGIOI(
MATINH char(2) not null,
MANUOC char(3) not null
);
create table NUOC(
MANUOC char(3) not null,
TENNUOC varchar(30) not null,
THUDO varchar(30) not null);

create table LANGGIENG(
MATINH char(2) not null,
LG char(2) not null
);
alter table TINH add constraint PK_MATINH primary key (MATINH)
alter table MIEN add constraint PK_MAMIEN primary key (MAMIEN)
alter table BIENGIOI add constraint PK_TINHNUOC primary key (MATINH,MANUOC)
alter table NUOC add constraint PK_MANUOC primary key (MANUOC)
alter table LANGGIENG add constraint PK_LG primary key (MATINH,LG)

alter table TINH add constraint FK_MIEN foreign key (MAMIEN)
references MIEN(MAMIEN);
alter table BIENGIOI add constraint FK_MANUOC foreign key (MATINH)
references TINH(MATINH);
alter table BIENGIOI add constraint FK_MANUOC foreign key (MANUOC)
references NUOC(MANUOC);
alter table LANGGIENG add constraint FK_TINHLG foreign key (MATINH)
references TINH(MATINH);
alter table LANGGIENG add constraint FK_LG foreign key (LG)
references TINH(MATINH);

--5 tao rang buoc 

alter table TINH add constraint RB1_DS_DT check (DIENTICH > 0 AND DANSO > 0 )
alter table LANGGIENG add constraint RB2_LG check (MATINH <> LG )
alter table TINH add constraint RB1_TENTINH UNIQUE (TENTINH )
alter table MIEN add constraint RB1_TENMIEN UNIQUE (TENMIEN)
alter table NUOC add constraint RB1_TENNUOC UNIQUE (TENNUOC )
 -- 6 NHAP DU LIEU

 insert into MIEN values ('B',N'Bắc')
 insert into MIEN values ('T',N'Trung')
 insert into MIEN values ('N',N'Nam')

  insert into TINH values ('AG',N'An Giang','3406','2142709','Tân Châu','N')
  insert into TINH values ('BR',N'Bà Rịa - Vũng Tàu','1982','996682',N'Bà Rịa','N')
  insert into TINH values ('BC',N'Bắc Cạn','4857','293826','','B')
  insert into TINH values ('BG',N'Bắc Giang','3823','293826','','B')
  insert into TINH values ('BL',N'Bạc Liêu','2526','856518','','N')
  insert into TINH values ('BN',N'Bắc Ninh','808','1024472','','B')
  insert into TINH values ('BT',N'Bến Tre','2322','1255946','','N')
  insert into TINH values ('BDI',N'Bình Định','6025','1486465','','T')
  insert into TINH values ('BD',N'Bình Dương','2696','1481550','','N')
