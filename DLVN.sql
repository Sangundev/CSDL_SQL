create database DLVN
GO 
USE DLVN

create table TINH_TP(
MA_T_TP varchar(3) primary key , 
TEN_T_TP  nvarchar(20), 
DT float, 
DS bigint, 
MIEN nvarchar(10))

create table BIENGIOI(
NUOC nvarchar(15), 
MA_T_TP varchar(3) foreign key (MA_T_TP) references TINH_TP(MA_T_TP),
primary key (NUOC,MA_T_TP))

create table  LANGGIENG(
MA_T_TP varchar(3) foreign key (MA_T_TP) references TINH_TP(MA_T_TP), 
LG varchar(3)
primary key (MA_T_TP,LG))

insert into TINH_TP values ('AG',N'An Giang', '3406','2142709','Nam')
insert into BIENGIOI values ('CPC','AG')
insert into LANGGIENG values ('AG','DT' )

