CREATE DATABASE IronFit;

USE IronFit;

CREATE TABLE Members (
	MemberID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(30) NOT NULL,
    LastName VARCHAR(30) NOT NULL,
    Email VARCHAR(300),
    EntryPassword VARCHAR(8) NOT NULL,
    LegalCode VARCHAR(11) NOT NULL,
    Phone VARCHAR(11) NOT NULL,
    CONSTRAINT uk_members_email
		UNIQUE (Email),
	CONSTRAINT uk_members_entrypassword
		UNIQUE (EntryPassword),
	CONSTRAINT uk_members_legalcode
		UNIQUE (LegalCode),
	CONSTRAINT uk_members_phone
		UNIQUE (Phone)
);

CREATE TABLE MemberAddress (
	AddressID INT AUTO_INCREMENT PRIMARY KEY,
    MemberID INT NOT NULL,
    Street VARCHAR(50) NOT NULL,
    StreetNumber VARCHAR(15),
    District VARCHAR(50) NOT NULL,
    PostalCode VARCHAR(8) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Complement VARCHAR(255),
    CONSTRAINT fk_memberaddress_memberid
		FOREIGN KEY (MemberID) REFERENCES Members (MemberID)
);

CREATE TABLE PersonalTrainers (
	TrainerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(30) NOT NULL,
    LastName VARCHAR(30) NOT NULL,
    Email VARCHAR(300) NOT NULL,
    EntryPassword VARCHAR(8) NOT NULL,
    LegalCode VARCHAR(11) NOT NULL,
    Phone VARCHAR(11) NOT NULL,
    CONSTRAINT uk_personaltrainers_email
		UNIQUE (Email),
	CONSTRAINT uk_personaltrainers_entrypassword
		UNIQUE (EntryPassword),
	CONSTRAINT uk_personaltrainers_legalcode
		UNIQUE (LegalCode),
	CONSTRAINT uk_personaltrainers_phone
		UNIQUE (Phone)
);

CREATE TABLE TrainerAddress (
	AddressID INT AUTO_INCREMENT PRIMARY KEY,
    TrainerID INT NOT NULL,
    Street VARCHAR(50) NOT NULL,
    StreetNumber VARCHAR(15),
    District VARCHAR(50) NOT NULL,
    PostalCode VARCHAR(8) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Complement VARCHAR(255),
    CONSTRAINT fk_memberaddress_treinerid
		FOREIGN KEY (TrainerID) REFERENCES PersonalTrainers (TrainerID)
);

CREATE TABLE Plans (
	PlanID INT AUTO_INCREMENT PRIMARY KEY,
    PlanName VARCHAR(30) NOT NULL,
    PlanType VARCHAR(30),
    PlanInformation VARCHAR(200),
    Price DECIMAL(10, 2) NOT NULL,
    CONSTRAINT uk_plans_planname
		UNIQUE (PlanName)
);

CREATE TABLE MemberReviews (
	ReviewID INT AUTO_INCREMENT PRIMARY KEY,
    MemberID INT NOT NULL,
    PlanID INT NOT NULL,
    MemberHeight DECIMAL(10, 2) NOT NULL,
    MemberWeight DECIMAL(10, 2) NOT NULL,
    BirthDate DATE NOT NULL,
    Objective VARCHAR(80) NOT NULL,
    AdditionalInformation VARCHAR(100),
    CONSTRAINT fk_memberreviews_memberid
		FOREIGN KEY (MemberID) REFERENCES Members (MemberID),
	CONSTRAINT fk_memberreviews_planid
		FOREIGN KEY (PlanID) REFERENCES Plans (PlanID),
	CONSTRAINT uk_memberreviews_memberid
		UNIQUE (MemberID)
);

CREATE TABLE GroupTrainers (
	GroupID INT AUTO_INCREMENT PRIMARY KEY,
    MemberID INT NOT NULL,
    TrainerID INT NOT NULL,
    PlanID INT,
    Information VARCHAR(300),
    TrainingDate DATE NOT NULL,
    CONSTRAINT fk_grouptrainers_memberid
		FOREIGN KEY (MemberID) REFERENCES Members (MemberID),
	CONSTRAINT fk_grouptrainers_trainerid
		FOREIGN KEY (TrainerID) REFERENCES PersonalTrainers (TrainerID),
	CONSTRAINT fk_grouptrainers_planid
		FOREIGN KEY (PlanID) REFERENCES Plans (PlanID)
);

ALTER TABLE Members
	ADD COLUMN RegisterDate DATE DEFAULT (CURRENT_DATE) NOT NULL;
    
ALTER TABLE MemberAddress
	ADD COLUMN RegisterDate DATE DEFAULT (CURRENT_DATE) NOT NULL,
    ADD COLUMN LastModifier DATE DEFAULT (CURRENT_DATE) NOT NULL;

ALTER TABLE PersonalTrainers
	ADD COLUMN RegisterDate DATE DEFAULT (CURRENT_DATE) NOT NULL;
    
ALTER TABLE TrainerAddress
	ADD COLUMN RegisterDate DATE DEFAULT (CURRENT_DATE) NOT NULL,
    ADD COLUMN LastModifier DATE DEFAULT (CURRENT_DATE) NOT NULL;
    
ALTER TABLE Plans
	ADD COLUMN NewPrice DECIMAL(10, 2) NOT NULL,
    RENAME COLUMN Price TO OldPrice;
    
ALTER TABLE MemberReviews
	ADD COLUMN StartDate DATE DEFAULT (CURRENT_DATE) NOT NULL;
    
ALTER TABLE GroupTrainers
	ADD COLUMN TrainingTime TIME NOT NULL;