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

-- Inserts
-- edit test for github

-- Insert into Location table
insert into Location values(1, "123 Street St. County");
insert into Location values(2, "321 Town St. Diffcounty");

-- Insert into Manager table
insert into Manager values(1, "John ManagerSon", 1);
insert into Manager values(2, "Jane ManagerDaughter", 1);
insert into Manager values(3, "Jay ManagerChild", 2);

-- Insert into Item table
insert into Item values(1,"Dog Food");
insert into Item values(2, "Cat Food");
insert into Item values(3, "Fish Food");
insert into Item values(4, "Crickets");
insert into Item values(5, "Food Bowl");
insert into Item values(6, "Ball");

-- Insert into Stock table
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

-- Insert into Job table
insert into Job values(1,"Cashier");
insert into Job values(2, "Janitor");
insert into Job values(3, "Stocker");

-- Insert into Customer table
insert into Customer values(1,"Stacey Stacey");
insert into Customer values(2,"Haylie Hayson XI");
insert into Customer values(3,"Hay Hayson XIII");
insert into Customer values(4,"Joe Tutankhamun");
insert into Customer values(5,"Bob Sponge");
insert into Customer values(6,"Bob T. Builder");

-- Insert into Pet
insert into Pet values(1, "Dawg", "Cat", TRUE, 1, null);
insert into Pet values(2, "Katt", "Hamster", FALSE, 1, 1);
insert into Pet values(3, "Kyle", "Armadillo", FALSE, 1, 4);
insert into Pet values(4, "IMPLODING DINNER PIE", "Horse", FALSE, 1, 3);
insert into Pet values(5, "Haylie", "Dog", TRUE, 1, null);
insert into Pet values(6, "Parrotson", "Parrot", TRUE, 2, null);
insert into Pet values(7, "exploding breakfast salad", "Horse", FALSE, 2, 2);
insert into Pet values(8, "Bertie", "Dog", TRUE, 2, null);
insert into Pet values(9, "Gert", "Guinea Pig", TRUE, 2, null);
insert into Pet values(10, "Sandy", "Chinchilla", FALSE, 2, 5);
insert into Pet values(11, "Brick", "Cat", FALSE, 2, 6);
insert into Pet values(12, "Goku", "Devil's Hole Pupfish", FALSE, 2, 4);
insert into Pet values(13, "Jeremy", "Dodo", FALSE, 2, 1);

-- Insert into VetRecord
insert into VetRecord values(1, 4);
insert into VetRecord values(2, 7);
insert into VetRecord values(3, 9);
insert into VetRecord values(4, 10);
insert into VetRecord values(5, 11);
insert into VetRecord values(6, 12);
insert into VetRecord values(7, 12);
insert into VetRecord values(8, 13);

-- Insert into Medication 
insert into Medication values(1, "Ivermectin");
insert into Medication values(2, "Cough Drops");
insert into Medication values(3, "Calpol");
insert into Medication values(4, "Eyedrops");
insert into Medication values(5, "Nurofen");
insert into Medication values(6, "Septrin");

-- Insert into Prescription VetRecord M:N
insert into Prescription values(1, 1, "500g");
insert into Prescription values(2, 1, "520g");
insert into Prescription values(3, 6, "20g");
insert into Prescription values(4, 3, "30g");
insert into Prescription values(5, 2, "1g");
insert into Prescription values(6, 4, "30kl");
insert into Prescription values(1, 3, "20kg");
insert into Prescription values(6, 1, "20g");
insert into Prescription values(7, 5, "40moles");

-- Insert into CustomerOrder
insert into CustomerOrder values(1, 1);
insert into CustomerOrder values(2, 4);
insert into CustomerOrder values(3, 3);
insert into CustomerOrder values(4, 2);
insert into CustomerOrder values(5, 5);
insert into CustomerOrder values(6, 6);
insert into CustomerOrder values(7, 4);
insert into CustomerOrder values(8, 1);
insert into CustomerOrder values(9, 1);

-- Insert into OrderLine CustomerOrder M:N
insert into OrderLine values(1, 1, 10);
insert into OrderLine values(2, 3, 34);
insert into OrderLine values(3, 2, 21);
insert into OrderLine values(4, 1, 3);
insert into OrderLine values(5, 4, 65);
insert into OrderLine values(6, 5, 31);
insert into OrderLine values(7, 6, 12);
insert into OrderLine values(8, 2, 781);
insert into OrderLine values(1, 1, 54);
insert into OrderLine values(3, 3, 12);

-- Insert into Supplier
insert into Supplier values(1, "WordStop");
insert into Supplier values(2, "Horse & Friends");
insert into Supplier values(3, "Noun's Ya Need");
insert into Supplier values(4, "Fore For 4");
insert into Supplier values(5, "Mouse Trap");
insert into Supplier values(6, "Paw Print");

-- Insert into Supply
insert into Supply values(1, 1, 13);
insert into Supply values(2, 1, 12);
insert into Supply values(1, 2, 6);
insert into Supply values(5, 3, 5);
insert into Supply values(3, 4, 12);
insert into Supply values(4, 1, 8);
insert into Supply values(4, 3, 4);
insert into Supply values(2, 4, 14);
insert into Supply values(6, 5, 3);
insert into Supply values(6, 6, 14);