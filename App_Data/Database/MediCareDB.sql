-- ============================================================================
-- MediCare Pharmacy Management System Database Script
-- Target: Microsoft SQL Server 2016+ / LocalDB
-- Generated from existing project database schema and seed data
-- ============================================================================

USE [master];
GO

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'mediCare')
BEGIN
    CREATE DATABASE [mediCare];
END
GO

USE [mediCare];
GO

-- --------------------------------------------------
-- Table: [regi_tbl]
-- --------------------------------------------------
IF OBJECT_ID(N'dbo.[regi_tbl]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[regi_tbl] (
        [Id] int IDENTITY(1,1) NOT NULL,
        [FirstName] nvarchar(MAX) NOT NULL,
        [LastName] nvarchar(MAX) NOT NULL,
        [Email] nvarchar(MAX) NOT NULL,
        [Phone] nvarchar(MAX) NOT NULL,
        [DOB] nvarchar(MAX) NOT NULL,
        [Gender] nvarchar(MAX) NOT NULL,
        [Password] nvarchar(MAX) NOT NULL,
        [Address] nvarchar(MAX) NOT NULL,
        [Role] varchar(20) NOT NULL DEFAULT ('Customer'),
        CONSTRAINT [PK_regi_tbl] PRIMARY KEY CLUSTERED ([Id] ASC)
    );
END
GO

SET IDENTITY_INSERT [dbo].[regi_tbl] ON;
GO
IF NOT EXISTS (SELECT 1 FROM [dbo].[regi_tbl] WHERE [Id] = 1)
    INSERT INTO [dbo].[regi_tbl] ([Id], [FirstName], [LastName], [Email], [Phone], [DOB], [Gender], [Password], [Address], [Role]) VALUES (1, N'Vishal', N'Parmar', N'vishal@gmail.com', N'1234567890', N'2007-01-28', N'Male', N'12345678', N'Morbi.', N'Admin');
IF NOT EXISTS (SELECT 1 FROM [dbo].[regi_tbl] WHERE [Id] = 4)
    INSERT INTO [dbo].[regi_tbl] ([Id], [FirstName], [LastName], [Email], [Phone], [DOB], [Gender], [Password], [Address], [Role]) VALUES (4, N'Prince', N'Nimavat', N'prince@gmail.com', N'1234567890', N'2026-04-15', N'Male', N'prince123', N'rajkot', N'Customer');
IF NOT EXISTS (SELECT 1 FROM [dbo].[regi_tbl] WHERE [Id] = 6)
    INSERT INTO [dbo].[regi_tbl] ([Id], [FirstName], [LastName], [Email], [Phone], [DOB], [Gender], [Password], [Address], [Role]) VALUES (6, N'Amrut', N'Sabaliya', N'amrut@gmail.com', N'1234567890', N'2006-09-14', N'  Male', N'12345678', N'Rajkot.', N'Customer');
SET IDENTITY_INSERT [dbo].[regi_tbl] OFF;
GO

-- --------------------------------------------------
-- Table: [brands_tbl]
-- --------------------------------------------------
IF OBJECT_ID(N'dbo.[brands_tbl]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[brands_tbl] (
        [BrandID] int IDENTITY(1,1) NOT NULL,
        [BrandCode] nvarchar(40) NOT NULL,
        [Name] nvarchar(200) NOT NULL,
        [Country] nvarchar(200) NOT NULL,
        [Description] nvarchar(1000) NULL,
        [LogoUrl] nvarchar(600) NULL DEFAULT (''),
        [ProductCount] int NOT NULL DEFAULT ((0)),
        [Status] nvarchar(40) NOT NULL DEFAULT ('Active'),
        [CreatedAt] datetime NOT NULL DEFAULT (getdate()),
        CONSTRAINT [PK_brands_tbl] PRIMARY KEY CLUSTERED ([BrandID] ASC)
    );
END
GO

SET IDENTITY_INSERT [dbo].[brands_tbl] ON;
GO
IF NOT EXISTS (SELECT 1 FROM [dbo].[brands_tbl] WHERE [BrandID] = 1)
    INSERT INTO [dbo].[brands_tbl] ([BrandID], [BrandCode], [Name], [Country], [Description], [LogoUrl], [ProductCount], [Status], [CreatedAt]) VALUES (1, N'B001', N'BioPharma Laboratories', N'India', N'Leading provider of generic and OTC medications', N'/assets/images/brands/biopharma.png', 45, N'Active', '2026-01-01 10:00:00.000');
IF NOT EXISTS (SELECT 1 FROM [dbo].[brands_tbl] WHERE [BrandID] = 2)
    INSERT INTO [dbo].[brands_tbl] ([BrandID], [BrandCode], [Name], [Country], [Description], [LogoUrl], [ProductCount], [Status], [CreatedAt]) VALUES (2, N'B002', N'MedCure Healthcare', N'India', N'Specialized formulations and chronic care treatments', N'/assets/images/brands/medcure.png', 32, N'Active', '2026-01-01 10:00:00.000');
IF NOT EXISTS (SELECT 1 FROM [dbo].[brands_tbl] WHERE [BrandID] = 3)
    INSERT INTO [dbo].[brands_tbl] ([BrandID], [BrandCode], [Name], [Country], [Description], [LogoUrl], [ProductCount], [Status], [CreatedAt]) VALUES (3, N'B003', N'VitaBoost Wellness', N'USA', N'Premium nutritional supplements and herbal wellness', N'/assets/images/brands/vitaboost.png', 28, N'Active', '2026-01-01 10:00:00.000');
IF NOT EXISTS (SELECT 1 FROM [dbo].[brands_tbl] WHERE [BrandID] = 4)
    INSERT INTO [dbo].[brands_tbl] ([BrandID], [BrandCode], [Name], [Country], [Description], [LogoUrl], [ProductCount], [Status], [CreatedAt]) VALUES (4, N'B004', N'GastroCare Pharma', N'India', N'Gastroenterology and digestive health specialists', N'/assets/images/brands/gastrocare.png', 19, N'Active', '2026-01-01 10:00:00.000');
SET IDENTITY_INSERT [dbo].[brands_tbl] OFF;
GO

-- --------------------------------------------------
-- Table: [categories_tbl]
-- --------------------------------------------------
IF OBJECT_ID(N'dbo.[categories_tbl]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[categories_tbl] (
        [CategoryID] int IDENTITY(1,1) NOT NULL,
        [Name] nvarchar(200) NOT NULL,
        [Icon] nvarchar(20) NULL,
        [IconClass] nvarchar(200) NULL,
        [Description] nvarchar(1000) NULL,
        [Color] nvarchar(40) NULL,
        [Status] nvarchar(40) NOT NULL DEFAULT ('Active'),
        [CreatedAt] datetime NOT NULL DEFAULT (getdate()),
        CONSTRAINT [PK_categories_tbl] PRIMARY KEY CLUSTERED ([CategoryID] ASC)
    );
END
GO

SET IDENTITY_INSERT [dbo].[categories_tbl] ON;
GO
IF NOT EXISTS (SELECT 1 FROM [dbo].[categories_tbl] WHERE [CategoryID] = 1)
    INSERT INTO [dbo].[categories_tbl] ([CategoryID], [Name], [Icon], [IconClass], [Description], [Color], [Status], [CreatedAt]) VALUES (1, N'Pain', N'p', NULL, N'pain', NULL, N'Inactive', '2026-10-07 09:20:03.973');
IF NOT EXISTS (SELECT 1 FROM [dbo].[categories_tbl] WHERE [CategoryID] = 2)
    INSERT INTO [dbo].[categories_tbl] ([CategoryID], [Name], [Icon], [IconClass], [Description], [Color], [Status], [CreatedAt]) VALUES (2, N'Fever ', N'f', NULL, N'fever', NULL, N'Active', '2026-10-07 10:35:57.483');
SET IDENTITY_INSERT [dbo].[categories_tbl] OFF;
GO

-- --------------------------------------------------
-- Table: [suppliers_tbl]
-- --------------------------------------------------
IF OBJECT_ID(N'dbo.[suppliers_tbl]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[suppliers_tbl] (
        [SupplierID] int IDENTITY(1,1) NOT NULL,
        [SupplierCode] nvarchar(40) NOT NULL,
        [CompanyName] nvarchar(400) NOT NULL,
        [ContactPerson] nvarchar(200) NULL,
        [PhoneNumber] nvarchar(40) NULL,
        [Email] nvarchar(300) NULL,
        [City] nvarchar(200) NULL,
        [Address] nvarchar(1000) NULL,
        [GSTNumber] nvarchar(100) NULL,
        [DrugLicense] nvarchar(100) NULL,
        [Notes] nvarchar(1000) NULL,
        [Status] nvarchar(40) NOT NULL DEFAULT ('Active'),
        [CreatedAt] datetime NOT NULL DEFAULT (getdate()),
        CONSTRAINT [PK_suppliers_tbl] PRIMARY KEY CLUSTERED ([SupplierID] ASC)
    );
END
GO

SET IDENTITY_INSERT [dbo].[suppliers_tbl] ON;
GO
IF NOT EXISTS (SELECT 1 FROM [dbo].[suppliers_tbl] WHERE [SupplierID] = 1)
    INSERT INTO [dbo].[suppliers_tbl] ([SupplierID], [SupplierCode], [CompanyName], [ContactPerson], [PhoneNumber], [Email], [City], [Address], [GSTNumber], [DrugLicense], [Notes], [Status], [CreatedAt]) VALUES (1, N'S001', N'Sun Pharma Distributors', N'Ramesh Patel', N'9876543210', N'ramesh@sunpharma.com', N'Mumbai', N'Plot 12, MIDC Industrial Area, Andheri East', N'27AABCS1429B1Z1', N'MH-MUM-DL-1092', N'Primary supplier for pain relief and antibiotics', N'Inactive', '2026-01-01 10:00:00.000');
IF NOT EXISTS (SELECT 1 FROM [dbo].[suppliers_tbl] WHERE [SupplierID] = 2)
    INSERT INTO [dbo].[suppliers_tbl] ([SupplierID], [SupplierCode], [CompanyName], [ContactPerson], [PhoneNumber], [Email], [City], [Address], [GSTNumber], [DrugLicense], [Notes], [Status], [CreatedAt]) VALUES (2, N'S002', N'Cipla Wholesale Ltd', N'Kavita Singh', N'9123456789', N'kavita@cipla.com', N'Pune', N'Cipla House, Shivaji Nagar', N'27AABCC2039K1Z5', N'MH-PUN-DL-2204', N'Reliable supplier for chronic care medicines', N'Active', '2026-01-01 10:00:00.000');
IF NOT EXISTS (SELECT 1 FROM [dbo].[suppliers_tbl] WHERE [SupplierID] = 3)
    INSERT INTO [dbo].[suppliers_tbl] ([SupplierID], [SupplierCode], [CompanyName], [ContactPerson], [PhoneNumber], [Email], [City], [Address], [GSTNumber], [DrugLicense], [Notes], [Status], [CreatedAt]) VALUES (3, N'S003', N'Abbott Logistics India', N'Deepak Sharma', N'8765432109', N'deepak@abbott.com', N'Delhi', N'Connaught Place, Central Delhi', N'07AABCA3310M1Z8', N'DL-DEL-DL-3391', N'Authorized distributor for vitamins and infant formulas', N'Active', '2026-01-01 10:00:00.000');
IF NOT EXISTS (SELECT 1 FROM [dbo].[suppliers_tbl] WHERE [SupplierID] = 4)
    INSERT INTO [dbo].[suppliers_tbl] ([SupplierID], [SupplierCode], [CompanyName], [ContactPerson], [PhoneNumber], [Email], [City], [Address], [GSTNumber], [DrugLicense], [Notes], [Status], [CreatedAt]) VALUES (4, N'S004', N'Dr. Reddy''s Supply Chain', N'Anil Kumar', N'6543210987', N'anil@drreddys.com', N'Bangalore', N'Electronic City Phase 1', N'29AABCD4411P1Z3', N'KA-BLR-DL-5521', N'Secondary distributor for cardiology medicines', N'Active', '2026-01-01 10:00:00.000');
SET IDENTITY_INSERT [dbo].[suppliers_tbl] OFF;
GO

-- --------------------------------------------------
-- Table: [pharmacists_tbl]
-- --------------------------------------------------
IF OBJECT_ID(N'dbo.[pharmacists_tbl]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[pharmacists_tbl] (
        [PharmacistID] int IDENTITY(1,1) NOT NULL,
        [Id] int NOT NULL,
        [PharmacistCode] nvarchar(40) NOT NULL,
        [LicenseNumber] nvarchar(100) NOT NULL,
        [Specialization] nvarchar(200) NULL,
        [Department] nvarchar(200) NULL,
        [Qualification] nvarchar(300) NULL,
        [RegistrationNo] nvarchar(100) NULL,
        [Hospital] nvarchar(300) NULL,
        [Status] nvarchar(40) NOT NULL DEFAULT ('Active'),
        [JoinedDate] date NULL,
        [CreatedAt] datetime NOT NULL DEFAULT (getdate()),
        CONSTRAINT [PK_pharmacists_tbl] PRIMARY KEY CLUSTERED ([PharmacistID] ASC)
    );
END
GO

SET IDENTITY_INSERT [dbo].[pharmacists_tbl] ON;
GO
IF NOT EXISTS (SELECT 1 FROM [dbo].[pharmacists_tbl] WHERE [PharmacistID] = 1)
    INSERT INTO [dbo].[pharmacists_tbl] ([PharmacistID], [Id], [PharmacistCode], [LicenseNumber], [Specialization], [Department], [Qualification], [RegistrationNo], [Hospital], [Status], [JoinedDate], [CreatedAt]) VALUES (1, 4, N'PH-102', N'MH-PH-2022-4412', N'Prince Nimavat', N'Prescription Verification', N'B.Pharm', N'REG-8823', N'Fortis Healthcare', N'Active', '2025-02-15 00:00:00.000', '2026-01-08 14:15:00.000');
SET IDENTITY_INSERT [dbo].[pharmacists_tbl] OFF;
GO

-- --------------------------------------------------
-- Table: [PharmacySettings]
-- --------------------------------------------------
IF OBJECT_ID(N'dbo.[PharmacySettings]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[PharmacySettings] (
        [SettingID] int IDENTITY(1,1) NOT NULL,
        [SettingKey] nvarchar(100) NOT NULL,
        [SettingValue] nvarchar(MAX) NULL,
        [UpdatedAt] datetime NULL DEFAULT (getdate()),
        CONSTRAINT [PK_PharmacySettings] PRIMARY KEY CLUSTERED ([SettingID] ASC)
    );
END
GO

SET IDENTITY_INSERT [dbo].[PharmacySettings] ON;
GO
IF NOT EXISTS (SELECT 1 FROM [dbo].[PharmacySettings] WHERE [SettingID] = 1)
    INSERT INTO [dbo].[PharmacySettings] ([SettingID], [SettingKey], [SettingValue], [UpdatedAt]) VALUES (1, N'PharmacyName', N'MediCare Pharmacy', '2026-11-01 23:28:19.430');
IF NOT EXISTS (SELECT 1 FROM [dbo].[PharmacySettings] WHERE [SettingID] = 2)
    INSERT INTO [dbo].[PharmacySettings] ([SettingID], [SettingKey], [SettingValue], [UpdatedAt]) VALUES (2, N'Tagline', N'Your Trusted Online Pharmacy', '2026-11-01 23:28:19.430');
IF NOT EXISTS (SELECT 1 FROM [dbo].[PharmacySettings] WHERE [SettingID] = 3)
    INSERT INTO [dbo].[PharmacySettings] ([SettingID], [SettingKey], [SettingValue], [UpdatedAt]) VALUES (3, N'ContactEmail', N'support@medicare.com', '2026-11-01 23:28:19.430');
IF NOT EXISTS (SELECT 1 FROM [dbo].[PharmacySettings] WHERE [SettingID] = 4)
    INSERT INTO [dbo].[PharmacySettings] ([SettingID], [SettingKey], [SettingValue], [UpdatedAt]) VALUES (4, N'ContactPhone', N'+91 98765 43210', '2026-11-01 23:28:19.430');
IF NOT EXISTS (SELECT 1 FROM [dbo].[PharmacySettings] WHERE [SettingID] = 5)
    INSERT INTO [dbo].[PharmacySettings] ([SettingID], [SettingKey], [SettingValue], [UpdatedAt]) VALUES (5, N'Address', N'123 Health Ave, Mumbai, MH, India', '2026-11-01 23:28:19.430');
IF NOT EXISTS (SELECT 1 FROM [dbo].[PharmacySettings] WHERE [SettingID] = 6)
    INSERT INTO [dbo].[PharmacySettings] ([SettingID], [SettingKey], [SettingValue], [UpdatedAt]) VALUES (6, N'GSTIN', N'27AABCU9603R1ZN', '2026-11-01 23:28:19.430');
IF NOT EXISTS (SELECT 1 FROM [dbo].[PharmacySettings] WHERE [SettingID] = 7)
    INSERT INTO [dbo].[PharmacySettings] ([SettingID], [SettingKey], [SettingValue], [UpdatedAt]) VALUES (7, N'DrugLicenseNo', N'MH-TZ1-2024-00451', '2026-11-01 23:28:19.430');
IF NOT EXISTS (SELECT 1 FROM [dbo].[PharmacySettings] WHERE [SettingID] = 8)
    INSERT INTO [dbo].[PharmacySettings] ([SettingID], [SettingKey], [SettingValue], [UpdatedAt]) VALUES (8, N'EmailNotifications', N'true', '2026-11-01 23:28:19.430');
IF NOT EXISTS (SELECT 1 FROM [dbo].[PharmacySettings] WHERE [SettingID] = 9)
    INSERT INTO [dbo].[PharmacySettings] ([SettingID], [SettingKey], [SettingValue], [UpdatedAt]) VALUES (9, N'SMSNotifications', N'true', '2026-11-01 23:28:19.430');
IF NOT EXISTS (SELECT 1 FROM [dbo].[PharmacySettings] WHERE [SettingID] = 10)
    INSERT INTO [dbo].[PharmacySettings] ([SettingID], [SettingKey], [SettingValue], [UpdatedAt]) VALUES (10, N'LowStockAlerts', N'true', '2026-11-01 23:28:19.430');
IF NOT EXISTS (SELECT 1 FROM [dbo].[PharmacySettings] WHERE [SettingID] = 11)
    INSERT INTO [dbo].[PharmacySettings] ([SettingID], [SettingKey], [SettingValue], [UpdatedAt]) VALUES (11, N'ExpiryAlerts', N'true', '2026-11-01 23:28:19.430');
IF NOT EXISTS (SELECT 1 FROM [dbo].[PharmacySettings] WHERE [SettingID] = 12)
    INSERT INTO [dbo].[PharmacySettings] ([SettingID], [SettingKey], [SettingValue], [UpdatedAt]) VALUES (12, N'TwoFAEnabled', N'false', '2026-11-01 23:28:19.430');
IF NOT EXISTS (SELECT 1 FROM [dbo].[PharmacySettings] WHERE [SettingID] = 13)
    INSERT INTO [dbo].[PharmacySettings] ([SettingID], [SettingKey], [SettingValue], [UpdatedAt]) VALUES (13, N'MinPasswordLength', N'8', '2026-11-01 23:28:19.430');
IF NOT EXISTS (SELECT 1 FROM [dbo].[PharmacySettings] WHERE [SettingID] = 14)
    INSERT INTO [dbo].[PharmacySettings] ([SettingID], [SettingKey], [SettingValue], [UpdatedAt]) VALUES (14, N'SessionTimeoutMins', N'30', '2026-11-01 23:28:19.430');
IF NOT EXISTS (SELECT 1 FROM [dbo].[PharmacySettings] WHERE [SettingID] = 15)
    INSERT INTO [dbo].[PharmacySettings] ([SettingID], [SettingKey], [SettingValue], [UpdatedAt]) VALUES (15, N'DefaultTaxRate', N'18.0', '2026-11-01 23:28:19.430');
IF NOT EXISTS (SELECT 1 FROM [dbo].[PharmacySettings] WHERE [SettingID] = 16)
    INSERT INTO [dbo].[PharmacySettings] ([SettingID], [SettingKey], [SettingValue], [UpdatedAt]) VALUES (16, N'Currency', N'INR (?)', '2026-11-01 23:28:19.430');
IF NOT EXISTS (SELECT 1 FROM [dbo].[PharmacySettings] WHERE [SettingID] = 17)
    INSERT INTO [dbo].[PharmacySettings] ([SettingID], [SettingKey], [SettingValue], [UpdatedAt]) VALUES (17, N'CODEnabled', N'true', '2026-11-01 23:28:19.430');
IF NOT EXISTS (SELECT 1 FROM [dbo].[PharmacySettings] WHERE [SettingID] = 18)
    INSERT INTO [dbo].[PharmacySettings] ([SettingID], [SettingKey], [SettingValue], [UpdatedAt]) VALUES (18, N'CardPayEnabled', N'true', '2026-11-01 23:28:19.430');
IF NOT EXISTS (SELECT 1 FROM [dbo].[PharmacySettings] WHERE [SettingID] = 19)
    INSERT INTO [dbo].[PharmacySettings] ([SettingID], [SettingKey], [SettingValue], [UpdatedAt]) VALUES (19, N'UPIEnabled', N'true', '2026-11-01 23:28:19.430');
IF NOT EXISTS (SELECT 1 FROM [dbo].[PharmacySettings] WHERE [SettingID] = 20)
    INSERT INTO [dbo].[PharmacySettings] ([SettingID], [SettingKey], [SettingValue], [UpdatedAt]) VALUES (20, N'FontFamily', N'Plus Jakarta Sans', '2026-11-01 23:28:19.430');
IF NOT EXISTS (SELECT 1 FROM [dbo].[PharmacySettings] WHERE [SettingID] = 21)
    INSERT INTO [dbo].[PharmacySettings] ([SettingID], [SettingKey], [SettingValue], [UpdatedAt]) VALUES (21, N'PrimaryColor', N'#2563EB', '2026-11-01 23:28:19.430');
IF NOT EXISTS (SELECT 1 FROM [dbo].[PharmacySettings] WHERE [SettingID] = 22)
    INSERT INTO [dbo].[PharmacySettings] ([SettingID], [SettingKey], [SettingValue], [UpdatedAt]) VALUES (22, N'AccentColor', N'#10B981', '2026-11-01 23:28:19.430');
IF NOT EXISTS (SELECT 1 FROM [dbo].[PharmacySettings] WHERE [SettingID] = 23)
    INSERT INTO [dbo].[PharmacySettings] ([SettingID], [SettingKey], [SettingValue], [UpdatedAt]) VALUES (23, N'SidebarStyle', N'Expanded', '2026-11-01 23:28:19.430');
SET IDENTITY_INSERT [dbo].[PharmacySettings] OFF;
GO

-- --------------------------------------------------
-- Table: [medicines_tbl]
-- --------------------------------------------------
IF OBJECT_ID(N'dbo.[medicines_tbl]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[medicines_tbl] (
        [MedicineID] int IDENTITY(1,1) NOT NULL,
        [Name] nvarchar(400) NOT NULL,
        [GenericName] nvarchar(400) NULL,
        [BrandID] int NULL,
        [CategoryID] int NULL,
        [MedicineType] nvarchar(200) NULL,
        [DosageForm] nvarchar(200) NULL,
        [Strength] nvarchar(200) NULL,
        [PackSize] nvarchar(200) NULL,
        [Price] decimal(10, 2) NOT NULL DEFAULT ((0)),
        [MRP] decimal(10, 2) NOT NULL DEFAULT ((0)),
        [Discount] decimal(5, 2) NOT NULL DEFAULT ((0)),
        [Stock] int NOT NULL DEFAULT ((0)),
        [MinStockLevel] int NOT NULL DEFAULT ((20)),
        [RxRequired] bit NOT NULL DEFAULT ((0)),
        [ImageUrl] nvarchar(600) NULL,
        [Description] nvarchar(2000) NULL,
        [Uses] nvarchar(2000) NULL,
        [Dosage] nvarchar(1000) NULL,
        [SideEffects] nvarchar(1000) NULL,
        [Interactions] nvarchar(1000) NULL,
        [Precautions] nvarchar(1000) NULL,
        [Composition] nvarchar(1000) NULL,
        [InactiveIngredients] nvarchar(1000) NULL,
        [Storage] nvarchar(600) NULL,
        [Manufacturer] nvarchar(400) NULL,
        [CountryOfOrigin] nvarchar(200) NULL,
        [Status] nvarchar(40) NOT NULL DEFAULT ('Active'),
        [CreatedAt] datetime NOT NULL DEFAULT (getdate()),
        [UpdatedAt] datetime NOT NULL DEFAULT (getdate()),
        CONSTRAINT [PK_medicines_tbl] PRIMARY KEY CLUSTERED ([MedicineID] ASC)
    );
END
GO

SET IDENTITY_INSERT [dbo].[medicines_tbl] ON;
GO
IF NOT EXISTS (SELECT 1 FROM [dbo].[medicines_tbl] WHERE [MedicineID] = 1)
    INSERT INTO [dbo].[medicines_tbl] ([MedicineID], [Name], [GenericName], [BrandID], [CategoryID], [MedicineType], [DosageForm], [Strength], [PackSize], [Price], [MRP], [Discount], [Stock], [MinStockLevel], [RxRequired], [ImageUrl], [Description], [Uses], [Dosage], [SideEffects], [Interactions], [Precautions], [Composition], [InactiveIngredients], [Storage], [Manufacturer], [CountryOfOrigin], [Status], [CreatedAt], [UpdatedAt]) VALUES (1, N'Paracetamol 500mg', N'Paracetamol', 1, 1, N'Tablet', N'Tablet', N'500mg', N'10 Tablets', 25.00, 30.00, 10.00, 160, 20, 0, NULL, N'Used for relief from fever and mild to moderate pain.', N'Fever and pain relief', N'1 tablet after meals as directed by doctor', N'Nausea, allergic reaction', N'May interact with certain medicines', N'Do not exceed recommended dose', N'Paracetamol 500mg', N'None', N'Store in a cool and dry place', N'ABC Pharmaceuticals', N'India', N'Active', '2026-10-07 09:38:19.143', '2026-10-07 09:38:19.143');
IF NOT EXISTS (SELECT 1 FROM [dbo].[medicines_tbl] WHERE [MedicineID] = 2)
    INSERT INTO [dbo].[medicines_tbl] ([MedicineID], [Name], [GenericName], [BrandID], [CategoryID], [MedicineType], [DosageForm], [Strength], [PackSize], [Price], [MRP], [Discount], [Stock], [MinStockLevel], [RxRequired], [ImageUrl], [Description], [Uses], [Dosage], [SideEffects], [Interactions], [Precautions], [Composition], [InactiveIngredients], [Storage], [Manufacturer], [CountryOfOrigin], [Status], [CreatedAt], [UpdatedAt]) VALUES (2, N'Amoxicillin 500mg', N'Amoxicillin Trihydrate', 2, 2, N'Capsule', N'Oral Capsule', N'500mg', N'Strip of 10 capsules', 85.00, 100.00, 15.00, 80, 15, 1, N'/assets/images/medicines/amoxicillin.png', N'Broad spectrum penicillin-class antibiotic for bacterial infections.', N'Bacterial throat infections, pneumonia, bronchitis, ear infections', N'Take 1 capsule every 8 hours after meals as prescribed.', N'Diarrhea, nausea, mild skin rash.', N'Interacts with methotrexate and blood thinners.', N'Complete the full course even if feeling better.', N'Amoxicillin Trihydrate IP eq. to Amoxicillin 500mg', NULL, N'Store in a cool dry place below 30°C', N'MedCure Healthcare', N'India', N'Active', '2026-01-01 10:00:00.000', '2026-01-01 10:00:00.000');
IF NOT EXISTS (SELECT 1 FROM [dbo].[medicines_tbl] WHERE [MedicineID] = 3)
    INSERT INTO [dbo].[medicines_tbl] ([MedicineID], [Name], [GenericName], [BrandID], [CategoryID], [MedicineType], [DosageForm], [Strength], [PackSize], [Price], [MRP], [Discount], [Stock], [MinStockLevel], [RxRequired], [ImageUrl], [Description], [Uses], [Dosage], [SideEffects], [Interactions], [Precautions], [Composition], [InactiveIngredients], [Storage], [Manufacturer], [CountryOfOrigin], [Status], [CreatedAt], [UpdatedAt]) VALUES (3, N'Vitamin C + Zinc Chewable', N'Ascorbic Acid + Zinc Sulphate', 3, 1, N'Tablet', N'Chewable Tablet', N'500mg + 10mg', N'Bottle of 60 tablets', 120.00, 150.00, 20.00, 200, 30, 0, N'/assets/images/medicines/vitaminc.png', N'Immunity booster for daily energy and tissue repair.', N'Daily antioxidant defense, scurvy prevention, immune support', N'Chew 1 tablet daily preferably in the morning after breakfast.', N'Mild stomach upset if taken on an empty stomach.', N'Minimal interactions with food and OTC supplements.', N'Consult doctor if pregnant or lactating.', N'Vitamin C IP 500mg, Elemental Zinc 10mg', NULL, N'Keep container tightly closed in a cool place', N'VitaBoost Wellness', N'USA', N'Active', '2026-01-01 10:00:00.000', '2026-01-01 10:00:00.000');
SET IDENTITY_INSERT [dbo].[medicines_tbl] OFF;
GO

-- --------------------------------------------------
-- Table: [medicinebatches_tbl]
-- --------------------------------------------------
IF OBJECT_ID(N'dbo.[medicinebatches_tbl]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[medicinebatches_tbl] (
        [BatchID] int IDENTITY(1,1) NOT NULL,
        [MedicineID] int NOT NULL,
        [BatchNumber] nvarchar(MAX) NOT NULL,
        [Quantity] int NOT NULL DEFAULT ((0)),
        [PurchasePrice] decimal(10, 2) NOT NULL DEFAULT ((0)),
        [ManufacturingDate] date NOT NULL,
        [ExpiryDate] date NOT NULL,
        [Status] nvarchar(MAX) NOT NULL DEFAULT ('Active'),
        [CreatedAt] datetime NOT NULL DEFAULT (getdate()),
        CONSTRAINT [PK_medicinebatches_tbl] PRIMARY KEY CLUSTERED ([BatchID] ASC)
    );
END
GO

-- --------------------------------------------------
-- Table: [Cart]
-- --------------------------------------------------
IF OBJECT_ID(N'dbo.[Cart]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Cart] (
        [CartID] int IDENTITY(1,1) NOT NULL,
        [CustomerID] int NOT NULL,
        [MedicineID] int NOT NULL,
        [Quantity] int NULL DEFAULT ((1)),
        [AddedAt] datetime NULL DEFAULT (getdate()),
        CONSTRAINT [PK_Cart] PRIMARY KEY CLUSTERED ([CartID] ASC)
    );
END
GO

-- --------------------------------------------------
-- Table: [Orders]
-- --------------------------------------------------
IF OBJECT_ID(N'dbo.[Orders]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Orders] (
        [OrderID] int IDENTITY(1,1) NOT NULL,
        [OrderCode] nvarchar(50) NOT NULL,
        [CustomerID] int NULL,
        [FullName] nvarchar(200) NULL,
        [TotalAmount] decimal(18, 2) NOT NULL DEFAULT ((0)),
        [Status] nvarchar(50) NOT NULL DEFAULT ('Pending'),
        [PaymentStatus] nvarchar(50) NOT NULL DEFAULT ('Paid'),
        [Notes] nvarchar(1000) NULL,
        [OrderDate] datetime NOT NULL DEFAULT (getdate()),
        [CreatedAt] datetime NOT NULL DEFAULT (getdate()),
        CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED ([OrderID] ASC)
    );
END
GO

SET IDENTITY_INSERT [dbo].[Orders] ON;
GO
IF NOT EXISTS (SELECT 1 FROM [dbo].[Orders] WHERE [OrderID] = 1)
    INSERT INTO [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [FullName], [TotalAmount], [Status], [PaymentStatus], [Notes], [OrderDate], [CreatedAt]) VALUES (1, N'ORD-2026-001', 4, N'Prince Nimavat', 450.00, N'Delivered', N'Paid', N'Standard home delivery', '2026-10-30 23:28:19.453', '2026-11-01 23:28:19.453');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Orders] WHERE [OrderID] = 2)
    INSERT INTO [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [FullName], [TotalAmount], [Status], [PaymentStatus], [Notes], [OrderDate], [CreatedAt]) VALUES (2, N'ORD-2026-002', 6, N'Amrut Sabaliya', 1250.00, N'Processing', N'Paid', N'Express shipping requested', '2026-10-31 23:28:19.453', '2026-11-01 23:28:19.453');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Orders] WHERE [OrderID] = 3)
    INSERT INTO [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [FullName], [TotalAmount], [Status], [PaymentStatus], [Notes], [OrderDate], [CreatedAt]) VALUES (3, N'ORD-2026-003', 4, N'Prince Nimavat', 320.00, N'Pending', N'Pending', N'Awaiting customer payment confirmation', '2026-11-01 23:28:19.453', '2026-11-01 23:28:19.453');
SET IDENTITY_INSERT [dbo].[Orders] OFF;
GO

-- --------------------------------------------------
-- Table: [invoices_tbl]
-- --------------------------------------------------
IF OBJECT_ID(N'dbo.[invoices_tbl]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[invoices_tbl] (
        [InvoiceID] int IDENTITY(1,1) NOT NULL,
        [InvoiceCode] nvarchar(100) NULL,
        [OrderID] int NULL,
        [CustomerID] int NULL,
        [TotalAmount] decimal(18, 2) NOT NULL,
        [PaymentMethod] nvarchar(100) NULL,
        [PaymentStatus] nvarchar(100) NULL,
        [InvoiceDate] datetime NULL DEFAULT (getdate()),
        CONSTRAINT [PK_invoices_tbl] PRIMARY KEY CLUSTERED ([InvoiceID] ASC)
    );
END
GO

-- --------------------------------------------------
-- Table: [prescriptions_tbl]
-- --------------------------------------------------
IF OBJECT_ID(N'dbo.[prescriptions_tbl]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[prescriptions_tbl] (
        [PrescriptionID] int IDENTITY(1,1) NOT NULL,
        [PrescriptionCode] nvarchar(100) NULL,
        [CustomerID] int NULL,
        [DoctorName] nvarchar(400) NULL,
        [Status] nvarchar(100) NULL DEFAULT ('Pending'),
        [Notes] nvarchar(2000) NULL,
        [VerifiedAt] datetime NULL,
        [CreatedAt] datetime NULL DEFAULT (getdate()),
        CONSTRAINT [PK_prescriptions_tbl] PRIMARY KEY CLUSTERED ([PrescriptionID] ASC)
    );
END
GO

-- --------------------------------------------------
-- Table: [stockalerts_tbl]
-- --------------------------------------------------
IF OBJECT_ID(N'dbo.[stockalerts_tbl]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[stockalerts_tbl] (
        [AlertID] int IDENTITY(1,1) NOT NULL,
        [MedicineID] int NOT NULL,
        [SupplierID] int NOT NULL,
        [PharmacistID] int NOT NULL,
        [OrderQuantity] int NOT NULL DEFAULT ((0)),
        [Priority] nvarchar(MAX) NOT NULL DEFAULT ('Normal'),
        [Notes] nvarchar(MAX) NOT NULL,
        [Status] nvarchar(MAX) NOT NULL DEFAULT ('Pending'),
        [CreatedAt] datetime NOT NULL DEFAULT (getdate()),
        [UpdatedAt] datetime NOT NULL DEFAULT (getdate()),
        CONSTRAINT [PK_stockalerts_tbl] PRIMARY KEY CLUSTERED ([AlertID] ASC)
    );
END
GO

-- --------------------------------------------------
-- Table: [stockin_tbl]
-- --------------------------------------------------
IF OBJECT_ID(N'dbo.[stockin_tbl]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[stockin_tbl] (
        [StockInID] int IDENTITY(1,1) NOT NULL,
        [MedicineID] int NOT NULL,
        [BatchID] int NOT NULL,
        [SupplierID] int NOT NULL,
        [PharmacistID] int NOT NULL,
        [BatchNumber] nvarchar(100) NOT NULL,
        [Quantity] int NOT NULL,
        [PurchasePrice] decimal(10, 2) NOT NULL DEFAULT ((0)),
        [ExpiryDate] date NOT NULL,
        [ReceivedDate] date NOT NULL DEFAULT (CONVERT([date],getdate())),
        [Notes] nvarchar(1000) NOT NULL,
        [CreatedAt] datetime NOT NULL DEFAULT (getdate()),
        CONSTRAINT [PK_stockin_tbl] PRIMARY KEY CLUSTERED ([StockInID] ASC)
    );
END
GO

-- --------------------------------------------------
-- Table: [stockout_tbl]
-- --------------------------------------------------
IF OBJECT_ID(N'dbo.[stockout_tbl]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[stockout_tbl] (
        [StockOutID] int IDENTITY(1,1) NOT NULL,
        [MedicineID] int NOT NULL,
        [BatchNumber] nvarchar(200) NULL,
        [Quantity] int NOT NULL,
        [Reason] nvarchar(200) NULL,
        [ReferenceNo] nvarchar(200) NULL,
        [Notes] nvarchar(2000) NULL,
        [CreatedAt] datetime NULL DEFAULT (getdate()),
        CONSTRAINT [PK_stockout_tbl] PRIMARY KEY CLUSTERED ([StockOutID] ASC)
    );
END
GO

