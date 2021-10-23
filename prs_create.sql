USE master;

DROP DATABASE IF EXISTS prs;

CREATE DATABASE prs;

USE prs;


CREATE TABLE Users
	(	ID			INT				PRIMARY KEY IDENTITY,
		FirstName	VARCHAR(50)		NOT NULL,
		LastName	VARCHAR(50)		NOT NULL,
		Phone		VARCHAR(13)		NOT NULL,
		Email		VARCHAR(75)		NOT NULL,
		Username	VARCHAR(20)		NOT NULL,
		Password	VARCHAR(20)		NOT NULL,
		Reviewer	BIT				NOT NULL,
		Admin		BIT				NOT NULL	
	);

CREATE TABLE Vendors
	(	ID					INT				PRIMARY KEY IDENTITY,
		Code				VARCHAR(10)		NOT NULL,
		Name				VARCHAR(255)	NOT NULL,
		Street				VARCHAR(255)	NOT NULL,
		City				VARCHAR(255)	NOT NULL,
		State				CHAR(2)			NOT NULL,
		Zip					VARCHAR(10)		NOT NULL,
		Email				VARCHAR(100)	NOT NULL,
		Phone				VARCHAR(13)		NOT NULL
	);

CREATE TABLE PurchaseRequests
	(	ID					INT				PRIMARY KEY IDENTITY,
		UserID				INT				NOT NULL,
		Description			VARCHAR(100)	NOT NULL,
		Justification		VARCHAR(255)	NOT NULL,
		DateNeeded			DATE			NOT NULL,
		DeliveryMode		VARCHAR(25)		NOT NULL,
		Status				VARCHAR(20)		NOT NULL,
		Total				SMALLMONEY		NOT NULL,
		SubmittedDate		DateTime2		NOT NULL,
		ReasonForRejection	VARCHAR(255)
		
		CONSTRAINT FK_PRUser FOREIGN KEY (UserID)
		REFERENCES Users(ID) 
	);

CREATE TABLE Products
	(	ID					INT				PRIMARY KEY IDENTITY,
		VendorID			INT				NOT NULL,
		PartNumber			VARCHAR(50)		NOT NULL,
		Price				SMALLMONEY		NOT NULL,
		Name				VARCHAR(150)	NOT NULL,
		Unit				VARCHAR(255)			,
		PhotoPath			VARCHAR(255)
	
		CONSTRAINT FK_ProductVendor FOREIGN KEY (VendorID)
		REFERENCES Vendors(ID) 
	
	);

	CREATE TABLE LineItems
	(	ID					INT				PRIMARY KEY IDENTITY,
		RequestID			INT				NOT NULL,
		ProductID			INT				NOT NULL,
		Quantity			INT				NOT NULL,
	
		CONSTRAINT FK_LIRequest FOREIGN KEY (RequestID)
		REFERENCES PurchaseRequests(ID), 

		CONSTRAINT FK_LIProduct FOREIGN KEY (ProductID)
		REFERENCES Products(ID),
		
		CONSTRAINT ReqID_ProdID UNIQUE(RequestID, ProductID)
	);

ALTER TABLE Users
ADD LoyalityID INT;


