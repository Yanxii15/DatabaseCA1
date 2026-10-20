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
    SupplierID INT NOT NULL,
    ItemAmount INT NULL,
    PRIMARY KEY (LocationID, ItemID, SupplierID),
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