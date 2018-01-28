/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     1/29/2018 3:01:21 AM                         */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('GIAOVIEN') and o.name = 'FK_GIAOVIEN_THUOC_BOMON')
alter table GIAOVIEN
   drop constraint FK_GIAOVIEN_THUOC_BOMON
go

if exists (select 1
            from  sysobjects
           where  id = object_id('BOMON')
            and   type = 'U')
   drop table BOMON
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('GIAOVIEN')
            and   name  = 'THUOC_FK'
            and   indid > 0
            and   indid < 255)
   drop index GIAOVIEN.THUOC_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('GIAOVIEN')
            and   type = 'U')
   drop table GIAOVIEN
go

/*==============================================================*/
/* Table: BOMON                                                 */
/*==============================================================*/
create table BOMON (
   BM_MABM              char(10)             not null,
   BM_TENBM             char(10)             null,
   BM_TRUONGBM          char(10)             null,
   constraint PK_BOMON primary key nonclustered (BM_MABM)
)
go

/*==============================================================*/
/* Table: GIAOVIEN                                              */
/*==============================================================*/
create table GIAOVIEN (
   GV_MAGV              char(10)             not null,
   BM_MABM              char(10)             not null,
   GV_HOTEN             char(10)             null,
   GV_MABM              char(10)             null,
   constraint PK_GIAOVIEN primary key nonclustered (GV_MAGV)
)
go

/*==============================================================*/
/* Index: THUOC_FK                                              */
/*==============================================================*/
create index THUOC_FK on GIAOVIEN (
BM_MABM ASC
)
go

alter table GIAOVIEN
   add constraint FK_GIAOVIEN_THUOC_BOMON foreign key (BM_MABM)
      references BOMON (BM_MABM)
go

