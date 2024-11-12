Use [master]
go
CREATE DATABASE IbadahLoverDB
GO
USE IbadahLoverDB
go
CREATE TABLE User_Account (
    id BIGINT PRIMARY KEY IDENTITY(1,1), -- Auto-incrementing primary key
    full_name NVARCHAR(25) NOT NULL,
    email NVARCHAR(50) NOT NULL UNIQUE, -- Ensuring email is unique
	profile_picture IMAGE NULL, -- Base64 encryption for Project!
    password_hash NVARCHAR(255) NULL,
	o_auth_provider NVARCHAR(20) NULL,
	o_auth_id NVARCHAR(255) NULL,
	email_confirmed BIT DEFAULT 0 NOT NULL,
	created_on DATE DEFAULT GETDATE() NOT NULL, -- Automatically sets to the current date
	created_by NVARCHAR(25) NOT NULL,
	last_modified_on DATE DEFAULT GETDATE() NOT NULL,
	last_modified_by NVARCHAR(25) NOT NULL,

	CONSTRAINT UQ_User_Account_email_password_hash UNIQUE (email, password_hash),
	CONSTRAINT CK_User_Account_password_hash_o_auth_id CHECK (password_hash IS NOT NULL OR o_auth_id IS NOT NULL)  -- At least one must be non-NULL
);
GO
CREATE TABLE Dhikr_Type (
    id BIGINT PRIMARY KEY IDENTITY(1,1), -- Auto-incrementing primary key
    full_name NVARCHAR(255) NOT NULL, --Allahu Akbar, Subhan Allah, Alhamdullillah, Astaghfirullah etc...
	created_on DATE DEFAULT GETDATE() NOT NULL, -- Automatically sets to the current date
	created_by NVARCHAR(25) NOT NULL, -- So user can create his own personal dhirk types just for him
	last_modified_on DATE DEFAULT GETDATE() NOT NULL,
	last_modified_by NVARCHAR(25) NOT NULL,

	CONSTRAINT UQ_Dhikr_Type_full_name UNIQUE (full_name) -- Ensures a unique record per dhikr type.
);
GO
CREATE TABLE Salah_Type (
    id BIGINT PRIMARY KEY IDENTITY(1,1), -- Auto-incrementing primary key
    full_name NVARCHAR(255) NOT NULL, -- fajr, sobh, dohr, maghreb, isha, witr etc...
	created_on DATE DEFAULT GETDATE() NOT NULL, -- Automatically sets to the current date
	created_by NVARCHAR(25) NOT NULL, -- So user can create his own personal dhirk types just for him
	last_modified_on DATE DEFAULT GETDATE() NOT NULL,
	last_modified_by NVARCHAR(25) NOT NULL,

	CONSTRAINT UQ_Salah_Type_full_name UNIQUE (full_name) -- Ensures a unique record per Salah type.
);
GO
CREATE TABLE User_Dhikr_Activity (
    id BIGINT PRIMARY KEY IDENTITY(1,1), -- Auto-incrementing primary key
    User_Account_id BIGINT NOT NULL, -- Foreign key to Users table
    Dhikr_Type_id BIGINT NOT NULL, -- Foreign key to Dhikr table
    performed_at DATE DEFAULT CONVERT(VARCHAR(10), GETDATE(), 120) NOT NULL, -- The date in YYYY-MM-DD format in which the activity occurred
	last_activity_performed_on DATETIME DEFAULT GETDATE() NOT NULL,
    total_performed BIGINT DEFAULT 0 NOT NULL, -- Default count to 0 for new records
    
    CONSTRAINT FK_User_Dhikr_Activity_User_Account_id FOREIGN KEY (User_Account_id) REFERENCES User_Account(id) ON DELETE CASCADE,
    CONSTRAINT FK_User_Dhikr_Activity_Dhikr_Type_id FOREIGN KEY (Dhikr_Type_id) REFERENCES Dhikr_Type(id) ON DELETE CASCADE,
    CONSTRAINT UQ_User_Dhikr_Activity_User_Account_id_performed_at UNIQUE (User_Account_id, performed_at) -- Ensures a unique record per user per day
);
GO
CREATE TABLE User_Salah_Activity (
    id BIGINT PRIMARY KEY IDENTITY(1,1), -- Auto-incrementing primary key
    User_Account_id BIGINT NOT NULL, -- Foreign key to Users table
    Salah_Type_id BIGINT NOT NULL, -- Foreign key to Dhikr table
    performed_at DATE DEFAULT CONVERT(VARCHAR(10), GETDATE(), 120) NOT NULL, -- The date in YYYY-MM-DD format in which the activity occurred
    punctuality_percentage DECIMAL(5,2) DEFAULT 0 NOT NULL, -- The percentage of punctuality in prayer time (e.g., 98.50)
	average_punctuality_percentage DECIMAL(5,2) DEFAULT 0 NOT NULL, -- Average punctuality percentage

    
    CONSTRAINT FK_User_Salah_Activity_User_Account_id FOREIGN KEY (User_Account_id) REFERENCES User_Account(id) ON DELETE CASCADE,
    CONSTRAINT FK_User_Salah_Activity_Salah_Type_id FOREIGN KEY (Salah_Type_id) REFERENCES Salah_Type(id) ON DELETE CASCADE,
    CONSTRAINT UQ_User_Salah_Activity_User_Account_id_performed_at UNIQUE (User_Account_id, performed_at) -- Ensures a unique record per user per day
);

GO
CREATE TABLE User_Salah_Day_Overview (
    id BIGINT PRIMARY KEY IDENTITY(1,1), -- Auto-incrementing primary key
    User_Account_id BIGINT NOT NULL, -- Foreign key to Users table
	performed_at DATE DEFAULT CONVERT(VARCHAR(10), GETDATE(), 120) NOT NULL, -- The date in YYYY-MM-DD format in which the activity occurred
    average_punctuality_percentage DECIMAL(5,2) DEFAULT 0 NOT NULL, -- Average punctuality percentage
	total_performed INT DEFAULT 1 NOT NULL, -- Total of salah records for the day taken into account for the average punctuality percentage
    
    CONSTRAINT FK_User_Ibadah_Overview_User_Account_id FOREIGN KEY (User_Account_id) REFERENCES User_Account(id) ON DELETE CASCADE
);
GO
CREATE TABLE User_Dhikr_Overview (
    id BIGINT PRIMARY KEY IDENTITY(1,1), -- Auto-incrementing primary key
    User_Account_id BIGINT NOT NULL, -- Foreign key to Users table
    total_performed BIGINT DEFAULT 0 NOT NULL, -- Total dhikr performed by the user
    last_performed_on DATETIME DEFAULT GETDATE() NOT NULL, -- Timestamp for when the overview was last updated
    
    CONSTRAINT FK_User_Ibadah_Overview_User_Account_id FOREIGN KEY (User_Account_id) REFERENCES User_Account(id) ON DELETE CASCADE
);
--GO
--CREATE TABLE User_Ibadah_Overview (
--    id BIGINT PRIMARY KEY IDENTITY(1,1), -- Auto-incrementing primary key
--    User_Account_id BIGINT NOT NULL, -- Foreign key to Users table
--	Dhikr_Type_id BIGINT NOT NULL, -- Foreign key to Users table
--    total_dhikr_performed BIGINT DEFAULT 0 NOT NULL, -- Total dhikr performed by the user
----    average_punctuality_percentage DECIMAL(5,2) DEFAULT 0 NOT NULL, -- Average punctuality percentage
----    last_updated DATETIME DEFAULT GETDATE() NOT NULL, -- Timestamp for when the overview was last updated

--    CONSTRAINT FK_User_Ibadah_Overview_Dhikr_Type_id FOREIGN KEY (Dhikr_Type_id) REFERENCES Dhikr_Type(id) ON DELETE CASCADE,
--    CONSTRAINT FK_User_Ibadah_Overview_User_Account_id FOREIGN KEY (User_Account_id) REFERENCES User_Account(id) ON DELETE CASCADE
--);

--GO
--CREATE TABLE User_Salah_Overview (
--    id BIGINT PRIMARY KEY IDENTITY(1,1), -- Auto-incrementing primary key
--    User_Account_id BIGINT NOT NULL, -- Foreign key to Users table
--    average_punctuality_percentage DECIMAL(5,2) DEFAULT 0 NOT NULL, -- Average punctuality percentage
--    last_updated DATETIME DEFAULT GETDATE() NOT NULL, -- Timestamp for when the overview was last updated
    
--    CONSTRAINT FK_User_Ibadah_Overview_User_Account_id FOREIGN KEY (User_Account_id) REFERENCES User_Account(id) ON DELETE CASCADE
--);
--GO
--CREATE TABLE User_Dhikr_Overview (
--    id BIGINT PRIMARY KEY IDENTITY(1,1), -- Auto-incrementing primary key
--    User_Account_id BIGINT NOT NULL, -- Foreign key to Users table
--    total_dhikr_performed BIGINT DEFAULT 0 NOT NULL, -- Total dhikr performed by the user
--    average_punctuality_percentage DECIMAL(5,2) DEFAULT 0 NOT NULL, -- Average punctuality percentage
--    last_updated DATETIME DEFAULT GETDATE() NOT NULL, -- Timestamp for when the overview was last updated
    
--    CONSTRAINT FK_User_Ibadah_Overview_User_Account_id FOREIGN KEY (User_Account_id) REFERENCES User_Account(id) ON DELETE CASCADE
--);
--GO
--CREATE TABLE User_Ibadah_Overview (
--    id BIGINT PRIMARY KEY IDENTITY(1,1), -- Auto-incrementing primary key
--    User_Account_id BIGINT NOT NULL, -- Foreign key to Users table
--	Dhikr_Type_id BIGINT NOT NULL, -- Foreign key to Users table
--    total_dhikr_performed BIGINT DEFAULT 0 NOT NULL, -- Total dhikr performed by the user
----    average_punctuality_percentage DECIMAL(5,2) DEFAULT 0 NOT NULL, -- Average punctuality percentage
----    last_updated DATETIME DEFAULT GETDATE() NOT NULL, -- Timestamp for when the overview was last updated

--    CONSTRAINT FK_User_Ibadah_Overview_Dhikr_Type_id FOREIGN KEY (Dhikr_Type_id) REFERENCES Dhikr_Type(id) ON DELETE CASCADE,
--    CONSTRAINT FK_User_Ibadah_Overview_User_Account_id FOREIGN KEY (User_Account_id) REFERENCES User_Account(id) ON DELETE CASCADE
--);
GO
CREATE TRIGGER Trigger_Update_Dhikr_Overview
AFTER INSERT, UPDATE ON User_Dhikr_Activity
FOR EACH ROW
BEGIN
    UPDATE User_Dhikr_Overview
    SET total_performed += 1;
END;
GO
CREATE TRIGGER Trigger_Update_Salah_Day_Overview
AFTER INSERT, UPDATE ON User_Salah_Activity
FOR EACH ROW
BEGIN
    DECLARE @userId INT = NEW.User_Account_id;
    DECLARE @date DATE = NEW.performed_at;

    -- Calculate the average punctuality for the day using a CTE
    WITH SalahPunctuality AS (
        SELECT punctuality_percentage
        FROM User_Salah_Activity
        WHERE User_Account_id = @userId
        AND performed_at = @date
    )
    UPDATE User_Salah_Day_Overview
    SET average_punctuality_percentage = (
        SELECT AVG(punctuality_percentage)
        FROM SalahPunctuality
    )
    WHERE User_Account_id = @userId
    AND performed_at = @date;

    -- Insert a new record if it doesn't exist
    IF @@ROWCOUNT = 0
    BEGIN
        INSERT INTO User_Salah_Day_Overview (User_Account_id, performed_at, average_punctuality_percentage)
        SELECT @userId, @date, AVG(punctuality_percentage)
        FROM User_Salah_Activity
        WHERE User_Account_id = @userId
        AND performed_at = @date;
    END;
END;
GO
ALTER DATABASE IbadahLoverDB SET READ_WRITE
GO
USE IbadahLoverDB
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
