--Hi?n th? thông tin ph??ng ti?n và ch? s? h?u
SELECT 
    V.VehicleID, 
    V.Type, 
    O.Name AS OwnerName, 
    O.PhoneNumber AS OwnerPhone 
FROM 
    Vehicles V
JOIN 
    Owners O ON V.OwnerID = O.OwnerID;

-- Hi?n th? các vi ph?m giao thông ?ã ghi l?i
SELECT 
    VR.ViolationRecordID, 
    VR.Time, 
    VR.Image, 
    V.Name AS ViolationName, 
    C.CameraID 
FROM 
    ViolationRecords VR
JOIN 
    Violations V ON VR.ViolationID = V.ViolationID
JOIN 
    Camera C ON VR.CameraID = C.CameraID;

--Hi?n th? thông tin b?o hi?m c?a các ph??ng ti?n
SELECT 
    I.InsuranceID, 
    I.Provider, 
    I.PolicyNumber, 
    I.StartDate, 
    I.EndDate, 
    V.VehicleID, 
    V.Type 
FROM 
    Insurance I
JOIN 
    Vehicles V ON I.VehicleID = V.VehicleID;

--Hi?n th? thông tin ki?m ??nh ph??ng ti?n
SELECT 
    INSP.InspectionID, 
    INSP.InspectionDate, 
    INSP.Result, 
    INSP.NextInspectionDate, 
    V.VehicleID, 
    V.Type 
FROM 
    Inspection INSP
JOIN 
    Vehicles V ON INSP.VehicleID = V.VehicleID;

--Hi?n th? danh sách các ph??ng ti?n vi ph?m và m?c ph?t t??ng ?ng
SELECT 
    VR.ViolationRecordID, 
    VR.Time, 
    V.Name AS ViolationName, 
    VI.Fines, 
    VH.VehicleID, 
    VH.Type 
FROM 
    ViolationRecords VR
JOIN 
    Violations VI ON VR.ViolationID = VI.ViolationID
JOIN 
    Vehicles VH ON VR.VehicleID = VH.VehicleID;

--Hi?n th? các ph??ng ti?n thu?c m?t khu v?c c? th?
SELECT 
    V.VehicleID, 
    V.Type, 
    O.Name AS OwnerName, 
    A.AreaName 
FROM 
    Vehicles V
JOIN 
    Owners O ON V.OwnerID = O.OwnerID
JOIN 
    Area A ON O.AreaID = A.AreaID
WHERE 
    A.AreaName = N'Tên Khu V?c';

--Hi?n th? danh sách các ph??ng ti?n và thông tin ??ng ký
SELECT 
    V.VehicleID, 
    V.Type, 
    R.RegistrationDate, 
    R.ExpirationDate, 
    U.Username 
FROM 
    Vehicles V
JOIN 
    Registration R ON V.RegistrationID = R.RegistrationID
JOIN 
    Users U ON R.UserID = U.UserID;

--Hi?n th? các ph??ng ti?n ???c qu?n lý b?i m?t phòng ban c? th?
SELECT 
    V.VehicleID, 
    V.Type, 
    D.DepartmentID, 
    D.ManagerID, 
    M.Name AS ManagerName 
FROM 
    Vehicles V
JOIN 
    Departments D ON V.OwnerID = D.ManagerID
JOIN 
    Managers M ON D.ManagerID = M.ManagerID
WHERE 
    D.DepartmentID = 1;  -- Thay 1 b?ng mã phòng ban c? th?

--Hi?n th? s? l?n vi ph?m c?a m?i ph??ng ti?n
SELECT 
    V.VehicleID, 
    V.Type, 
    COUNT(VR.ViolationID) AS NumberOfViolations 
FROM 
    Vehicles V
JOIN 
    Camera C ON V.VehicleID = C.VehicleID
JOIN 
    ViolationRecords VR ON C.CameraID = VR.CameraID
GROUP BY 
    V.VehicleID, V.Type;

--Hi?n th? danh sách các ph??ng ti?n v?i b?o hi?m s?p h?t h?n
SELECT 
    I.InsuranceID, 
    I.Provider, 
    I.PolicyNumber, 
    I.EndDate, 
    V.VehicleID, 
    V.Type 
FROM 
    Insurance I
JOIN 
    Vehicles V ON I.VehicleID = V.VehicleID
WHERE 
    I.EndDate < GETDATE() + 30;  -- Hi?n th? b?o hi?m h?t h?n trong vòng 30 ngày t?i


--Hi?n th? danh sách các ph??ng ti?n và thông tin ??ng ký c?a chúng
SELECT 
    V.VehicleID, 
    V.Type, 
    R.RegistrationDate, 
    R.ExpirationDate, 
    U.Username 
FROM 
    Vehicles V
JOIN 
    Registration R ON V.RegistrationID = R.RegistrationID
JOIN 
    Users U ON R.UserID = U.UserID;

--Hi?n th? danh sách các ph??ng ti?n vi ph?m cùng m?c ph?t t??ng ?ng
SELECT 
    V.VehicleID, 
    V.Type, 
    VR.Time, 
    VI.Name AS ViolationName, 
    VI.Fines 
FROM 
    Vehicles V
JOIN 
    Camera C ON V.VehicleID = C.VehicleID
JOIN 
    ViolationRecords VR ON C.CameraID = VR.CameraID
JOIN 
    Violations VI ON VR.ViolationID = VI.ViolationID;
