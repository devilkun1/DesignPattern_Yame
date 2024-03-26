﻿USE master
GO
IF exists( SELECT * FROM sysdatabases WHERE name='YAME')
	DROP DATABASE YAME
GO
CREATE DATABASE YAME
GO
USE YAME
GO
CREATE TABLE USERYAME
(
	TAIKHOAN VARCHAR(60) PRIMARY KEY,
	MATKHAU VARCHAR(20) NOT NULL
)
GO
INSERT INTO USERYAME VALUES ('a','1'),
('b','1')

GO
CREATE TABLE NHANVIEN
(
	MANV VARCHAR(10) PRIMARY KEY,
	TAIKHOAN VARCHAR(60) NOT NULL,
	HOTEN NVARCHAR(40) NOT NULL,
	CHUCVU NVARCHAR(20) NOT NULL
	CONSTRAINT NHANVIEN_TAIKHOAN_FK FOREIGN KEY(TAIKHOAN) REFERENCES USERYAME(TAIKHOAN)
)
GO
INSERT INTO NHANVIEN VALUES ('BHYAME001','a',N'Nguyễn Văn A',N'Bán hàng'),
('QLYAME001','b',N'Nguyễn Văn B',N'Quản lí')


GO
CREATE TABLE KHACHHANG
(
	MATV VARCHAR(10) PRIMARY KEY,
	SDT VARCHAR(10) NOT NULL,
	HOTEN NVARCHAR(40) NOT NULL
)
GO
INSERT INTO KHACHHANG VALUES ('0','0',N'Khách Hàng Yame'),
('TVYAME0001','0987654321',N'Thái Tiến Hoa'),
('TVYAME0002','0718491232',N'Lâm Hà My')
delete from KHACHHANG where MATV = 'TVYAME0003'

GO
CREATE TABLE VITHANHVIEN
(
	MATV VARCHAR(10) NOT NULL,
	PHANTRAMGIAM FLOAT NOT NULL,
	TONGTIENTICHLUY INT NOT NULL
	CONSTRAINT VITHANHVIEN_MATV_FK FOREIGN KEY(MATV) REFERENCES KHACHHANG(MATV)
)
GO
INSERT INTO VITHANHVIEN VALUES ('0',0,0),
('TVYAME0001',0.05,600000),
('TVYAME0002',0.12,7600000)


GO
CREATE TABLE SIZE
(
	MASIZE VARCHAR(3) PRIMARY KEY,
	TENSIZE VARCHAR(10) NOT NULL
)
GO
INSERT INTO SIZE VALUES ('000','FREE SIZE'),
('001','S'),
('002','M'),
('003','L'),
('004','XL'),
('005','29'),
('006','30'),
('007','31'),
('008','32'),
('009','33'),
('010','40'),
('011','41'),
('012','42'),
('013','43')


GO
CREATE TABLE SANPHAM
(
	MASP VARCHAR(10) PRIMARY KEY,
	TENSP NVARCHAR(120) NOT NULL,
	DONGIA INT NOT NULL,
	PHANTRAMGIAM FLOAT NOT NULL
)
GO
INSERT INTO SANPHAM VALUES ('0020888',N'Áo Thun Cổ Trụ',257000 ,0),
('0020744',N'Áo Thun 3 Lỗ',199000 ,0),
('0020560',N'Áo Khoác Bomber',499000 ,0),
('0020904',N'Áo Khoác Hoodie',427000 ,0.3),
('0018246',N'Áo Sơ Mi Tay Dài',297000 ,0),
('0019773',N'Quần Tây',385000 ,0),
('0021624',N'Quần Jean',425000 ,0),
('0021365',N'Quần Short',287000 ,0),
('0020840',N'Nón Bucket',179000 ,0.3),
('0020082',N'Nón Lưỡi Trai',140000 ,0),
('0015529',N'Vớ Lười',39000 ,0.5),
('0015530',N'Vỡ cổ thấp',39000 ,0),
('0019857',N'Dây Nịt Da',285000 ,0),
('0018923',N'Ví Da',255000 ,0),
('0021545',N'Quần Lót',97000 ,0),
('0021530',N'Balo',257000 ,0),
('0021320',N'Túi Đeo',297000 ,0),
('0020873',N'Giày Tây Da',585000 ,0),
('0021265',N'Giày Sandal',347000 ,0)


GO
CREATE TABLE SANPHAM_SIZE
(
	MASP VARCHAR(10) NOT NULL,
	MASIZE VARCHAR(3) NOT NULL,
	SOLUONG INT NOT NULL
	CONSTRAINT SANPHAM_SIZE_MASP_FK FOREIGN KEY(MASP) REFERENCES SANPHAM(MASP),
	CONSTRAINT SANPHAM_SIZE_MASIZE_FK FOREIGN KEY(MASIZE) REFERENCES SIZE(MASIZE)
)
GO
INSERT INTO SANPHAM_SIZE VALUES ('0020888','001',50),
('0020888','002',100),
('0020888','003',100),
('0020888','004',50),
('0020744','001',50),
('0020744','002',100),
('0020744','003',100),
('0020744','004',50),
('0020560','001',50),
('0020560','002',100),
('0020560','003',100),
('0020560','004',50),
('0020904','001',50),
('0020904','002',100),
('0020904','003',100),
('0020904','004',50),
('0018246','001',50),
('0018246','002',100),
('0018246','003',100),
('0018246','004',50),
('0019773','005',50),
('0019773','006',70),
('0019773','007',80),
('0019773','008',80),
('0019773','009',70),
('0021624','005',50),
('0021624','006',70),
('0021624','007',80),
('0021624','008',80),
('0021624','009',70),
('0021365','005',50),
('0021365','006',100),
('0021365','007',100),
('0021365','008',50),
('0021365','009',50),
('0020840','000',50),
('0020082','000',50),
('0015529','000',50),
('0015530','000',50),
('0019857','000',50),
('0018923','000',50),
('0021545','001',50),
('0021545','002',100),
('0021545','003',100),
('0021545','004',50),
('0021530','000',50),
('0021320','000',50),
('0020873','010',50),
('0020873','011',80),
('0020873','012',80),
('0020873','013',50),
('0021265','010',50),
('0021265','011',80),
('0021265','012',80),
('0021265','013',50)


GO
CREATE TABLE HOADON
(
	STT INT IDENTITY(1,1),
	MAHD VARCHAR(20) PRIMARY KEY,
	NGAYLAP DATE DEFAULT GETDATE(),
	NGAYDOITRA DATE DEFAULT DATEADD(week, 1, GETDATE()),
	MANV VARCHAR(10) NOT NULL,
	MATV VARCHAR(10) NOT NULL,
	CONSTRAINT HOADON_MANV_FK FOREIGN KEY(MANV) REFERENCES NHANVIEN(MANV),
	CONSTRAINT HOADON_MATV_FK FOREIGN KEY(MATV) REFERENCES KHACHHANG(MATV)
)
GO
INSERT INTO HOADON (MAHD,NGAYLAP,NGAYDOITRA,MANV,MATV) VALUES ('011022000000000001','2022/10/01','2022/10/08','BHYAME001','0')
INSERT INTO HOADON (MAHD,NGAYLAP,NGAYDOITRA,MANV,MATV) VALUES ('301122000000000002','2022/11/30','2022/12/07','BHYAME001','0')
INSERT INTO HOADON (MAHD,NGAYLAP,NGAYDOITRA,MANV,MATV) VALUES ('301122000000000003','2022/11/30','2022/12/07','BHYAME001','0')
INSERT INTO HOADON (MAHD,NGAYLAP,NGAYDOITRA,MANV,MATV) VALUES ('101222000000000004','2022/12/10','2022/12/17','BHYAME001','0')


GO
CREATE TABLE CTHD
(
	MAHD VARCHAR(20) NOT NULL,
	MASP VARCHAR(10) NOT NULL,
	MASIZE VARCHAR(3) NOT NULL,
	SOLUONG INT NOT NULL,
	DONGIA INT NOT NULL,
	PHANTRAMGIAM FLOAT NOT NULL,
	THANHTIEN INT NOT NULL,
	SOLUONGDOI INT DEFAULT 0
	CONSTRAINT CTHD_MAHD_FK FOREIGN KEY(MAHD) REFERENCES HOADON(MAHD),
	CONSTRAINT CTHD_MASP_FK FOREIGN KEY(MASP) REFERENCES SANPHAM(MASP),
	CONSTRAINT CTHD_MASIZE_FK FOREIGN KEY(MASIZE) REFERENCES SIZE(MASIZE)
)
GO
INSERT INTO CTHD (MAHD, MASP, MASIZE, SOLUONG, DONGIA, PHANTRAMGIAM, THANHTIEN) VALUES  ('011022000000000001','0015529','000',1,39000,0.5,19500)
INSERT INTO CTHD (MAHD, MASP, MASIZE, SOLUONG, DONGIA, PHANTRAMGIAM, THANHTIEN) VALUES ('301122000000000002','0015530','000',1,39000,0,39000)
INSERT INTO CTHD (MAHD, MASP, MASIZE, SOLUONG, DONGIA, PHANTRAMGIAM, THANHTIEN) VALUES ('301122000000000003','0018246','001',1,297000,0,297000)
INSERT INTO CTHD (MAHD, MASP, MASIZE, SOLUONG, DONGIA, PHANTRAMGIAM, THANHTIEN) VALUES ('101222000000000004','0018923','000',1,255000,0,255000)


GO
CREATE TABLE BANGTHANHTOAN
(
	MAHD VARCHAR(20) NOT NULL,
	TONGHOADON INT NOT NULL,
	GIAMTRUCTIEP INT NOT NULL,
	GIAMVOUCHER INT NOT NULL,
	TIENPHAITHU INT NOT NULL,
	CONSTRAINT BANGTHANHTOAN_MAHD_FK FOREIGN KEY(MAHD) REFERENCES HOADON(MAHD)
)
GO
INSERT INTO BANGTHANHTOAN (MAHD,TONGHOADON,GIAMTRUCTIEP,GIAMVOUCHER,TIENPHAITHU) VALUES ('011022000000000001',39000,19500,0,20000)
INSERT INTO BANGTHANHTOAN (MAHD,TONGHOADON,GIAMTRUCTIEP,GIAMVOUCHER,TIENPHAITHU) VALUES ('301122000000000002',39000,0,0,39000)
INSERT INTO BANGTHANHTOAN (MAHD,TONGHOADON,GIAMTRUCTIEP,GIAMVOUCHER,TIENPHAITHU) VALUES ('301122000000000003',297000,0,0,297000)
INSERT INTO BANGTHANHTOAN (MAHD,TONGHOADON,GIAMTRUCTIEP,GIAMVOUCHER,TIENPHAITHU) VALUES ('101222000000000004',255000,0,0,255000)


GO
CREATE TABLE VOUCHER
(
	MAHD VARCHAR(20) NOT NULL,
	SUDUNG BIT DEFAULT 0,
	NGAYVOUCHER DATE DEFAULT DATEADD(month, 1, GETDATE()),
	DONTOITHIEU INT NOT NULL,
	TIENGIAMLANSAU INT NOT NULL,
	CONSTRAINT VOUCHER_MAHD_FK FOREIGN KEY(MAHD) REFERENCES HOADON(MAHD)
)
GO
INSERT INTO VOUCHER VALUES ('011022000000000001',0,'2022/11/01',10000,1000)
INSERT INTO VOUCHER VALUES ('301122000000000002',1,'2022/12/30',20000,2000)
INSERT INTO VOUCHER VALUES ('301122000000000003',0,'2022/12/30',149000,14900)
INSERT INTO VOUCHER VALUES ('101222000000000004',0,'2023/01/10',128000,12800)


GO
CREATE TABLE DONONL
(
	MAONL VARCHAR(20) PRIMARY KEY,
	MATV VARCHAR(10) DEFAULT '0',
	HOTEN NVARCHAR(50) NOT NULL,
	SDT VARCHAR(10) NOT NULL,
	DIACHI NVARCHAR(100) NOT NULL,
	NGAYDAT DATE NOT NULL,
	TRANGTHAI NVARCHAR(20) DEFAULT N'Đang chờ',
	CONSTRAINT DONONL_MATV_FK FOREIGN KEY(MATV) REFERENCES KHACHHANG(MATV)
)
INSERT INTO DONONL (MAONL,MATV,HOTEN,SDT,DIACHI,NGAYDAT) VALUES ('ONL101222000000001','TVYAME0002',N'Lâm Hà My','0718491232',N'150 Nguyễn Thị Thập, P.Bình Thuận, Q.7, Tp. Hồ Chí Minh','2022/12/10')
INSERT INTO DONONL (MAONL,MATV,HOTEN,SDT,DIACHI,NGAYDAT) VALUES ('ONL111222000000002','TVYAME0001',N'Thái Tiến Hoa','0987654321',N'19 Nguyễn Hữu Thọ, P.Tân Hưng, Q.7, Tp. Hồ Chí Minh','2022/12/11')
INSERT INTO DONONL (MAONL,HOTEN,SDT,DIACHI,NGAYDAT) VALUES ('ONL121222000000003',N'Anh Dương Lâm','0755333343',N'393/12 Trần Hưng Đạo, P.24, Đồng Nai, Tp. Biên Hoà','2022/12/12')
INSERT INTO DONONL (MAONL,HOTEN,SDT,DIACHI,NGAYDAT) VALUES ('ONL131222000000004',N'Nguyễn Tuyết Nhi','0768688231',N'123 Tùng Thiện Vuong, P.12, Q.8, Tp. Hồ Chí Minh','2022/12/13')


GO 
CREATE TABLE CT_ONL
(
	MAONL VARCHAR(20) NOT NULL,
	MASP VARCHAR(10) NOT NULL,
	MASIZE VARCHAR(3) NOT NULL,
	SOLUONG INT NOT NULL,
	DONGIA INT NOT NULL,
	PHANTRAMGIAM FLOAT NOT NULL,
	THANHTIEN INT NOT NULL
	CONSTRAINT CT_ONL_MAONL_FK FOREIGN KEY(MAONL) REFERENCES DONONL(MAONL),
	CONSTRAINT CT_ONL_MASP_FK FOREIGN KEY(MASP) REFERENCES SANPHAM(MASP),
	CONSTRAINT CT_ONL_MASIZE_FK FOREIGN KEY(MASIZE) REFERENCES SIZE(MASIZE)
)
INSERT INTO CT_ONL (MAONL, MASP, MASIZE, SOLUONG, DONGIA, PHANTRAMGIAM, THANHTIEN) VALUES  ('ONL101222000000001','0015529','000',1,39000,0.5,19500)
INSERT INTO CT_ONL (MAONL, MASP, MASIZE, SOLUONG, DONGIA, PHANTRAMGIAM, THANHTIEN) VALUES ('ONL111222000000002','0015530','000',1,39000,0,39000)
INSERT INTO CT_ONL (MAONL, MASP, MASIZE, SOLUONG, DONGIA, PHANTRAMGIAM, THANHTIEN) VALUES ('ONL121222000000003','0018246','001',1,297000,0,297000)
INSERT INTO CT_ONL (MAONL, MASP, MASIZE, SOLUONG, DONGIA, PHANTRAMGIAM, THANHTIEN) VALUES ('ONL131222000000004','0018923','000',1,255000,0,255000)



GO
CREATE TABLE CARD
(
	MASOTHE VARCHAR(16) PRIMARY KEY,
	HOTEN NVARCHAR(40) NOT NULL,
	MATKHAU VARCHAR(6) NOT NULL,
	SODU BIGINT NOT NULL
)
GO
INSERT INTO CARD VALUES ('6911000056753920',N'Phùng Phúc Hậu','111111',1000000000)
INSERT INTO CARD VALUES ('6911000056753921',N'Lý Tuấn An','222222',2000000000)
INSERT INTO CARD VALUES ('6911000056753923',N'Thái Tiến Hoa','333333',3000000000)
INSERT INTO CARD VALUES ('6911000056753924',N'Lê Hoàng Anh','444444',4000000000)
INSERT INTO CARD VALUES ('6911000056753925',N'Nguyễn Văn A','555555',10000)

----------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------ TRIGGER -------------------------------------------------------------

GO -- TRIGGER CAP NHAT SO LUONG KHI THEM CTHD
CREATE TRIGGER tg_SANPHAMSIZE_CAPNHATSOLUONG
	ON CTHD
	AFTER INSERT
AS BEGIN
	DECLARE @MASP VARCHAR(20)
	DECLARE @MASIZE VARCHAR(10)
	DECLARE @SOLUONG INT
	SELECT @MASP = MASP, @MASIZE = MASIZE, @SOLUONG = SOLUONG FROM inserted

	UPDATE SANPHAM_SIZE SET SOLUONG = SOLUONG - @SOLUONG WHERE MASP = @MASP AND MASIZE = @MASIZE
END


GO -- TRIGGER CAP NHAT VI THANH VIEN --
CREATE TRIGGER tg_VITHANHVIEN_CAPNHATPHANTRAM
	ON VITHANHVIEN
	AFTER UPDATE
AS BEGIN
	DECLARE @TONGTIENTICHLUY INT
	DECLARE @MATV VARCHAR(10)
	SELECT @MATV = MATV, @TONGTIENTICHLUY = TONGTIENTICHLUY FROM inserted

	IF @TONGTIENTICHLUY >= 500000 AND @TONGTIENTICHLUY < 1000000
	BEGIN
		UPDATE VITHANHVIEN SET PHANTRAMGIAM = 0.05 WHERE MATV = @MATV
	END
	IF @TONGTIENTICHLUY >= 1000000 AND @TONGTIENTICHLUY < 2000000
	BEGIN
		UPDATE VITHANHVIEN SET PHANTRAMGIAM = 0.06 WHERE MATV = @MATV
	END
	IF @TONGTIENTICHLUY >= 2000000 AND @TONGTIENTICHLUY < 3000000
	BEGIN
		UPDATE VITHANHVIEN SET PHANTRAMGIAM = 0.07 WHERE MATV = @MATV
	END
	IF @TONGTIENTICHLUY >= 3000000 AND @TONGTIENTICHLUY < 4000000
	BEGIN
		UPDATE VITHANHVIEN SET PHANTRAMGIAM = 0.08 WHERE MATV = @MATV
	END
	IF @TONGTIENTICHLUY >= 4000000 AND @TONGTIENTICHLUY < 5000000
	BEGIN
		UPDATE VITHANHVIEN SET PHANTRAMGIAM = 0.09 WHERE MATV = @MATV
	END
	IF @TONGTIENTICHLUY >= 5000000 AND @TONGTIENTICHLUY < 6000000
	BEGIN
		UPDATE VITHANHVIEN SET PHANTRAMGIAM = 0.1 WHERE MATV = @MATV
	END
	IF @TONGTIENTICHLUY >= 6000000 AND @TONGTIENTICHLUY < 7000000
	BEGIN
		UPDATE VITHANHVIEN SET PHANTRAMGIAM = 0.11 WHERE MATV = @MATV
	END
	IF @TONGTIENTICHLUY >= 7000000 AND @TONGTIENTICHLUY < 8000000
	BEGIN
		UPDATE VITHANHVIEN SET PHANTRAMGIAM = 0.12 WHERE MATV = @MATV
	END
	IF @TONGTIENTICHLUY >= 8000000 AND @TONGTIENTICHLUY < 9000000
	BEGIN
		UPDATE VITHANHVIEN SET PHANTRAMGIAM = 0.13 WHERE MATV = @MATV
	END
	IF @TONGTIENTICHLUY >= 9000000 AND @TONGTIENTICHLUY < 10000000
	BEGIN
		UPDATE VITHANHVIEN SET PHANTRAMGIAM = 0.14 WHERE MATV = @MATV
	END
	IF @TONGTIENTICHLUY >= 10000000
	BEGIN
		UPDATE VITHANHVIEN SET PHANTRAMGIAM = 0.15 WHERE MATV = @MATV
	END
END


GO -- TRIGGER CAP NHAT CONG VAO SO LUONG DOI --
CREATE TRIGGER tg_SANPHAMSIZE_CAPNHATSOLUONGDOI
	ON CTHD
	AFTER UPDATE
AS BEGIN
	DECLARE @MASP VARCHAR(20)
	DECLARE @MASIZE VARCHAR(10)
	DECLARE @SOLUONGDOI INT
	SELECT @MASP = MASP, @MASIZE = MASIZE, @SOLUONGDOI = SOLUONGDOI FROM inserted

	UPDATE SANPHAM_SIZE SET SOLUONG = SOLUONG + @SOLUONGDOI WHERE MASP = @MASP AND MASIZE = @MASIZE
END