/* ============================================================
   1. CREATE DATABASE
   ============================================================ */

CREATE DATABASE RaceDayDB;
GO

USE RaceDayDB;
GO


/* ============================================================
   2. CREATE ORGANIZER TABLE
   ============================================================ */

CREATE TABLE Organizer
(
    OrganizerID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(150) NOT NULL UNIQUE,
    Phone VARCHAR(20) NOT NULL
);
GO


/* ============================================================
   3. CREATE VENUE TABLE
   ============================================================ */

CREATE TABLE Venue
(
    VenueID INT IDENTITY(1,1) PRIMARY KEY,
    VenueName VARCHAR(150) NOT NULL,
    Address VARCHAR(200) NOT NULL,
    City VARCHAR(100) NOT NULL
);
GO


/* ============================================================
   4. CREATE EVENT TABLE
   ============================================================ */

CREATE TABLE Event
(
    EventID INT IDENTITY(1,1) PRIMARY KEY,
    OrganizerID INT NOT NULL,
    VenueID INT NOT NULL,
    EventName VARCHAR(150) NOT NULL,
    EventDate DATE NOT NULL,
    EventStatus VARCHAR(30) NOT NULL
        CONSTRAINT DF_Event_Status DEFAULT 'Scheduled',

    CONSTRAINT FK_Event_Organizer
        FOREIGN KEY (OrganizerID)
        REFERENCES Organizer(OrganizerID),

    CONSTRAINT FK_Event_Venue
        FOREIGN KEY (VenueID)
        REFERENCES Venue(VenueID)
);
GO


/* ============================================================
   5. CREATE CATEGORY TABLE
   ============================================================ */

CREATE TABLE Category
(
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    EventID INT NOT NULL,
    CategoryName VARCHAR(100) NOT NULL,
    DistanceKM DECIMAL(5,2) NOT NULL,
    EntryFee DECIMAL(10,2) NOT NULL,

    CONSTRAINT FK_Category_Event
        FOREIGN KEY (EventID)
        REFERENCES Event(EventID),

    CONSTRAINT UQ_Category_Event_Name
        UNIQUE (EventID, CategoryName)
);
GO


/* ============================================================
   6. CREATE PARTICIPANT TABLE
   ============================================================ */

CREATE TABLE Participant
(
    ParticipantID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(150) NOT NULL UNIQUE,
    Phone VARCHAR(20) NOT NULL
);
GO


/* ============================================================
   7. CREATE ENROLMENT TABLE
   ============================================================ */

CREATE TABLE Enrolment
(
    EnrolmentID INT IDENTITY(1,1) PRIMARY KEY,
    ParticipantID INT NOT NULL,
    CategoryID INT NOT NULL,

    EnrolmentDate DATE NOT NULL
        CONSTRAINT DF_Enrolment_Date DEFAULT GETDATE(),

    PaymentStatus VARCHAR(30) NOT NULL
        CONSTRAINT DF_Enrolment_Payment DEFAULT 'Pending',

    RaceNumber INT NOT NULL UNIQUE,

    CONSTRAINT FK_Enrolment_Participant
        FOREIGN KEY (ParticipantID)
        REFERENCES Participant(ParticipantID),

    CONSTRAINT FK_Enrolment_Category
        FOREIGN KEY (CategoryID)
        REFERENCES Category(CategoryID)
);
GO


/* ============================================================
   8. INSERT ORGANIZERS
   Minimum required: 2
   ============================================================ */

INSERT INTO Organizer
    (Name, Email, Phone)
VALUES
    ('RaceDay Events', 'info@raceday.co.za', '0315551001'),
    ('KwaZulu Sports Events', 'events@kzulsports.co.za', '0315551002');
GO


/* ============================================================
   9. INSERT VENUES
   ============================================================ */

INSERT INTO Venue
    (VenueName, Address, City)
VALUES
    ('Moses Mabhida Stadium', '44 Isaiah Ntshangase Road', 'Durban'),
    ('Kings Park Athletics Stadium', 'Jacko Jackson Drive', 'Durban'),
    ('Umhlanga Sports Centre', 'Main Road', 'Umhlanga');
GO


/* ============================================================
   10. INSERT EVENTS
   Minimum required: 3
   ============================================================ */

INSERT INTO Event
    (OrganizerID, VenueID, EventName, EventDate, EventStatus)
VALUES
    (1, 1, 'Durban City Marathon', '2026-09-20', 'Scheduled'),
    (1, 2, 'Kings Park Fun Run', '2026-10-04', 'Scheduled'),
    (2, 3, 'Umhlanga Coastal Race', '2026-10-18', 'Scheduled');
GO


/* ============================================================
   11. INSERT CATEGORIES
   Categories for each event
   ============================================================ */

INSERT INTO Category
    (EventID, CategoryName, DistanceKM, EntryFee)
VALUES

    -- Event 1: Durban City Marathon
    (1, 'Marathon', 42.20, 350.00),
    (1, 'Half Marathon', 21.10, 250.00),
    (1, '10KM Run', 10.00, 150.00),

    -- Event 2: Kings Park Fun Run
    (2, '10KM Run', 10.00, 120.00),
    (2, '5KM Fun Run', 5.00, 80.00),

    -- Event 3: Umhlanga Coastal Race
    (3, '21KM Coastal Race', 21.10, 220.00),
    (3, '10KM Coastal Run', 10.00, 140.00),
    (3, '5KM Fun Run', 5.00, 80.00);
GO


/* ============================================================
   12. INSERT PARTICIPANTS
   Minimum required: 2
   ============================================================ */

INSERT INTO Participant
    (FirstName, LastName, Email, Phone)
VALUES
    ('Thabo', 'Mthembu', 'thabo.mthembu@email.com', '0821112233'),
    ('Lerato', 'Khumalo', 'lerato.khumalo@email.com', '0832223344');
GO


/* ============================================================
   13. INSERT ENROLMENTS
   ============================================================ */

INSERT INTO Enrolment
    (ParticipantID, CategoryID, EnrolmentDate, PaymentStatus, RaceNumber)
VALUES
    (1, 1, '2026-08-20', 'Paid', 1001),
    (2, 2, '2026-08-21', 'Paid', 1002),
    (1, 4, '2026-08-22', 'Pending', 1003),
    (2, 5, '2026-08-23', 'Paid', 1004);
GO


/* ============================================================
   14. TEST ALL TABLES
   ============================================================ */

SELECT * FROM Organizer;
SELECT * FROM Venue;
SELECT * FROM Event;
SELECT * FROM Category;
SELECT * FROM Participant;
SELECT * FROM Enrolment;
GO