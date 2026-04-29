create database exam_practice;
use exam_practice;


create table book (
    masach varchar(10) primary key,
    tensach varchar(255) not null,
    tacgia varchar(100),
    namphathanh int,
    soluonghienco int
);

create table reader (
    madocgia varchar(10) primary key,
    hoten varchar(100) not null,
    email varchar(100),
    sodienthoai varchar(15),
    ngaysinh date,
    diachi text
);

create table borrow_card (
    maphieumuon varchar(10) primary key,
    madocgia varchar(10),
    ngaymuon date,
    ngayhentra date,
    foreign key (madocgia) references reader(madocgia)
);

create table borrow_detail (
    maphieumuon varchar(10),
    masach varchar(10),
    trangthaisach varchar(50),
    phimuon decimal(10, 2),
    primary key (maphieumuon, masach),
    foreign key (maphieumuon) references borrow_card(maphieumuon),
    foreign key (masach) references book(masach)
);

insert into book values 
('b001', 'cho tôi xin một vé đi tuổi thơ', 'nguyễn nhật ánh', 2010, 20),
('b002', 'lập trình sql căn bản', 'nxb giáo dục', 2021, 15),
('b003', 'tiếng gọi nơi hoang dã', 'jack london', 1903, 10),
('b004', 'mắt biếc', 'nguyễn nhật ánh', 2019, 25),
('b005', 'clean code', 'robert c. martin', 2008, 12);

insert into reader values 
('r001', 'lê hải nguyên', 'nguyen@gmail.com', '0912345678', '2005-01-01', 'đà lạt'),
('r002', 'trần văn a', null, '0987654321', '2004-05-10', 'tp.hcm'),
('r003', 'nguyễn thị b', 'b@gmail.com', '0123456789', '2006-11-20', 'hà nội'),
('r004', 'phạm văn c', null, '0345678912', '2003-02-15', 'đà nẵng'),
('r005', 'hoàng thị d', 'd@gmail.com', '0789456123', '2007-08-30', 'cần thơ');

insert into borrow_card values 
('pm001', 'r001', '2026-04-10', '2026-04-17'),
('pm002', 'r003', '2026-04-15', '2026-04-22'),
('pm003', 'r005', '2026-03-01', '2026-03-08'),
('pm004', 'r001', '2026-04-20', '2026-04-27'),
('pm005', 'r002', '2026-04-05', '2026-04-12');

insert into borrow_detail values 
('pm001', 'b001', 'mới', 5000),
('pm001', 'b002', 'mới', 10000),
('pm002', 'b003', 'cũ', 3000),
('pm004', 'b004', 'mới', 5000),
('pm005', 'b002', 'mới', 10000);

update book 
set soluonghienco = soluonghienco + 5 
where tacgia = 'nguyễn nhật ánh';

delete from reader where email is null;

select * from book 
where namphathanh between 2015 and 2023;

select r.hoten, bc.maphieumuon 
from reader r
join borrow_card bc on r.madocgia = bc.madocgia
where bc.ngaymuon >= '2026-04-01' and bc.ngaymuon <= '2026-04-30';

select b.tensach 
from book b
join borrow_detail bd on b.masach = bd.masach
where bd.maphieumuon = 'pm001';

select r.hoten, r.sodienthoai 
from reader r
join borrow_card bc on r.madocgia = bc.madocgia
join borrow_detail bd on bc.maphieumuon = bd.maphieumuon
join book b on bd.masach = b.masach
where b.tensach = 'lập trình sql căn bản';

select bd.maphieumuon, b.tensach, bd.trangthaisach 
from borrow_detail bd
join book b on bd.masach = b.masach
where b.tacgia = 'jack london';