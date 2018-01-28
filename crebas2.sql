/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     1/29/2018 4:04:50 AM                         */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('GIAOVIEN') and o.name = 'FK_GIAOVIEN_GIAOVIENQ_GIAOVIEN')
alter table GIAOVIEN
   drop constraint FK_GIAOVIEN_GIAOVIENQ_GIAOVIEN
go

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
            from  sysindexes
           where  id    = object_id('GIAOVIEN')
            and   name  = 'QUANLY_FK'
            and   indid > 0
            and   indid < 255)
   drop index GIAOVIEN.QUANLY_FK
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
   MABM                 char(10)             not null,
   TENBM                char(10)             null,
   TRUONGBM             char(10)             null,
   constraint PK_BOMON primary key nonclustered (MABM)
)
go

/*==============================================================*/
/* Table: GIAOVIEN                                              */
/*==============================================================*/
create table GIAOVIEN (
   MAGV                 char(10)             not null,
   MABM                 char(10)             not null,
   GIA_MAGV             char(10)             null,
   HOTEN                char(10)             null,
   NAMSINH              char(10)             null,
   constraint PK_GIAOVIEN primary key nonclustered (MAGV)
)
go

/*==============================================================*/
/* Index: QUANLY_FK                                             */
/*==============================================================*/
create index QUANLY_FK on GIAOVIEN (
GIA_MAGV ASC
)
go

/*==============================================================*/
/* Index: THUOC_FK                                              */
/*==============================================================*/
create index THUOC_FK on GIAOVIEN (
MABM ASC
)
go

alter table GIAOVIEN
   add constraint FK_GIAOVIEN_GIAOVIENQ_GIAOVIEN foreign key (GIA_MAGV)
      references GIAOVIEN (MAGV)
go

alter table GIAOVIEN
   add constraint FK_GIAOVIEN_THUOC_BOMON foreign key (MABM)
      references BOMON (MABM)
go

