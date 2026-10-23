-- Pet shop CA1 - database schema

DROP DATABASE IF EXISTS petshop;
CREATE DATABASE petshop;
USE petshop;

-- table #1
CREATE TABLE Location (
    LocationID      INT          NOT NULL,
    LocationAddress VARCHAR(255) NOT NULL,
    PRIMARY KEY (LocationID)
);

-- 2
CREATE TABLE Manager (
    ManagerID   INT          NOT NULL,
    ManagerName VARCHAR(100) NOT NULL,
    LocationID  INT          NOT NULL,
    PRIMARY KEY (ManagerID),
    FOREIGN KEY (LocationID) REFERENCES Location (LocationID)
);

-- table #3
CREATE TABLE Item (
    ItemID   INT          NOT NULL,
    ItemName VARCHAR(100) NOT NULL,
    PRIMARY KEY (ItemID)
);


CREATE TABLE Stock (
    LocationID INT NOT NULL,
    ItemID     INT NOT NULL,
    ItemAmount INT NULL,
    SellPrice   DECIMAL(3,2) NOT NULL,
    PRIMARY KEY (LocationID, ItemID),
    FOREIGN KEY (LocationID) REFERENCES Location (LocationID),
    FOREIGN KEY (ItemID)     REFERENCES Item (ItemID)
);

CREATE TABLE Job (
    JobID   INT         NOT NULL,
    JobName VARCHAR(50) NOT NULL,
    PRIMARY KEY (JobID)
);

CREATE TABLE Employee (
    EmployeeID   INT          NOT NULL,
    EmployeeName VARCHAR(100) NOT NULL,
    JobID        INT          NOT NULL,
    PRIMARY KEY (EmployeeID),
    FOREIGN KEY (JobID) REFERENCES Job (JobID)
);

-- link table
CREATE TABLE EmployeeLocation (
    LocationID INT NOT NULL,
    EmployeeID INT NOT NULL,
    PRIMARY KEY (LocationID, EmployeeID),
    FOREIGN KEY (LocationID) REFERENCES Location (LocationID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee (EmployeeID)
);

CREATE TABLE Customer (
    CustomerID   INT          NOT NULL,
    CustomerName VARCHAR(100) NOT NULL,
    PRIMARY KEY (CustomerID)
);

CREATE TABLE Pet (
    PetID      INT          NOT NULL,
    PetName    VARCHAR(100) NOT NULL,
    PetSpecies VARCHAR(50)  NOT NULL,
    PetInStore BOOLEAN      NOT NULL,
    LocationID INT          NOT NULL,
    CustomerID INT          NULL,
    PRIMARY KEY (PetID),
    FOREIGN KEY (LocationID) REFERENCES Location (LocationID),
    FOREIGN KEY (CustomerID) REFERENCES Customer (CustomerID)
);

CREATE TABLE VetRecord (
    RecordID INT NOT NULL,
    PetID    INT NOT NULL,
    PRIMARY KEY (RecordID),
    FOREIGN KEY (PetID) REFERENCES Pet (PetID)
);

CREATE TABLE Medication (
    MedicationID   INT          NOT NULL,
    MedicationName VARCHAR(100) NOT NULL,
    PRIMARY KEY (MedicationID)
);

-- VetRecord M:N
CREATE TABLE Prescription (
    RecordID         INT         NOT NULL,
    MedicationID     INT         NOT NULL,
    MedicationAmount VARCHAR(20) NOT NULL,
    PRIMARY KEY (RecordID, MedicationID),
    FOREIGN KEY (RecordID)     REFERENCES VetRecord (RecordID),
    FOREIGN KEY (MedicationID) REFERENCES Medication (MedicationID)
);

CREATE TABLE CustomerOrder (
    OrderID    INT NOT NULL,
    CustomerID INT NOT NULL,
    PRIMARY KEY (OrderID),
    FOREIGN KEY (CustomerID) REFERENCES Customer (CustomerID)
);

-- CustomerOrder M:N
CREATE TABLE OrderLine (
    OrderID     INT NOT NULL,
    ItemID      INT NOT NULL,
    OrderAmount INT NOT NULL,
    PRIMARY KEY (OrderID, ItemID),
    FOREIGN KEY (OrderID) REFERENCES CustomerOrder (OrderID),
    FOREIGN KEY (ItemID)  REFERENCES Item (ItemID)
);

CREATE TABLE Supplier (
    SupplierID   INT          NOT NULL,
    SupplierName VARCHAR(100) NOT NULL,
    PRIMARY KEY (SupplierID)
);

CREATE TABLE Supply (
    SupplierID INT NOT NULL,
    ItemID     INT NOT NULL,
    BuyPrice   DECIMAL(3,2) NOT NULL,
    PRIMARY KEY (SupplierID, ItemID),
    FOREIGN KEY (SupplierID) REFERENCES Supplier (SupplierID),
    FOREIGN KEY (ItemID)     REFERENCES Item (ItemID)
);

--- Inserts
-- edit test for github

--Insert into Location table
insert into Location values(1, "123 Street St. County");
insert into Location values(2, "321 Town St. Diffcounty");

--Insert into Manager table
insert into Manager values(1, "John ManagerSon", 1);
insert into Manager values(2, "Jane ManagerDaughter", 1);
insert into Manager values(3, "Jay ManagerChild", 2);

--Insert into Item table
insert into Item values(1,"Dog Food");
insert into Item values(2, "Cat Food");
insert into Item values(3, "Fish Food");
insert into Item values(4, "Crickets");
insert into Item values(5, "Food Bowl");
insert into Item values(6, "Ball");

--Insert into Stock table
insert into Stock values(1,1,1,12);
insert into Stock values(1,1,60,15);
insert into Stock values(1,2,451,12);
insert into Stock values(1,3,12,6);
insert into Stock values(1,4,90,30);
insert into Stock values(2,1,12,12);
insert into Stock values(2,3,12,8);
insert into Stock values(2,4,12,30);
insert into Stock values(2,5,30,6);
insert into Stock values(2,6,null,20);

--Insert into Job table
insert into Job values(1,"Cashier");
insert into Job values(2, "Janitor");
insert into Job values(3, "Stocker");

--Insert into Customer table
insert into Customer values(1,"Stacey Stacey");
insert into Customer values(2,"Haylie Hayson XI");
insert into Customer values(3,"Hay Hayson XIII");
insert into Customer values(4,"Joe Tutankhamun");
insert into Customer values(5,"Bob Sponge");
insert into Customer values(6,"Bob T. Builder");