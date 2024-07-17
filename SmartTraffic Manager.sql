create database Assignment
DROP DATABASE Assignment
ON PRIMARY
(
    NAME = 'Assignment_DBI',
    FILENAME = 'V:\Anh Vu Nguyen\FPT_University\Semester 3\DBI202\Assignment\Assignment.mdf'
)
LOG ON
(
    NAME = 'Assignment_DBILog',
    FILENAME = 'V:\Anh Vu Nguyen\FPT_University\Semester 3\DBI202\Assignment\Assignment.ldf'
);
-- Use the created database
USE Assignment;



-- Bang quan lý khu vuc
CREATE TABLE Province (
    ProvinceCode INT PRIMARY KEY,
    ProvinceName NVARCHAR(100)
);

CREATE TABLE Country (
    CountryCode INT PRIMARY KEY,
    ProvinceCode INT,
    Name NVARCHAR(100),
    FOREIGN KEY (ProvinceCode) REFERENCES Province(ProvinceCode)
);

CREATE TABLE Area (
    AreaID INT PRIMARY KEY,
    AreaName NVARCHAR(100),
    CountryCode INT,
    FOREIGN KEY (CountryCode) REFERENCES Country(CountryCode)
);

-- B?ng qu?n lý Camera
CREATE TABLE Camera (
    CameraID INT PRIMARY KEY,
    AreaID INT,
    VehicleID INT,
    Time DATETIME,
    Number_Of_Violations INT,
    FOREIGN KEY (AreaID) REFERENCES Area(AreaID)
);

-- B?ng qu?n lý các vi ph?m giao thông
CREATE TABLE Violations (
    ViolationID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Fines DECIMAL(10, 2)
);

-- B?ng luu tr? các vi ph?m du?c ghi nh?n
CREATE TABLE ViolationRecords (
    RecordID INT PRIMARY KEY,
    CameraID INT,
    ViolationID INT,
    Time DATETIME,
    Image VARBINARY(MAX),
    FOREIGN KEY (CameraID) REFERENCES Camera(CameraID),
    FOREIGN KEY (ViolationID) REFERENCES Violations(ViolationID)
);

-- B?ng qu?n lý ch? s? h?u
CREATE TABLE Owners (
    OwnerID INT PRIMARY KEY,
    Name NVARCHAR(100),
    BirthDate DATE,
    PhoneNumber NVARCHAR(15),
    AreaID INT,
    FOREIGN KEY (AreaID) REFERENCES Area(AreaID)
);
-- B?ng qu?n lý phuong ti?n
CREATE TABLE Vehicles (
    VehicleID INT PRIMARY KEY,
    Type NVARCHAR(50),
    OwnerID INT,
    RegistrationID INT,
    FOREIGN KEY (OwnerID) REFERENCES Owners(OwnerID)
);

-- B?ng qu?n lý b?o hi?m
CREATE TABLE Insurance (
    InsuranceID INT PRIMARY KEY,
    VehicleID INT,
    Provider NVARCHAR(100),
    PolicyNumber NVARCHAR(50),
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID)
);

-- B?ng qu?n lý dang ký xe
CREATE TABLE Registration (
    RegistrationID INT PRIMARY KEY,
    VehicleID INT,
    UserID INT,
    RegistrationDate DATE,
    ExpirationDate DATE,
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID)
);

-- B?ng qu?n lý ki?m d?nh xe
CREATE TABLE Inspection (
    InspectionID INT PRIMARY KEY,
    VehicleID INT,
    InspectionDate DATE,
    Result NVARCHAR(100),
    NextInspectionDate DATE,
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID)
);

-- B?ng qu?n lý ngu?i qu?n lý
CREATE TABLE Managers (
    ManagerID INT PRIMARY KEY,
    Name NVARCHAR(100),
    BirthDate DATE,
    PhoneNumber NVARCHAR(15),
    AreaID INT,
    FOREIGN KEY (AreaID) REFERENCES Area(AreaID)
);

-- B?ng qu?n lý phòng ban
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    ManagerID INT,
    AreaID INT,
    StartTime DATETIME,
    EndTime DATETIME,
    Status NVARCHAR(50),
    FOREIGN KEY (ManagerID) REFERENCES Managers(ManagerID),
    FOREIGN KEY (AreaID) REFERENCES Area(AreaID)
);

-- B?ng qu?n lý tài kho?n ngu?i dùng
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Username NVARCHAR(50),
    Password NVARCHAR(50),
    Role NVARCHAR(50),
    OwnerID INT,
    FOREIGN KEY (OwnerID) REFERENCES Owners(OwnerID)
);

-- B?ng trung gian qu?n lý m?i quan h? gi?a ngu?i qu?n lý và khu v?c
CREATE TABLE ManagerArea (
    ManagerID INT,
    AreaID INT,
    PRIMARY KEY (ManagerID, AreaID),
    FOREIGN KEY (ManagerID) REFERENCES Managers(ManagerID),
    FOREIGN KEY (AreaID) REFERENCES Area(AreaID)
);

-- B?ng qu?n lý thanh toán ti?n ph?t
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    OwnerID INT,
    ViolationID INT,
    Amount DECIMAL(10, 2),
    Status NVARCHAR(50),
    FOREIGN KEY (OwnerID) REFERENCES Owners(OwnerID),
    FOREIGN KEY (ViolationID) REFERENCES Violations(ViolationID)
);

-- Chèn dữ liệu mẫu vào bảng Province
INSERT INTO Province (ProvinceCode, ProvinceName) VALUES
(1, N'Hà Nội'), (2, N'Hồ Chí Minh'), (3, N'Đà Nẵng'), (4, N'Cần Thơ'), (5, N'Hải Phòng'),
(6, N'Bình Dương'), (7, N'Đồng Nai'), (8, N'Quảng Ninh'), (9, N'Huế'), (10, N'Ninh Bình'),
(11, N'Hòa Bình'), (12, N'Lạng Sơn'), (13, N'Cao Bằng'), (14, N'Lào Cai'), (15, N'Tuyên Quang'),
(16, N'Hải Dương'), (17, N'Hưng Yên'), (18, N'Bắc Ninh'), (19, N'Hà Nam'), (20, N'Thái Nguyên'),
(21, N'Vĩnh Phúc'), (22, N'Bắc Giang'), (23, N'Phú Thọ'), (24, N'Quảng Nam'), (25, N'Quảng Ngãi'),
(26, N'Bình Thuận'), (27, N'Bình Định'), (28, N'Gia Lai'), (29, N'Kon Tum'), (30, N'Đắk Lắk');

-- Chèn dữ liệu mẫu vào bảng Country
INSERT INTO Country (CountryCode, ProvinceCode, Name) VALUES
(1, 1, N'Hoàn Kiếm'), (2, 1, N'Ba Đình'), (3, 2, N'Quận 1'), (4, 2, N'Quận 2'), (5, 3, N'Hải Châu'),
(6, 3, N'Sơn Trà'), (7, 4, N'Ninh Kiều'), (8, 4, N'Cái Răng'), (9, 5, N'Lê Chân'), (10, 5, N'Ngô Quyền'),
(11, 6, N'Thủ Dầu Một'), (12, 6, N'Tân Uyên'), (13, 7, N'Biên Hòa'), (14, 7, N'Long Khánh'), (15, 8, N'Hạ Long'),
(16, 8, N'Cẩm Phả'), (17, 9, N'Huế'), (18, 10, N'Ninh Bình'), (19, 11, N'Hòa Bình'), (20, 12, N'Lạng Sơn'),
(21, 13, N'Cao Bằng'), (22, 14, N'Lào Cai'), (23, 15, N'Tuyên Quang'), (24, 16, N'Hải Dương'), (25, 17, N'Hưng Yên'),
(26, 18, N'Bắc Ninh'), (27, 19, N'Hà Nam'), (28, 20, N'Thái Nguyên'), (29, 21, N'Vĩnh Phúc'), (30, 22, N'Bắc Giang');

-- Chèn dữ liệu mẫu vào bảng Area
INSERT INTO Area (AreaID, AreaName, CountryCode) VALUES
(1, N'Khu vực 1', 1), (2, N'Khu vực 2', 2), (3, N'Khu vực 3', 3), (4, N'Khu vực 4', 4), (5, N'Khu vực 5', 5),
(6, N'Khu vực 6', 6), (7, N'Khu vực 7', 7), (8, N'Khu vực 8', 8), (9, N'Khu vực 9', 9), (10, N'Khu vực 10', 10),
(11, N'Khu vực 11', 11), (12, N'Khu vực 12', 12), (13, N'Khu vực 13', 13), (14, N'Khu vực 14', 14), (15, N'Khu vực 15', 15),
(16, N'Khu vực 16', 16), (17, N'Khu vực 17', 17), (18, N'Khu vực 18', 18), (19, N'Khu vực 19', 19), (20, N'Khu vực 20', 20),
(21, N'Khu vực 21', 21), (22, N'Khu vực 22', 22), (23, N'Khu vực 23', 23), (24, N'Khu vực 24', 24), (25, N'Khu vực 25', 25),
(26, N'Khu vực 26', 26), (27, N'Khu vực 27', 27), (28, N'Khu vực 28', 28), (29, N'Khu vực 29', 29), (30, N'Khu vực 30', 30);

-- Chèn dữ liệu mẫu vào bảng Owners
INSERT INTO Owners (OwnerID, Name, BirthDate, PhoneNumber, AreaID) VALUES
(1, N'Nguyễn Văn A', '1980-01-01', '0912345678', 1), (2, N'Trần Thị B', '1985-02-15', '0912345679', 2), 
(3, N'Lê Văn C', '1990-03-20', '0912345680', 3), (4, N'Phạm Thị D', '1995-04-10', '0912345681', 4),
(5, N'Hoàng Văn E', '1983-05-25', '0912345682', 5), (6, N'Đặng Thị F', '1987-06-30', '0912345683', 6),
(7, N'Bùi Văn G', '1992-07-15', '0912345684', 7), (8, N'Phan Thị H', '1996-08-05', '0912345685', 8),
(9, N'Vũ Văn I', '1989-09-19', '0912345686', 9), (10, N'Đỗ Thị J', '1994-10-10', '0912345687', 10),
(11, N'Nguyễn Văn K', '1980-01-11', '0912345678', 11), (12, N'Trần Thị L', '1985-02-25', '0912345679', 12), 
(13, N'Lê Văn M', '1990-03-30', '0912345680', 13), (14, N'Phạm Thị N', '1995-04-20', '0912345681', 14),
(15, N'Hoàng Văn O', '1983-05-15', '0912345682', 15), (16, N'Đặng Thị P', '1987-06-18', '0912345683', 16),
(17, N'Bùi Văn Q', '1992-07-25', '0912345684', 17), (18, N'Phan Thị R', '1996-08-10', '0912345685', 18),
(19, N'Vũ Văn S', '1989-09-29', '0912345686', 19), (20, N'Đỗ Thị T', '1994-10-20', '0912345687', 20),
(21, N'Nguyễn Văn U', '1980-01-21', '0912345678', 21), (22, N'Trần Thị V', '1985-02-22', '0912345679', 22), 
(23, N'Lê Văn W', '1990-03-23', '0912345680', 23), (24, N'Phạm Thị X', '1995-04-24', '0912345681', 24),
(25, N'Hoàng Văn Y', '1983-05-25', '0912345682', 25), (26, N'Đặng Thị Z', '1987-06-26', '0912345683', 26),
(27, N'Bùi Văn AA', '1992-07-27', '0912345684', 27), (28, N'Phan Thị BB', '1996-08-28', '0912345685', 28),
(29, N'Vũ Văn CC', '1989-09-29', '0912345686', 29), (30, N'Đỗ Thị DD', '1994-10-30', '0912345687', 30);

-- Chèn dữ liệu mẫu vào bảng Vehicles
INSERT INTO Vehicles (VehicleID, Type, OwnerID, RegistrationID) VALUES
(1, N'Xe máy', 1, 1), (2, N'Xe đạp', 2, 2), (3, N'Ô tô', 3, 3), (4, N'Xe máy', 4, 4), (5, N'Xe đạp', 5, 5),
(6, N'Ô tô', 6, 6), (7, N'Xe máy', 7, 7), (8, N'Xe đạp', 8, 8), (9, N'Ô tô', 9, 9), (10, N'Xe máy', 10, 10),
(11, N'Xe đạp', 11, 11), (12, N'Ô tô', 12, 12), (13, N'Xe máy', 13, 13), (14, N'Xe đạp', 14, 14), (15, N'Ô tô', 15, 15),
(16, N'Xe máy', 16, 16), (17, N'Xe đạp', 17, 17), (18, N'Ô tô', 18, 18), (19, N'Xe máy', 19, 19), (20, N'Xe đạp', 20, 20),
(21, N'Ô tô', 21, 21), (22, N'Xe máy', 22, 22), (23, N'Xe đạp', 23, 23), (24, N'Ô tô', 24, 24), (25, N'Xe máy', 25, 25),
(26, N'Xe đạp', 26, 26), (27, N'Ô tô', 27, 27), (28, N'Xe máy', 28, 28), (29, N'Xe đạp', 29, 29), (30, N'Ô tô', 30, 30);

-- Chèn dữ liệu mẫu vào bảng Registration
INSERT INTO Registration (RegistrationID, VehicleID, UserID, RegistrationDate, ExpirationDate) VALUES
(1, 1, 1, '2022-01-01', '2023-01-01'), (2, 2, 2, '2022-02-01', '2023-02-01'), (3, 3, 3, '2022-03-01', '2023-03-01'),
(4, 4, 4, '2022-04-01', '2023-04-01'), (5, 5, 5, '2022-05-01', '2023-05-01'), (6, 6, 6, '2022-06-01', '2023-06-01'),
(7, 7, 7, '2022-07-01', '2023-07-01'), (8, 8, 8, '2022-08-01', '2023-08-01'), (9, 9, 9, '2022-09-01', '2023-09-01'),
(10, 10, 10, '2022-10-01', '2023-10-01'), (11, 11, 11, '2022-11-01', '2023-11-01'), (12, 12, 12, '2022-12-01', '2023-12-01'),
(13, 13, 13, '2023-01-01', '2024-01-01'), (14, 14, 14, '2023-02-01', '2024-02-01'), (15, 15, 15, '2023-03-01', '2024-03-01'),
(16, 16, 16, '2023-04-01', '2024-04-01'), (17, 17, 17, '2023-05-01', '2024-05-01'), (18, 18, 18, '2023-06-01', '2024-06-01'),
(19, 19, 19, '2023-07-01', '2024-07-01'), (20, 20, 20, '2023-08-01', '2024-08-01'), (21, 21, 21, '2023-09-01', '2024-09-01'),
(22, 22, 22, '2023-10-01', '2024-10-01'), (23, 23, 23, '2023-11-01', '2024-11-01'), (24, 24, 24, '2023-12-01', '2024-12-01'),
(25, 25, 25, '2024-01-01', '2025-01-01'), (26, 26, 26, '2024-02-01', '2025-02-01'), (27, 27, 27, '2024-03-01', '2025-03-01'),
(28, 28, 28, '2024-04-01', '2025-04-01'), (29, 29, 29, '2024-05-01', '2025-05-01'), (30, 30, 30, '2024-06-01', '2025-06-01');

-- Chèn dữ liệu mẫu vào bảng Insurance
INSERT INTO Insurance (InsuranceID, VehicleID, Provider, PolicyNumber, StartDate, EndDate) VALUES
(1, 1, N'Bảo hiểm A', 'BH001', '2023-01-01', '2024-01-01'), (2, 2, N'Bảo hiểm B', 'BH002', '2023-02-01', '2024-02-01'),
(3, 3, N'Bảo hiểm C', 'BH003', '2023-03-01', '2024-03-01'), (4, 4, N'Bảo hiểm D', 'BH004', '2023-04-01', '2024-04-01'),
(5, 5, N'Bảo hiểm E', 'BH005', '2023-05-01', '2024-05-01'), (6, 6, N'Bảo hiểm F', 'BH006', '2023-06-01', '2024-06-01'),
(7, 7, N'Bảo hiểm G', 'BH007', '2023-07-01', '2024-07-01'), (8, 8, N'Bảo hiểm H', 'BH008', '2023-08-01', '2024-08-01'),
(9, 9, N'Bảo hiểm I', 'BH009', '2023-09-01', '2024-09-01'), (10, 10, N'Bảo hiểm J', 'BH010', '2023-10-01', '2024-10-01'),
(11, 11, N'Bảo hiểm K', 'BH011', '2023-11-01', '2024-11-01'), (12, 12, N'Bảo hiểm L', 'BH012', '2023-12-01', '2024-12-01'),
(13, 13, N'Bảo hiểm M', 'BH013', '2024-01-01', '2025-01-01'), (14, 14, N'Bảo hiểm N', 'BH014', '2024-02-01', '2025-02-01'),
(15, 15, N'Bảo hiểm O', 'BH015', '2024-03-01', '2025-03-01'), (16, 16, N'Bảo hiểm P', 'BH016', '2024-04-01', '2025-04-01'),
(17, 17, N'Bảo hiểm Q', 'BH017', '2024-05-01', '2025-05-01'), (18, 18, N'Bảo hiểm R', 'BH018', '2024-06-01', '2025-06-01'),
(19, 19, N'Bảo hiểm S', 'BH019', '2024-07-01', '2025-07-01'), (20, 20, N'Bảo hiểm T', 'BH020', '2024-08-01', '2025-08-01'),
(21, 21, N'Bảo hiểm U', 'BH021', '2024-09-01', '2025-09-01'), (22, 22, N'Bảo hiểm V', 'BH022', '2024-10-01', '2025-10-01'),
(23, 23, N'Bảo hiểm W', 'BH023', '2024-11-01', '2025-11-01'), (24, 24, N'Bảo hiểm X', 'BH024', '2024-12-01', '2025-12-01'),
(25, 25, N'Bảo hiểm Y', 'BH025', '2025-01-01', '2026-01-01'), (26, 26, N'Bảo hiểm Z', 'BH026', '2025-02-01', '2026-02-01'),
(27, 27, N'Bảo hiểm AA', 'BH027', '2025-03-01', '2026-03-01'), (28, 28, N'Bảo hiểm BB', 'BH028', '2025-04-01', '2026-04-01'),
(29, 29, N'Bảo hiểm CC', 'BH029', '2025-05-01', '2026-05-01'), (30, 30, N'Bảo hiểm DD', 'BH030', '2025-06-01', '2026-06-01');

-- Chèn dữ liệu mẫu vào bảng Inspection
INSERT INTO Inspection (InspectionID, VehicleID, InspectionDate, Result, NextInspectionDate) VALUES
(1, 1, '2023-01-01', N'Passed', '2024-01-01'), (2, 2, '2023-02-01', N'Failed', '2024-02-01'), 
(3, 3, '2023-03-01', N'Passed', '2024-03-01'), (4, 4, '2023-04-01', N'Passed', '2024-04-01'), 
(5, 5, '2023-05-01', N'Failed', '2024-05-01'), (6, 6, '2023-06-01', N'Passed', '2024-06-01'),
(7, 7, '2023-07-01', N'Failed', '2024-07-01'), (8, 8, '2023-08-01', N'Passed', '2024-08-01'),
(9, 9, '2023-09-01', N'Passed', '2024-09-01'), (10, 10, '2023-10-01', N'Failed', '2024-10-01'),
(11, 11, '2023-11-01', N'Passed', '2024-11-01'), (12, 12, '2023-12-01', N'Passed', '2024-12-01'),
(13, 13, '2024-01-01', N'Passed', '2025-01-01'), (14, 14, '2024-02-01', N'Failed', '2025-02-01'),
(15, 15, '2024-03-01', N'Passed', '2025-03-01'), (16, 16, '2024-04-01', N'Failed', '2025-04-01'),
(17, 17, '2024-05-01', N'Passed', '2025-05-01'), (18, 18, '2024-06-01', N'Passed', '2025-06-01'),
(19, 19, '2024-07-01', N'Passed', '2025-07-01'), (20, 20, '2024-08-01', N'Passed', '2025-08-01'),
(21, 21, '2024-09-01', N'Failed', '2025-09-01'), (22, 22, '2024-10-01', N'Passed', '2025-10-01'),
(23, 23, '2024-11-01', N'Failed', '2025-11-01'), (24, 24, '2024-12-01', N'Passed', '2025-12-01'),
(25, 25, '2025-01-01', N'Passed', '2026-01-01'), (26, 26, '2025-02-01', N'Failed', '2026-02-01'),
(27, 27, '2025-03-01', N'Passed', '2026-03-01'), (28, 28, '2025-04-01', N'Passed', '2026-04-01'),
(29, 29, '2025-05-01', N'Failed', '2026-05-01'), (30, 30, '2025-06-01', N'Passed', '2026-06-01');

-- Chèn dữ liệu mẫu vào bảng Camera
INSERT INTO Camera (CameraID, AreaID, VehicleID, Time, Number_Of_Violations) VALUES
(1, 1, 1, '2023-01-01 08:00:00', 2), (2, 2, 2, '2023-01-02 09:00:00', 1), (3, 3, 3, '2023-01-03 10:00:00', 3),
(4, 4, 4, '2023-01-04 11:00:00', 1), (5, 5, 5, '2023-01-05 12:00:00', 2), (6, 6, 6, '2023-01-06 13:00:00', 3),
(7, 7, 7, '2023-01-07 14:00:00', 1), (8, 8, 8, '2023-01-08 15:00:00', 2), (9, 9, 9, '2023-01-09 16:00:00', 1),
(10, 10, 10, '2023-01-10 17:00:00', 3), (11, 11, 11, '2023-01-11 18:00:00', 2), (12, 12, 12, '2023-01-12 19:00:00', 1),
(13, 13, 13, '2023-01-13 20:00:00', 3), (14, 14, 14, '2023-01-14 21:00:00', 2), (15, 15, 15, '2023-01-15 22:00:00', 1),
(16, 16, 16, '2023-01-16 23:00:00', 2), (17, 17, 17, '2023-01-17 07:00:00', 3), (18, 18, 18, '2023-01-18 06:00:00', 1),
(19, 19, 19, '2023-01-19 05:00:00', 2), (20, 20, 20, '2023-01-20 04:00:00', 3), (21, 21, 21, '2023-01-21 03:00:00', 1),
(22, 22, 22, '2023-01-22 02:00:00', 2), (23, 23, 23, '2023-01-23 01:00:00', 3), (24, 24, 24, '2023-01-24 00:00:00', 1),
(25, 25, 25, '2023-01-25 23:00:00', 2), (26, 26, 26, '2023-01-26 22:00:00', 3), (27, 27, 27, '2023-01-27 21:00:00', 1),
(28, 28, 28, '2023-01-28 20:00:00', 2), (29, 29, 29, '2023-01-29 19:00:00', 3), (30, 30, 30, '2023-01-30 18:00:00', 1);

-- Chèn dữ liệu mẫu vào bảng Violations
INSERT INTO Violations (ViolationID, Name, Fines) VALUES
(1, N'Vượt đèn đỏ', 500000), (2, N'Chạy quá tốc độ', 1000000), (3, N'Đi vào đường cấm', 200000),
(4, N'Không đội mũ bảo hiểm', 150000), (5, N'Không có giấy tờ xe', 300000), (6, N'Không có bảo hiểm xe', 400000),
(7, N'Chở quá số người quy định', 600000), (8, N'Đi ngược chiều', 700000), (9, N'Dừng xe trái phép', 250000),
(10, N'Không bật đèn tín hiệu', 100000), (11, N'Điện thoại khi lái xe', 500000), (12, N'Sử dụng rượu bia khi lái xe', 1500000),
(13, N'Đi vào làn đường khẩn cấp', 300000), (14, N'Đi sai làn đường', 450000), (15, N'Không nhường đường cho xe ưu tiên', 200000),
(16, N'Không chấp hành hiệu lệnh của CSGT', 500000), (17, N'Đi vào đường cấm', 200000), (18, N'Không có giấy phép lái xe', 1000000),
(19, N'Không có giấy tờ xe', 300000), (20, N'Không có bảo hiểm xe', 400000), (21, N'Chở quá số người quy định', 600000),
(22, N'Đi ngược chiều', 700000), (23, N'Dừng xe trái phép', 250000), (24, N'Không bật đèn tín hiệu', 100000), (25, N'Điện thoại khi lái xe', 500000),
(26, N'Sử dụng rượu bia khi lái xe', 1500000), (27, N'Đi vào làn đường khẩn cấp', 300000), (28, N'Đi sai làn đường', 450000), (29, N'Không nhường đường cho xe ưu tiên', 200000), (30, N'Không chấp hành hiệu lệnh của CSGT', 500000);

-- Chèn dữ liệu mẫu vào bảng ViolationRecords
INSERT INTO ViolationRecords (RecordID, CameraID, ViolationID, Time, Image) VALUES
(1, 1, 1, '2023-01-01 08:00:00', NULL), (2, 2, 2, '2023-01-02 09:00:00', NULL), (3, 3, 3, '2023-01-03 10:00:00', NULL),
(4, 4, 4, '2023-01-04 11:00:00', NULL), (5, 5, 5, '2023-01-05 12:00:00', NULL), (6, 6, 6, '2023-01-06 13:00:00', NULL),
(7, 7, 7, '2023-01-07 14:00:00', NULL), (8, 8, 8, '2023-01-08 15:00:00', NULL), (9, 9, 9, '2023-01-09 16:00:00', NULL),
(10, 10, 10, '2023-01-10 17:00:00', NULL), (11, 11, 11, '2023-01-11 18:00:00', NULL), (12, 12, 12, '2023-01-12 19:00:00', NULL),
(13, 13, 13, '2023-01-13 20:00:00', NULL), (14, 14, 14, '2023-01-14 21:00:00', NULL), (15, 15, 15, '2023-01-15 22:00:00', NULL),
(16, 16, 16, '2023-01-16 23:00:00', NULL), (17, 17, 17, '2023-01-17 07:00:00', NULL), (18, 18, 18, '2023-01-18 06:00:00', NULL),
(19, 19, 19, '2023-01-19 05:00:00', NULL), (20, 20, 20, '2023-01-20 04:00:00', NULL), (21, 21, 21, '2023-01-21 03:00:00', NULL),
(22, 22, 22, '2023-01-22 02:00:00', NULL), (23, 23, 23, '2023-01-23 01:00:00', NULL), (24, 24, 24, '2023-01-24 00:00:00', NULL),
(25, 25, 25, '2023-01-25 23:00:00', NULL), (26, 26, 26, '2023-01-26 22:00:00', NULL), (27, 27, 27, '2023-01-27 21:00:00', NULL),
(28, 28, 28, '2023-01-28 20:00:00', NULL), (29, 29, 29, '2023-01-29 19:00:00', NULL), (30, 30, 30, '2023-01-30 18:00:00', NULL);

-- Chèn dữ liệu mẫu vào bảng Departments
INSERT INTO Departments (DepartmentID, ManagerID, AreaID, StartTime, EndTime, Status) VALUES
(1, 1, 1, '2023-01-01 08:00:00', '2023-01-01 17:00:00', N'Active'), (2, 2, 2, '2023-01-02 08:00:00', '2023-01-02 17:00:00', N'Active'), 
(3, 3, 3, '2023-01-03 08:00:00', '2023-01-03 17:00:00', N'Inactive'), (4, 4, 4, '2023-01-04 08:00:00', '2023-01-04 17:00:00', N'Active'), 
(5, 5, 5, '2023-01-05 08:00:00', '2023-01-05 17:00:00', N'Inactive'), (6, 6, 6, '2023-01-06 08:00:00', '2023-01-06 17:00:00', N'Active'),
(7, 7, 7, '2023-01-07 08:00:00', '2023-01-07 17:00:00', N'Inactive'), (8, 8, 8, '2023-01-08 08:00:00', '2023-01-08 17:00:00', N'Active'),
(9, 9, 9, '2023-01-09 08:00:00', '2023-01-09 17:00:00', N'Inactive'), (10, 10, 10, '2023-01-10 08:00:00', '2023-01-10 17:00:00', N'Active'),
(11, 11, 11, '2023-01-11 08:00:00', '2023-01-11 17:00:00', N'Inactive'), (12, 12, 12, '2023-01-12 08:00:00', '2023-01-12 17:00:00', N'Active'),
(13, 13, 13, '2023-01-13 08:00:00', '2023-01-13 17:00:00', N'Inactive'), (14, 14, 14, '2023-01-14 08:00:00', '2023-01-14 17:00:00', N'Active'),
(15, 15, 15, '2023-01-15 08:00:00', '2023-01-15 17:00:00', N'Inactive'), (16, 16, 16, '2023-01-16 08:00:00', '2023-01-16 17:00:00', N'Active'),
(17, 17, 17, '2023-01-17 08:00:00', '2023-01-17 17:00:00', N'Inactive'), (18, 18, 18, '2023-01-18 08:00:00', '2023-01-18 17:00:00', N'Active'),
(19, 19, 19, '2023-01-19 08:00:00', '2023-01-19 17:00:00', N'Inactive'), (20, 20, 20, '2023-01-20 08:00:00', '2023-01-20 17:00:00', N'Active'),
(21, 21, 21, '2023-01-21 08:00:00', '2023-01-21 17:00:00', N'Inactive'), (22, 22, 22, '2023-01-22 08:00:00', '2023-01-22 17:00:00', N'Active'),
(23, 23, 23, '2023-01-23 08:00:00', '2023-01-23 17:00:00', N'Inactive'), (24, 24, 24, '2023-01-24 08:00:00', '2023-01-24 17:00:00', N'Active'),
(25, 25, 25, '2023-01-25 08:00:00', '2023-01-25 17:00:00', N'Inactive'), (26, 26, 26, '2023-01-26 08:00:00', '2023-01-26 17:00:00', N'Active'),
(27, 27, 27, '2023-01-27 08:00:00', '2023-01-27 17:00:00', N'Inactive'), (28, 28, 28, '2023-01-28 08:00:00', '2023-01-28 17:00:00', N'Active'),
(29, 29, 29, '2023-01-29 08:00:00', '2023-01-29 17:00:00', N'Inactive'), (30, 30, 30, '2023-01-30 08:00:00', '2023-01-30 17:00:00', N'Active');

-- Chèn dữ liệu mẫu vào bảng Managers
INSERT INTO Managers (ManagerID, Name, BirthDate, PhoneNumber, AreaID) VALUES
(1, N'Nguyễn Văn A', '1980-01-01', '0912345678', 1), (2, N'Trần Thị B', '1985-02-15', '0912345679', 2), 
(3, N'Lê Văn C', '1990-03-20', '0912345680', 3), (4, N'Phạm Thị D', '1995-04-10', '0912345681', 4),
(5, N'Hoàng Văn E', '1983-05-25', '0912345682', 5), (6, N'Đặng Thị F', '1987-06-30', '0912345683', 6),
(7, N'Bùi Văn G', '1992-07-15', '0912345684', 7), (8, N'Phan Thị H', '1996-08-05', '0912345685', 8),
(9, N'Vũ Văn I', '1989-09-19', '0912345686', 9), (10, N'Đỗ Thị J', '1994-10-10', '0912345687', 10),
(11, N'Nguyễn Văn K', '1980-01-11', '0912345678', 11), (12, N'Trần Thị L', '1985-02-25', '0912345679', 12), 
(13, N'Lê Văn M', '1990-03-30', '0912345680', 13), (14, N'Phạm Thị N', '1995-04-20', '0912345681', 14),
(15, N'Hoàng Văn O', '1983-05-15', '0912345682', 15), (16, N'Đặng Thị P', '1987-06-18', '0912345683', 16),
(17, N'Bùi Văn Q', '1992-07-25', '0912345684', 17), (18, N'Phan Thị R', '1996-08-10', '0912345685', 18),
(19, N'Vũ Văn S', '1989-09-29', '0912345686', 19), (20, N'Đỗ Thị T', '1994-10-20', '0912345687', 20),
(21, N'Nguyễn Văn U', '1980-01-21', '0912345678', 21), (22, N'Trần Thị V', '1985-02-22', '0912345679', 22), 
(23, N'Lê Văn W', '1990-03-23', '0912345680', 23), (24, N'Phạm Thị X', '1995-04-24', '0912345681', 24),
(25, N'Hoàng Văn Y', '1983-05-25', '0912345682', 25), (26, N'Đặng Thị Z', '1987-06-26', '0912345683', 26),
(27, N'Bùi Văn AA', '1992-07-27', '0912345684', 27), (28, N'Phan Thị BB', '1996-08-28', '0912345685', 28),
(29, N'Vũ Văn CC', '1989-09-29', '0912345686', 29), (30, N'Đỗ Thị DD', '1994-10-30', '0912345687', 30);

-- Chèn dữ liệu mẫu vào bảng Users
INSERT INTO Users (UserID, Username, Password, Role, OwnerID) VALUES
(1, N'user1', N'password1', N'Owner', 1), (2, N'user2', N'password2', N'Owner', 2), 
(3, N'user3', N'password3', N'Owner', 3), (4, N'user4', N'password4', N'Owner', 4), 
(5, N'user5', N'password5', N'Owner', 5), (6, N'user6', N'password6', N'Owner', 6), 
(7, N'user7', N'password7', N'Owner', 7), (8, N'user8', N'password8', N'Owner', 8), 
(9, N'user9', N'password9', N'Owner', 9), (10, N'user10', N'password10', N'Owner', 10), 
(11, N'user11', N'password11', N'Owner', 11), (12, N'user12', N'password12', N'Owner', 12), 
(13, N'user13', N'password13', N'Owner', 13), (14, N'user14', N'password14', N'Owner', 14), 
(15, N'user15', N'password15', N'Owner', 15), (16, N'user16', N'password16', N'Owner', 16), 
(17, N'user17', N'password17', N'Owner', 17), (18, N'user18', N'password18', N'Owner', 18), 
(19, N'user19', N'password19', N'Owner', 19), (20, N'user20', N'password20', N'Owner', 20), 
(21, N'user21', N'password21', N'Owner', 21), (22, N'user22', N'password22', N'Owner', 22), 
(23, N'user23', N'password23', N'Owner', 23), (24, N'user24', N'password24', N'Owner', 24), 
(25, N'user25', N'password25', N'Owner', 25), (26, N'user26', N'password26', N'Owner', 26), 
(27, N'user27', N'password27', N'Owner', 27), (28, N'user28', N'password28', N'Owner', 28), 
(29, N'user29', N'password29', N'Owner', 29), (30, N'user30', N'password30', N'Owner', 30);

-- Chèn dữ liệu mẫu vào bảng ManagerArea
INSERT INTO ManagerArea (ManagerID, AreaID) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7), (8, 8), (9, 9), (10, 10),
(11, 11), (12, 12), (13, 13), (14, 14), (15, 15), (16, 16), (17, 17), (18, 18), (19, 19), (20, 20),
(21, 21), (22, 22), (23, 23), (24, 24), (25, 25), (26, 26), (27, 27), (28, 28), (29, 29), (30, 30);

-- Chèn dữ liệu mẫu vào bảng Payment
INSERT INTO Payment (PaymentID, OwnerID, ViolationID, Amount, Status) VALUES
(1, 1, 1, 500000, N'Paid'), (2, 2, 2, 1000000, N'Unpaid'), (3, 3, 3, 200000, N'Paid'), 
(4, 4, 4, 150000, N'Unpaid'), (5, 5, 5, 300000, N'Paid'), (6, 6, 6, 400000, N'Unpaid'),
(7, 7, 7, 600000, N'Paid'), (8, 8, 8, 700000, N'Unpaid'), (9, 9, 9, 250000, N'Paid'), 
(10, 10, 10, 100000, N'Unpaid'), (11, 11, 11, 500000, N'Paid'), (12, 12, 12, 1500000, N'Unpaid'),
(13, 13, 13, 300000, N'Paid'), (14, 14, 14, 450000, N'Unpaid'), (15, 15, 15, 200000, N'Paid'), 
(16, 16, 16, 500000, N'Unpaid'), (17, 17, 17, 200000, N'Paid'), (18, 18, 18, 1000000, N'Unpaid'),
(19, 19, 19, 300000, N'Paid'), (20, 20, 20, 400000, N'Unpaid'), (21, 21, 21, 600000, N'Paid'), 
(22, 22, 22, 700000, N'Unpaid'), (23, 23, 23, 250000, N'Paid'), (24, 24, 24, 100000, N'Unpaid'), 
(25, 25, 25, 500000, N'Paid'), (26, 26, 26, 1500000, N'Unpaid'), (27, 27, 27, 300000, N'Paid'), 
(28, 28, 28, 450000, N'Unpaid'), (29, 29, 29, 200000, N'Paid'), (30, 30, 30, 500000, N'Unpaid');


