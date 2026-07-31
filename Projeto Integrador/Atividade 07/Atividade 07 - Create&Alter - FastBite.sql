CREATE DATABASE FastBite;

USE FastBite;

CREATE TABLE Restaurants (
	RestaurantID INT AUTO_INCREMENT PRIMARY KEY,
    RestaurantName VARCHAR(30) NOT NULL,
    RestaurantInfo VARCHAR(255),
    Phone VARCHAR(11) NOT NULL,
    LegalCode VARCHAR(14) NOT NULL,
	CONSTRAINT uk_restaurants_phone
		UNIQUE (Phone),
	CONSTRAINT uk_restaurants_legalcode
		UNIQUE (LegalCode)
);

CREATE TABLE Products (
	ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(20) NOT NULL,
    ProductInfo VARCHAR(100),
    ProductType VARCHAR(15),
    Price DECIMAL(10, 2) NOT NULL,
    CONSTRAINT ck_products_price
		CHECK (Price > 0)
);

CREATE TABLE Users (
	UserID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(30) NOT NULL,
    LastName VARCHAR(30) NOT NULL,
    Email VARCHAR(300) NOT NULL,
    UserPassword VARCHAR(255) NOT NULL,
    Phone VARCHAR(11) NOT NULL,
    CONSTRAINT uk_users_email
		UNIQUE (Email),
	CONSTRAINT uk_users_phone
		UNIQUE (Phone)
);

CREATE TABLE RestaurantsAddress (
	AddressID INT AUTO_INCREMENT PRIMARY KEY,
    RestaurantID INT NOT NULL,
    Street VARCHAR(50) NOT NULL,
    StreetNumber VARCHAR(15),
    District VARCHAR(50) NOT NULL,
    PostalCode VARCHAR(8) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Complement VARCHAR(255),
    CONSTRAINT fk_restaurantsaddress_restaurantid
		FOREIGN KEY (RestaurantID) REFERENCES Restaurants (RestaurantID),
	CONSTRAINT uk_restaurantsaddress_restaurantid
		UNIQUE (RestaurantID)
);

CREATE TABLE Menus (
	MenuID INT AUTO_INCREMENT PRIMARY KEY,
    RestaurantID INT NOT NULL,
    ProductID INT,
    MenuName VARCHAR(20) NOT NULL,
    MenuInfo VARCHAR(255),
    CONSTRAINT fk_menus_restaurantid
		FOREIGN KEY (RestaurantID) REFERENCES Restaurants (RestaurantID),
	CONSTRAINT fk_menus_productid
		FOREIGN KEY (ProductID) REFERENCES Products (ProductID)
);

CREATE TABLE UsersAddress (
	AddressID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    Street VARCHAR(50) NOT NULL,
    StreetNumber VARCHAR(15),
    District VARCHAR(50) NOT NULL,
    PostalCode VARCHAR(8) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Complement VARCHAR(255),
    CONSTRAINT fk_usersaddress_userid
		FOREIGN KEY (UserID) REFERENCES Users (UserID)
);

CREATE TABLE Coupons (
	CouponID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    Avaliability BOOLEAN NOT NULL,
    StartDate DATETIME,
    FinalDate DATETIME,
    CouponType VARCHAR(20) NOT NULL,
    Rules VARCHAR(255) NOT NULL,
    Discount DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_coupons_userid
		FOREIGN KEY (UserID) REFERENCES Users (UserID),
	CONSTRAINT ck_coupons_discount
		CHECK (Discount > 0)
);	

CREATE TABLE Orders (
	OrderID INT AUTO_INCREMENT PRIMARY KEY,
    RestaurantID INT NOT NULL,
    UserID INT NOT NULL,
    CouponID INT,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    EstimatedDate TIME NOT NULL,
    Payment DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_orders_restaurantid
		FOREIGN KEY (RestaurantID) REFERENCES Restaurants (RestaurantID),
	CONSTRAINT fk_orders_userid
		FOREIGN KEY (UserID) REFERENCES Users (UserID),
	CONSTRAINT fk_orders_couponid
		FOREIGN KEY (CouponID) REFERENCES Coupons (CouponID)
);

CREATE TABLE OrderDetails (
	OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitaryPrice DECIMAL(10, 2) NOT NULL,
    TotalPrice DECIMAL(10, 2) AS (UnitaryPrice * Quantity) STORED,
    CONSTRAINT fk_orderdetails_orderid
		FOREIGN KEY (OrderID) REFERENCES Orders (OrderID),
	CONSTRAINT fk_orderdetails_productid
		FOREIGN KEY (ProductID) REFERENCES Products (ProductID),
	CONSTRAINT ck_orderdetails_quantity
		CHECK (Quantity > 0),
	CONSTRAINT ck_orderdetails_unitaryprice
		CHECK (UnitaryPrice > 0)
);

CREATE TABLE DeliveryPersonnel (
	PersonID INT AUTO_INCREMENT PRIMARY KEY,
    OrderDetailID INT,
    FirstName VARCHAR(30) NOT NULL,
    LastName VARCHAR(30) NOT NULL,
    BirthDate DATE NOT NULL,
    LegalCode VARCHAR(11) NOT NULL,
    Photo BLOB,
    CONSTRAINT fk_deliverypersonnel_orderdetailid
		FOREIGN KEY (OrderDetailID) REFERENCES OrderDetails (OrderDetailID),
	CONSTRAINT uk_deliverypersonnel_legalcode
		UNIQUE (LegalCode)
);

CREATE TABLE Vehicles (
	VehicleID INT AUTO_INCREMENT PRIMARY KEY,
    PersonID INT NOT NULL,
    Model VARCHAR(30) NOT NULL,
    Plate VARCHAR(7) NOT NULL,
    Note VARCHAR(100),
    CONSTRAINT fk_vehicles_personid
		FOREIGN KEY (PersonID) REFERENCES DeliveryPersonnel (PersonID),
	CONSTRAINT uk_vehicles_plate
		UNIQUE (Plate)
);

ALTER TABLE Coupons
	ADD COLUMN Quantity INT NOT NULL,
	ADD CONSTRAINT ck_coupons_quantity
		CHECK (Quantity >= 0);

ALTER TABLE DeliveryPersonnel
	ADD COLUMN RegisterDate DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL;

ALTER TABLE Menus
	ADD COLUMN RegisterDate DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
	ADD COLUMN LastChangeDate DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL;

ALTER TABLE Orders
	ADD COLUMN PaymentType VARCHAR(30) NOT NULL;

ALTER TABLE Products
	ADD COLUMN RegisterDate DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
	ADD COLUMN PriceChangeDate DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL;

ALTER TABLE Restaurants
	ADD COLUMN RestaurantType VARCHAR(50);
    
ALTER TABLE RestaurantsAddress
	ADD COLUMN RegisterDate DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
	ADD COLUMN AddressChangeDate DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL;
    
ALTER TABLE Users
	ADD COLUMN AlternativeEmail VARCHAR(300),
    ADD CONSTRAINT uk_users_alternativeemail
		UNIQUE (AlternativeEmail);
        
ALTER TABLE UsersAddress
	ADD COLUMN RegisterDate DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
	ADD COLUMN AddressChangeDate DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL;
    
ALTER TABLE Vehicles
	ADD COLUMN ActiveStage BOOLEAN DEFAULT TRUE NOT NULL;
    
CREATE TABLE LogProduct (
	LogID INT AUTO_INCREMENT PRIMARY KEY,
    OldPrice DECIMAL(10, 2),
    NewPrice DECIMAL(10, 2),
    Difference DECIMAL(10, 2) AS (OldPrice - NewPrice) VIRTUAL,
    ChangeDate DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL
);
