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
    ItemAmount INT NULL CHECK (ItemAmount >= 0),
    SellPrice  DECIMAL(6,2) NOT NULL CHECK (SellPrice > 0),
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
    OrderAmount INT NOT NULL CHECK (OrderAmount > 0),
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
    BuyPrice   DECIMAL(6,2) NOT NULL CHECK (BuyPrice > 0),
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
insert into Stock values(1,1,61,12);
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

-- Insert into Employee table
insert into Employee values(1, "Joe Employeeson", 1);
insert into Employee values(2, "Jaiden Employeedaughter", 1);
insert into Employee values(3, "Jaden Employeechild", 2);
insert into Employee values(4, "Jack MacEmployee", 3);
insert into Employee values(5, "Jo O'Employee", 3);
insert into Employee values(6, "Julia NiEmployee", 1);
insert into Employee values(7, "Joe MhicEmployee", 2);
insert into Employee values(8, "Jackelyn UíEmployee", 1);

-- Insert into EmployeeLocation, employee 2 works at both
insert into EmployeeLocation values(1, 1);
insert into EmployeeLocation values(1, 2);
insert into EmployeeLocation values(1, 3);
insert into EmployeeLocation values(1, 4);
insert into EmployeeLocation values(1, 6);
insert into EmployeeLocation values(2, 2);
insert into EmployeeLocation values(2, 5);
insert into EmployeeLocation values(2, 7);
insert into EmployeeLocation values(2, 8);

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
insert into Prescription values(7, 3, "20kg");
insert into Prescription values(6, 1, "20g");
insert into Prescription values(8, 5, "40moles");

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
insert into OrderLine values(9, 1, 54);
insert into OrderLine values(9, 3, 12);

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
-- Read, queries joining multiple tables

-- each customer's pets and which branch they're registered at
SELECT c.CustomerName, p.PetName, p.PetSpecies, l.LocationAddress
FROM Customer c
JOIN Pet p      ON p.CustomerID = c.CustomerID
JOIN Location l ON l.LocationID = p.LocationID
ORDER BY c.CustomerName;

-- full vet history, which pet got what
SELECT p.PetName, v.RecordID, m.MedicationName, pr.MedicationAmount
FROM Pet p
JOIN VetRecord v     ON v.PetID = p.PetID
JOIN Prescription pr ON pr.RecordID = v.RecordID
JOIN Medication m    ON m.MedicationID = pr.MedicationID
ORDER BY p.PetName, v.RecordID;

-- what's on each order
SELECT o.OrderID, c.CustomerName, i.ItemName, ol.OrderAmount
FROM CustomerOrder o
JOIN Customer c   ON c.CustomerID = o.CustomerID
JOIN OrderLine ol ON ol.OrderID = o.OrderID
JOIN Item i       ON i.ItemID = ol.ItemID
ORDER BY o.OrderID;

-- Indexes
-- staff look pets up by species and customers by name, neither is a key
EXPLAIN SELECT * FROM Pet WHERE PetSpecies = "Horse";
CREATE INDEX idx_pet_species ON Pet (PetSpecies);
EXPLAIN SELECT * FROM Pet WHERE PetSpecies = "Horse";

EXPLAIN SELECT * FROM Customer WHERE CustomerName = "Stacey Stacey";
CREATE INDEX idx_customer_name ON Customer (CustomerName);
EXPLAIN SELECT * FROM Customer WHERE CustomerName = "Stacey Stacey";

-- Look up items by their name
EXPLAIN SELECT * FROM Item WHERE ItemName = "Cat Food";
CREATE INDEX idx_item_name ON Item (ItemName);
EXPLAIN SELECT * FROM Item WHERE ItemName = "Cat Food";

-- look up medication by name
EXPLAIN SELECT * FROM Medication WHERE MedicationName = "Ivermectin";
CREATE INDEX idx_medi_name ON Medication (MedicationName);
EXPLAIN SELECT * FROM Medication WHERE MedicationName = "Ivermectin";

-- Views

-- security view, counter staff see pets for sale but not owners or vet info
CREATE VIEW PetsForSale AS
SELECT p.PetID, p.PetName, p.PetSpecies, l.LocationAddress
FROM Pet p
JOIN Location l ON l.LocationID = p.LocationID
WHERE p.PetInStore = TRUE AND p.CustomerID IS NULL;

-- security view, staff list without IDs
CREATE VIEW StaffDirectory AS
SELECT e.EmployeeName, j.JobName, l.LocationAddress
FROM Employee e
JOIN Job j              ON j.JobID = e.JobID
JOIN EmployeeLocation el ON el.EmployeeID = e.EmployeeID
JOIN Location l         ON l.LocationID = el.LocationID;

-- summary for managers, stock and its value per branch
CREATE VIEW StockValueByLocation AS
SELECT l.LocationAddress,
       COUNT(s.ItemID)                 AS ItemsStocked,
       SUM(s.ItemAmount)               AS TotalUnits,
       SUM(s.ItemAmount * s.SellPrice) AS StockValue
FROM Location l
JOIN Stock s ON s.LocationID = l.LocationID
GROUP BY l.LocationAddress;

-- summary for managers, vet work done per branch
CREATE VIEW VetSummaryByLocation AS
SELECT l.LocationAddress,
       COUNT(DISTINCT p.PetID)    AS PetsTreated,
       COUNT(DISTINCT v.RecordID) AS VetRecords,
       COUNT(pr.MedicationID)     AS Prescriptions
FROM Location l
JOIN Pet p           ON p.LocationID = l.LocationID
JOIN VetRecord v     ON v.PetID = p.PetID
JOIN Prescription pr ON pr.RecordID = v.RecordID
GROUP BY l.LocationAddress;

-- Creating a view of each supplier and what items they supply
CREATE VIEW SuppliersAndItems AS
SELECT s.SupplierName, i.ItemName
FROM Supplier s
JOIN Supply ON s.SupplierID = Supply.SupplierID
JOIN Item i ON Supply.ItemID = i.ItemID

-- Creating a view of each customer, the item they have ordered, and how much of each item they ordered
CREATE VIEW CustomerAndOrderedItems AS
SELECT c.CustomerName, i.ItemName, o.OrderAmount
FROM Customer c
JOIN CustomerOrder ON c.CustomerID = CustomerOrder.CustomerID
JOIN OrderLine o ON CustomerOrder.OrderID = o.OrderID
JOIN Item I ON o.ItemID = i.ItemID


SELECT * FROM PetsForSale;
SELECT * FROM StaffDirectory;
SELECT * FROM StockValueByLocation;
SELECT * FROM VetSummaryByLocation;
SELECT * FROM SuppliersAndItems;
SELECT * FROM CustomerAndOrderedItems;

-- Triggers

CREATE TABLE StockAudit (
    AuditID    INT NOT NULL AUTO_INCREMENT,
    LocationID INT NOT NULL,
    ItemID     INT NOT NULL,
    OldAmount  INT NULL,
    NewAmount  INT NULL,
    ChangedBy  VARCHAR(100) NOT NULL,
    ChangedAt  DATETIME NOT NULL,
    PRIMARY KEY (AuditID)
);

DELIMITER //

-- auditing, logs every change to a stock amount
CREATE TRIGGER StockAmountAudit
AFTER UPDATE ON Stock
FOR EACH ROW
BEGIN
    IF NOT (OLD.ItemAmount <=> NEW.ItemAmount) THEN
        INSERT INTO StockAudit
            (LocationID, ItemID, OldAmount, NewAmount, ChangedBy, ChangedAt)
        VALUES
            (NEW.LocationID, NEW.ItemID, OLD.ItemAmount, NEW.ItemAmount,
             CURRENT_USER(), NOW());
    END IF;
END //

-- constraint, can't order more of an item than all branches have together
CREATE TRIGGER OrderLineStockCheck
BEFORE INSERT ON OrderLine
FOR EACH ROW
BEGIN
    IF NEW.OrderAmount > (SELECT IFNULL(SUM(ItemAmount), 0)
                          FROM Stock WHERE ItemID = NEW.ItemID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Not enough stock for this order';
    END IF;
END //

-- Stored procedures

-- adds stock to a branch, the audit trigger logs it
CREATE PROCEDURE RestockItem(IN pLocationID INT, IN pItemID INT, IN pAmount INT)
BEGIN
    UPDATE Stock
    SET ItemAmount = IFNULL(ItemAmount, 0) + pAmount
    WHERE LocationID = pLocationID AND ItemID = pItemID;
END //

-- a pet's full vet history
CREATE PROCEDURE GetPetHistory(IN pPetID INT)
BEGIN
    SELECT p.PetName, v.RecordID, m.MedicationName, pr.MedicationAmount
    FROM Pet p
    JOIN VetRecord v     ON v.PetID = p.PetID
    JOIN Prescription pr ON pr.RecordID = v.RecordID
    JOIN Medication m    ON m.MedicationID = pr.MedicationID
    WHERE p.PetID = pPetID;
END //

-- Get the suppliers that are supplying to a location and what item they are supplying
CREATE PROCEDURE GetLocationSuppliers(IN pLocationID INT)
BEGIN
    SELECT l.LocationID, l.LocationAddress, i.ItemName, s.SupplierName
    FROM Location l
    JOIN Stock st ON l.LocationID = st.LocationID
    JOIN Item i ON st.ItemID = i.ItemID
    JOIN Supply su ON i.ItemID = su.ItemID
    JOIN Supplier s ON su.SupplierID = s.SupplierID
    WHERE l.LocationID = pLocationID;
END //

DELIMITER ;

CALL RestockItem(2, 6, 25);
CALL GetPetHistory(12);
Call GetLocationSuppliers(1);
SELECT * FROM StockAudit;

-- trigger test, this one gets rejected since there's only 30 food bowls
-- insert into OrderLine values(9, 5, 500);

-- Update

-- Bertie got sold to Bob Sponge
UPDATE Pet SET PetInStore = FALSE, CustomerID = 5 WHERE PetID = 8;

-- price change on crickets at branch 2
UPDATE Stock SET SellPrice = 25.00 WHERE LocationID = 2 AND ItemID = 4;

-- sold 10 bags of dog food at branch 1, shows up in StockAudit
UPDATE Stock SET ItemAmount = ItemAmount - 10 WHERE LocationID = 1 AND ItemID = 1;
SELECT * FROM StockAudit;

-- Delete

-- eyedrops taken off Goku's record
DELETE FROM Prescription WHERE RecordID = 6 AND MedicationID = 4;

-- order 7 cancelled, lines go first because of the FK
DELETE FROM OrderLine WHERE OrderID = 7;
DELETE FROM CustomerOrder WHERE OrderID = 7;

-- Transactions

-- both inserts kept
START TRANSACTION;
INSERT INTO CustomerOrder VALUES (10, 3);
INSERT INTO OrderLine VALUES (10, 4, 5);
COMMIT;

-- both inserts undone
START TRANSACTION;
INSERT INTO CustomerOrder VALUES (11, 6);
INSERT INTO OrderLine VALUES (11, 5, 2);
ROLLBACK;

-- 10 is there, 11 isn't
SELECT * FROM CustomerOrder WHERE OrderID IN (10, 11);

-- Database administration

DROP USER IF EXISTS 'cashier'@'localhost';
DROP USER IF EXISTS 'vet'@'localhost';
CREATE USER 'cashier'@'localhost' IDENTIFIED BY 'Cashier123!';
CREATE USER 'vet'@'localhost' IDENTIFIED BY 'Vet123!';

GRANT SELECT ON petshop.PetsForSale TO 'cashier'@'localhost';
GRANT SELECT, UPDATE ON petshop.Stock TO 'cashier'@'localhost';
GRANT SELECT, INSERT ON petshop.VetRecord TO 'vet'@'localhost';
GRANT SELECT, INSERT ON petshop.Prescription TO 'vet'@'localhost';
GRANT EXECUTE ON PROCEDURE petshop.GetPetHistory TO 'vet'@'localhost';
SHOW GRANTS FOR 'cashier'@'localhost';

-- cashier shouldn't change stock directly anymore
REVOKE UPDATE ON petshop.Stock FROM 'cashier'@'localhost';
SHOW GRANTS FOR 'cashier'@'localhost';
