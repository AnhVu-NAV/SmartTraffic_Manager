---Procedures
--Stored Procedure ?? thêm m?t ph??ng ti?n m?i
CREATE PROCEDURE AddVehicle
    @Type NVARCHAR(50),
    @OwnerID INT,
    @RegistrationID INT
AS
BEGIN
    INSERT INTO Vehicles (Type, OwnerID, RegistrationID)
    VALUES (@Type, @OwnerID, @RegistrationID);
END;

-- Stored Procedure ?? c?p nh?t thông tin b?o hi?m
CREATE PROCEDURE UpdateInsurance
    @InsuranceID INT,
    @Provider NVARCHAR(100),
    @PolicyNumber NVARCHAR(50),
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    UPDATE Insurance
    SET Provider = @Provider, PolicyNumber = @PolicyNumber, StartDate = @StartDate, EndDate = @EndDate
    WHERE InsuranceID = @InsuranceID;
END;


--Stored Procedure ?? xoá m?t vi ph?m giao thông
CREATE PROCEDURE DeleteViolation
    @ViolationID INT
AS
BEGIN
    DELETE FROM Violations
    WHERE ViolationID = @ViolationID;
END;

--Stored Procedure ?? thêm m?t vi ph?m m?i
CREATE PROCEDURE AddViolationRecord
    @CameraID INT,
    @ViolationID INT,
    @Time DATETIME,
    @Image VARBINARY(MAX)
AS
BEGIN
    INSERT INTO ViolationRecords (CameraID, ViolationID, Time, Image)
    VALUES (@CameraID, @ViolationID, @Time, @Image);
END;



---Triggers
-- Trigger ?? t? ??ng c?p nh?t s? l?n vi ph?m c?a ph??ng ti?n khi thêm m?t b?n ghi vi ph?m m?i
CREATE TRIGGER UpdateViolationCount
ON ViolationRecords
AFTER INSERT
AS
BEGIN
    UPDATE Vehicles
    SET Number_Of_Violations = (SELECT COUNT(*) FROM ViolationRecords WHERE VehicleID = inserted.VehicleID)
    FROM inserted
    WHERE Vehicles.VehicleID = inserted.VehicleID;
END;

--Trigger ?? ki?m tra ngày h?t h?n c?a b?o hi?m tr??c khi thêm ho?c c?p nh?t b?o hi?m
CREATE TRIGGER CheckInsuranceExpiry
ON Insurance
BEFORE INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE EndDate < GETDATE())
    BEGIN
        RAISERROR ('EndDate cannot be in the past', 16, 1);
        ROLLBACK TRANSACTION;
    END;
END;

--Trigger ?? ghi l?i l?ch s? c?p nh?t thông tin ph??ng ti?n
CREATE TRIGGER LogVehicleUpdate
ON Vehicles
AFTER UPDATE
AS
BEGIN
    INSERT INTO VehicleUpdateLog (VehicleID, UpdateDate, UpdatedBy)
    SELECT 
        inserted.VehicleID, 
        GETDATE(), 
        SYSTEM_USER
    FROM inserted;
END;


---User-Defined Functions
--Function ?? tính tu?i c?a ch? s? h?u ph??ng ti?n
CREATE FUNCTION CalculateAge(@BirthDate DATE)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(YEAR, @BirthDate, GETDATE());
END;


-- Function ?? l?y tên ch? s? h?u t? ID ph??ng ti?n
CREATE FUNCTION GetOwnerName(@VehicleID INT)
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @OwnerName NVARCHAR(100);
    SELECT @OwnerName = O.Name
    FROM Owners O
    JOIN Vehicles V ON O.OwnerID = V.OwnerID
    WHERE V.VehicleID = @VehicleID;
    RETURN @OwnerName;
END;
--Function ?? ki?m tra xem ph??ng ti?n có vi ph?m trong m?t kho?ng th?i gian c? th? hay không
CREATE FUNCTION HasViolationsInPeriod(@VehicleID INT, @StartDate DATETIME, @EndDate DATETIME)
RETURNS BIT
AS
BEGIN
    DECLARE @HasViolations BIT;
    IF EXISTS (
        SELECT 1 
        FROM ViolationRecords VR
        JOIN Camera C ON VR.CameraID = C.CameraID
        WHERE C.VehicleID = @VehicleID AND VR.Time BETWEEN @StartDate AND @EndDate
    )
    BEGIN
        SET @HasViolations = 1;
    END
    ELSE
    BEGIN
        SET @HasViolations = 0;
    END
    RETURN @HasViolations;
END;


---Views
--View ?? hi?n th? thông tin ph??ng ti?n và ch? s? h?u
CREATE VIEW VehicleOwnerInfo AS
SELECT 
    V.VehicleID, 
    V.Type, 
    O.Name AS OwnerName, 
    O.PhoneNumber AS OwnerPhone 
FROM 
    Vehicles V
JOIN 
    Owners O ON V.OwnerID = O.OwnerID;

--View ?? hi?n th? các vi ph?m giao thông ?ã ghi l?i
CREATE VIEW RecordedViolations AS
SELECT 
    VR.ViolationRecordID, 
    VR.Time, 
    V.Name AS ViolationName, 
    VR.Image, 
    C.CameraID 
FROM 
    ViolationRecords VR
JOIN 
    Violations V ON VR.ViolationID = V.ViolationID
JOIN 
    Camera C ON VR.CameraID = C.CameraID;



