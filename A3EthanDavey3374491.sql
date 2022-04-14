-- C3374491 | Ethan Davey
-- 17/10/20
-- COMP1140 | Assignment 3
-- Monday 4PM to 6PM


-- START DROP TABLES

DROP TABLE QIngredientOrder;
DROP TABLE MenuItemOrder;
DROP TABLE QIngredient;
DROP TABLE Orders;
DROP TABLE Customer;
DROP TABLE Pay;
DROP TABLE Delivery;
DROP TABLE Shifts;
DROP TABLE Employee;
DROP TABLE OrderPayRecord;
DROP TABLE IngredientOrder;
DROP TABLE Ingredient;
DROP TABLE MenuItem;


-- END DROP TABLES
-- START CREATE TABLES


CREATE TABLE MenuItem(
MenuItemCode       CHAR(10) PRIMARY KEY,
MIName             VARCHAR(50),
MISize             VARCHAR(50),
MIPrice            FLOAT,
)

CREATE TABLE Ingredient(
IngredientCode     CHAR(10) PRIMARY KEY,
IName              VARCHAR(50),
IType              VARCHAR(50),
IDescription       TEXT,
ILevelAtStocktake  INT,
ISuggestedLevel    INT,
IReorderLevel      INT,
IDateOfStockkake   DATE
)

CREATE TABLE IngredientOrder(
IngredientOrderNo  CHAR(10) PRIMARY KEY,
IODateOfOrder      DATE,
IODateReceived     DATE,
IOTotalAmount      FLOAT,
IOStatus           VARCHAR(50),
IODescription      TEXT,
)

CREATE TABLE OrderPayRecord(
PaymentApprovalNo  CHAR(10) PRIMARY KEY,
PaymentMethod      VARCHAR(11),
TotalAmountDue     FLOAT
)

CREATE TABLE Employee(
EmployeeNo         CHAR(10) PRIMARY KEY,
EFirstName         VARCHAR(50),
ELastName          VARCHAR(50),
EPostalAddress     VARCHAR(255),
EContactNumber     CHAR(10),
ETaxFileNumber     CHAR(9),
EPaymentRate       FLOAT,
EStatus            CHAR(9),
EDescription       TEXT,
EType              VARCHAR(7),
ELicenceNo         VARCHAR(15),
EBankAccountNo     CHAR(12),
EBankCode          CHAR(6),
EBankName          VARCHAR(255)
)

CREATE TABLE Shifts(
ShiftID            CHAR(10) PRIMARY KEY,
SStartDate         DATE,
SStartTime         TIME,
SEndDate           DATE,
SEndTime           TIME,
SType              VARCHAR(7),
EmployeeNo         CHAR(10),
FOREIGN KEY(EmployeeNo) REFERENCES Employee(EmployeeNo) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE Delivery(
DeliveryNo         CHAR(10) PRIMARY KEY,
DAddress           VARCHAR(255),
DDate              DATE,
DTime              TIME,
ShiftID            CHAR(10),
FOREIGN KEY(ShiftID) REFERENCES Shifts(ShiftID) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE Pay(
PayNo              CHAR(10),
GrossPay           FLOAT,
TaxWithheld        FLOAT,
TotalAmountPaid    FLOAT,
PayDate            DATE,
PayPeriodStartDate DATE,
PayPeriodEndDate   DATE,
EmployeeNo         CHAR(10)
FOREIGN KEY(EmployeeNo) REFERENCES Employee(EmployeeNo) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE Customer(
CustomerNo         CHAR(10) PRIMARY KEY,
CFirstName         VARCHAR(50),
CLastName          VARCHAR(50),
CAddress           VARCHAR(255),
CPhone             CHAR(10),
CStatus            BIT DEFAULT 0 NOT NULL,
)

CREATE TABLE Orders(
OrderNo            CHAR(10) PRIMARY KEY,
ODate              DATE,
OTime              TIME,
OStatus            BIT DEFAULT 1 NOT NULL,
OType              VARCHAR(7),
ODescription       TEXT,
PaymentApprovalNo  CHAR(10),
EmployeeNo         CHAR(10),
CustomerNo         CHAR(10)
FOREIGN KEY(PaymentApprovalNo) REFERENCES OrderPayRecord(PaymentApprovalNo) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY(EmployeeNo) REFERENCES Employee(EmployeeNo) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY(CustomerNo) REFERENCES Customer(CustomerNo) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE QIngredient(
MenuItemCode       CHAR(10),
IngredientCode     CHAR(10),
Quantity           INT NOT NULL,
PRIMARY KEY (MenuItemCode, IngredientCode),
CONSTRAINT FK_mii FOREIGN KEY(MenuItemCode) REFERENCES MenuItem(MenuItemCode) ON UPDATE CASCADE ON DELETE NO ACTION,
CONSTRAINT FK_iii FOREIGN KEY(IngredientCode) REFERENCES Ingredient(IngredientCode) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE MenuItemOrder(
OrderNo            CHAR(10),
MenuItemCode       CHAR(10),
Quantity           INT NOT NULL,
PRIMARY KEY (OrderNo, MenuItemCode),
CONSTRAINT FK_oio FOREIGN KEY(OrderNo) REFERENCES Orders(OrderNo) ON UPDATE CASCADE ON DELETE NO ACTION,
CONSTRAINT FK_mio FOREIGN KEY(MenuItemCode) REFERENCES MenuItem(MenuItemCode) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE QIngredientOrder(
IngredientCode     CHAR(10),
IngredientOrderNo  CHAR(10),
Quantity           INT NOT NULL,
PRIMARY KEY (IngredientCode, IngredientOrderNo),
CONSTRAINT FK_qmi FOREIGN KEY(IngredientCode) REFERENCES Ingredient(IngredientCode) ON UPDATE CASCADE ON DELETE NO ACTION,
CONSTRAINT FK_qio FOREIGN KEY(IngredientOrderNo) REFERENCES IngredientOrder(IngredientOrderNo) ON UPDATE CASCADE ON DELETE NO ACTION
)



-- END CREATE TABLES
-- START INSERT

INSERT INTO MenuItem VALUES('M000000001', 'Peperoni Pizza', 'Large', '5.00')
INSERT INTO MenuItem VALUES('M000000002', 'Cheese Pizza', 'Large', '5.00')
INSERT INTO MenuItem VALUES('M000000003', 'Meat Lovers Pizza', 'Large', '12.55')
INSERT INTO MenuItem VALUES('M000000004', 'Hawaiian Pizza', 'Large', '5.00')
INSERT INTO MenuItem VALUES('M000000005', 'Ham and Cheese Pizza', 'Large', '5.00')
INSERT INTO MenuItem VALUES('M000000006', 'Vegan Lovers Pizza', 'Large', '12.55')

INSERT INTO MenuItem VALUES('M000000007', 'Fanta', 'Small', '2.50')
INSERT INTO MenuItem VALUES('M000000008', 'Pepsi', 'Small', '2.50')
INSERT INTO MenuItem VALUES('M000000009', 'Sprite', 'Small', '2.50')
INSERT INTO MenuItem VALUES('M000000010', 'Fanta', 'Large', '4.50')
INSERT INTO MenuItem VALUES('M000000011', 'Pepsi', 'Large', '4.50')
INSERT INTO MenuItem VALUES('M000000012', 'Sprite', 'Large', '4.50')


INSERT INTO Ingredient VALUES('I000000001', 'Dough', 'Base', 'The base of the pizza', 
'200', '200', '125', '20211017')
INSERT INTO Ingredient VALUES('I000000002', 'Tomato', 'Sause', 'Lovely tomato sause', 
'80', '80', '5000', '20211017')
INSERT INTO Ingredient VALUES('I000000003', 'BBQ', 'Sause', 'Smokey BBQ sause', 
'6237', '6530', '5000', '20211017')
INSERT INTO Ingredient VALUES('I000000004', 'Cheese', 'Topping', 'Classic pizza cheese', 
'3221', '3540', '3000', '20211017')
INSERT INTO Ingredient VALUES('I000000005', 'Vegan Cheese', 'Topping', 'Great cheese that is vegan friendly', 
'1629', '1740', '1500', '20211017')
INSERT INTO Ingredient VALUES('I000000006', 'Peperoni', 'Topping', 'Beautiful peperoni', 
'6487', '2640', '5000', '20211017')
INSERT INTO Ingredient VALUES('I000000007', 'Cabanossi', 'Topping', 'Peperoni but small and not peperoni', 
'2378', '2450', '3000', '20211017')
INSERT INTO Ingredient VALUES('I000000008', 'Bacon', 'Topping', 'Who doesnt love this stuff?', 
'5486', '5600', '4500', '20211017')
INSERT INTO Ingredient VALUES('I000000009', 'Ham', 'Topping', 'Bacons sad cousin', 
'3489', '3560', '3000', '20211017')
INSERT INTO Ingredient VALUES('I000000010', 'Beef', 'Topping', '100% Aussie ground beef', 
'3078', '3150', '5000', '20211017')
INSERT INTO Ingredient VALUES('I000000011', 'Onion', 'Topping', 'Perfect for a snag',
'3612', '3490', '2500', '20211017')
INSERT INTO Ingredient VALUES('I000000012', 'Avocado', 'Topping', 'Dont get this or you cant buy a house!', 
'854', '880', '1000', '20211017')
INSERT INTO Ingredient VALUES('I000000013', 'Spinach', 'Topping', 'A leaf that you can eat', 
'1265', '1290', '1000', '20211017')
INSERT INTO Ingredient VALUES('I000000014', 'Pineapple', 'Topping', 'MMM tastes amazing', 
'3421', '3470', '2500', '20211017')


INSERT INTO QIngredient VALUES('M000000001', 'I000000001', 1)
INSERT INTO QIngredient VALUES('M000000001', 'I000000002', 20)
INSERT INTO QIngredient VALUES('M000000001', 'I000000004', 50)
INSERT INTO QIngredient VALUES('M000000001', 'I000000006', 30)

INSERT INTO QIngredient VALUES('M000000002', 'I000000001', 1)
INSERT INTO QIngredient VALUES('M000000002', 'I000000002', 20)
INSERT INTO QIngredient VALUES('M000000002', 'I000000004', 50)

INSERT INTO QIngredient VALUES('M000000003', 'I000000001', 1)
INSERT INTO QIngredient VALUES('M000000003', 'I000000003', 20)
INSERT INTO QIngredient VALUES('M000000003', 'I000000004', 50)
INSERT INTO QIngredient VALUES('M000000003', 'I000000006', 30)
INSERT INTO QIngredient VALUES('M000000003', 'I000000007', 30)
INSERT INTO QIngredient VALUES('M000000003', 'I000000008', 30)
INSERT INTO QIngredient VALUES('M000000003', 'I000000009', 30)
INSERT INTO QIngredient VALUES('M000000003', 'I000000010', 30)
INSERT INTO QIngredient VALUES('M000000003', 'I000000011', 30)

INSERT INTO QIngredient VALUES('M000000004', 'I000000001', 1)
INSERT INTO QIngredient VALUES('M000000004', 'I000000002', 20)
INSERT INTO QIngredient VALUES('M000000004', 'I000000004', 50)
INSERT INTO QIngredient VALUES('M000000004', 'I000000009', 30)
INSERT INTO QIngredient VALUES('M000000004', 'I000000014', 30)

INSERT INTO QIngredient VALUES('M000000005', 'I000000001', 1)
INSERT INTO QIngredient VALUES('M000000005', 'I000000002', 20)
INSERT INTO QIngredient VALUES('M000000005', 'I000000004', 50)
INSERT INTO QIngredient VALUES('M000000005', 'I000000009', 30)

INSERT INTO QIngredient VALUES('M000000006', 'I000000001', 1)
INSERT INTO QIngredient VALUES('M000000006', 'I000000002', 20)
INSERT INTO QIngredient VALUES('M000000006', 'I000000003', 50)
INSERT INTO QIngredient VALUES('M000000006', 'I000000011', 30)
INSERT INTO QIngredient VALUES('M000000006', 'I000000012', 30)
INSERT INTO QIngredient VALUES('M000000006', 'I000000013', 30)
INSERT INTO QIngredient VALUES('M000000006', 'I000000014', 30)


INSERT INTO IngredientOrder VALUES('IO00000004', '20211017', NULL, '265.10', 'Processed', 
	'Small order of sause and avo')
INSERT INTO IngredientOrder VALUES('IO00000003', '20211010', '20211013', '4520.30', 'Delivered', 
	'Major order of most toppings')
INSERT INTO IngredientOrder VALUES('IO00000002', '20211003', '20211005', '1563.25', 'Delivered', 
	'Just a coupla things for the shop')
INSERT INTO IngredientOrder VALUES('IO00000001', '20210926', '20210929', '2679.30', 'Delivered', 
	'Mad order bruv')


INSERT INTO OrderPayRecord VALUES('P000000001', 'Cash', '15.00')
INSERT INTO OrderPayRecord VALUES('P000000002', 'Credit Card', '5.00')
INSERT INTO OrderPayRecord VALUES('P000000003', 'Cash', '12.55')
INSERT INTO OrderPayRecord VALUES('P000000004', 'Cash', '20.55')
INSERT INTO OrderPayRecord VALUES('P000000005', 'Credit Card', '30.10')
INSERT INTO OrderPayRecord VALUES('P000000006', 'Credit Card', '25.10')
INSERT INTO OrderPayRecord VALUES('P000000007', 'Credit Card', '42.55')
INSERT INTO OrderPayRecord VALUES('P000000008', 'Cash', '5.00')
INSERT INTO OrderPayRecord VALUES('P000000009', 'Cash', '10.00')
INSERT INTO OrderPayRecord VALUES('P000000010', 'Cash', '62.20')
INSERT INTO OrderPayRecord VALUES('P000000011', 'Credit Card', '30.00')
INSERT INTO OrderPayRecord VALUES('P000000012', 'Credit Card', '5.00')
INSERT INTO OrderPayRecord VALUES('P000000013', 'Cash', '5.00')
INSERT INTO OrderPayRecord VALUES('P000000014', 'Cash', '10.00')
INSERT INTO OrderPayRecord VALUES('P000000015', 'Credit Card', '10.00')


INSERT INTO Employee VALUES('E000000001', 'Ethan', 'Davey', '123 University Drive', '0412345678', '570123456', 
	'18.85', 'Part-time', '#1 Employee of the Year!', 'Instore', NULL, '354567893241', '123456', 'The University Bank')
INSERT INTO Employee VALUES('E000000002', 'David', 'Smith', '9 Park Avenue', '0433669996', '570654321', 
	'14.30', 'Full-time', 'Full-time loser LOL', 'Driver', '12346578', '987654321654', '987654', 'The Money Bank')
INSERT INTO Employee VALUES('E000000003', 'Frank', 'Sinatra', '14 Water Drive', '0487564165', '570456132', 
	'18.85', 'Part-Time', 'Has a sick GTR', 'Driver', '597536467', '357459456123', '123456', 'The University Bank')
INSERT INTO Employee VALUES('E000000004', 'Ben', 'Dover', '8A/455 Newcastle Lane', '0445963987', '570369741', 
	'18.85', 'Part-Time', NULL, 'Instore', NULL, '166987126310', '234464', 'HellBank')


INSERT INTO Shifts VALUES('S000000003', '20211017', '16:00:00', '20211017', '23:00:00', 'Instore', 'E000000001')
INSERT INTO Shifts VALUES('S000000002', '20211016', '17:30:00', '20211016', '22:00:00', 'Instore', 'E000000001')
INSERT INTO Shifts VALUES('S000000001', '20211015', '17:00:00', '20211015', '20:00:00', 'Instore', 'E000000001')

INSERT INTO Shifts VALUES('S000000006', '20211017', '08:00:00', '20211022', '14:00:00', 'Driver', 'E000000002')
INSERT INTO Shifts VALUES('S000000005', '20211015', '08:00:00', '20211023', '14:00:00', 'Driver', 'E000000002')
INSERT INTO Shifts VALUES('S000000004', '20210901', '17:30:00', '20211024', '20:30:00', 'Driver', 'E000000002')

INSERT INTO Shifts VALUES('S000000009', '20211017', '14:00:00', '20211022', '18:00:00', 'Driver', 'E000000003')
INSERT INTO Shifts VALUES('S000000008', '20211016', '17:30:00', '20211023', '20:00:00', 'Driver', 'E000000003')
INSERT INTO Shifts VALUES('S000000007', '20211015', '07:30:00', '20211024', '12:00:00', 'Driver', 'E000000003')

INSERT INTO Shifts VALUES('S000000012', '20211016', '15:00:00', '20211022', '20:30:00', 'Instore', 'E000000004')
INSERT INTO Shifts VALUES('S000000011', '20211015', '17:30:00', '20211023', '23:30:00', 'Instore', 'E000000004')
INSERT INTO Shifts VALUES('S000000010', '20210902', '08:00:00', '20211024', '15:30:00', 'Instore', 'E000000004')


INSERT INTO Delivery VALUES('D000000001', '22 Cow Lane', '20211015', '17:22:33', 'S000000001')
INSERT INTO Delivery VALUES('D000000002', '123 Kyamba Close', '20211015', '18:03:56', 'S000000001')
INSERT INTO Delivery VALUES('D000000003', '5 University Drive', '20211016', '18:21:45', 'S000000002')
INSERT INTO Delivery VALUES('D000000004', '45 Jupiter Circuit', '20211017', '18:45:22', 'S000000003')
INSERT INTO Delivery VALUES('D000000005', '83 Mellon Crescent', '20211017', '19:46:01', 'S000000003')


INSERT INTO Pay VALUES('EP00000001', '273.33', '0', '273.33', '20211101', '20211001', '20211031', 'E000000001')
INSERT INTO Pay VALUES('EP00000002', '2156.62', '156.98', '1999.64', '20211001', '20210901', '20210930', 'E000000002')
INSERT INTO Pay VALUES('EP00000003', '3459.15', '245.41', '3213.74', '20210901', '20210801', '20210831', 'E000000003')
INSERT INTO Pay VALUES('EP00000004', '325.45', '0', '325.45', '20210801', '20210701', '20210730', 'E000000004')


INSERT INTO Customer VALUES('C000000001', 'Craig', 'Adamson', '45 Jupiter Circuit', '0498765432', 0)
INSERT INTO Customer VALUES('C000000002', 'Mick', 'White', '92 Rose Drive', '0445789123', 0)
INSERT INTO Customer VALUES('C000000003', 'Darren', 'Jacobs', '123 Kyamba Close', '0451975615', 1)
INSERT INTO Customer VALUES('C000000004', 'Kylie', 'Patrick', '22 Cow Lane', '0476159456', 1)
INSERT INTO Customer VALUES('C000000005', 'Hayden', 'Strickland', '83 Mellon Crescent', '0435156354', 1)
INSERT INTO Customer VALUES('C000000006', 'Darcy', 'Dempsey', '5 University Drive', '0478362156', 1)


INSERT INTO Orders VALUES('O000000001', '20211017',  '10:45', 1, 'Phone', 'What a weird order lol',
	'P000000001', 'E000000004', 'C000000001')
INSERT INTO Orders VALUES('O000000002', '20211017',  '16:12', 1, 'Walk-in', 'Hungry bloke',
	'P000000007', 'E000000001', 'C000000006')
INSERT INTO Orders VALUES('O000000003', '20211017',  '18:56', 1, 'Phone', NULL,
	'P000000013', 'E000000001', 'C000000001')
INSERT INTO Orders VALUES('O000000004', '20201014',  '13:24', 1, 'Walk-in', 'Hungry bloke',
	'P000000007', 'E000000003', 'C000000006')


INSERT INTO MenuItemOrder VALUES('O000000001', 'M000000001', 1)
INSERT INTO MenuItemOrder VALUES('O000000001', 'M000000006', 1)
INSERT INTO MenuItemOrder VALUES('O000000001', 'M000000008', 2)

INSERT INTO MenuItemOrder VALUES('O000000002', 'M000000004', 3)
INSERT INTO MenuItemOrder VALUES('O000000002', 'M000000005', 2)
INSERT INTO MenuItemOrder VALUES('O000000002', 'M000000003', 1)
INSERT INTO MenuItemOrder VALUES('O000000002', 'M000000009', 2)

INSERT INTO MenuItemOrder VALUES('O000000003', 'M000000002', 1)


INSERT INTO QIngredientOrder VALUES('I000000001', 'IO00000001', 250)
INSERT INTO QIngredientOrder VALUES('I000000006', 'IO00000001', 1000)
INSERT INTO QIngredientOrder VALUES('I000000005', 'IO00000002', 3500)
INSERT INTO QIngredientOrder VALUES('I000000003', 'IO00000003', 2000)


-- END INSERT
-- START SELECT

-- Q1
SELECT EFirstName, ELastName, EPaymentRate FROM Employee WHERE EmployeeNo = 'E000000001' AND EType = 'Instore';

-- Q2
SELECT IName, Quantity FROM Ingredient INNER JOIN QIngredient ON Ingredient.IngredientCode = QIngredient.IngredientCode 
	WHERE MenuItemCode = (SELECT MenuItemCode FROM MenuItem WHERE MIName = 'Meat lovers Pizza');

-- Q3
SELECT * FROM Shifts WHERE SStartDate > '20211001' AND SEndDate < '20211031' AND EmployeeNo = 
	(SELECT EmployeeNo FROM Employee WHERE EType = 'Driver' AND EFirstName = 'David' AND ELastName = 'Smith');

-- Q4
SELECT * FROM Orders WHERE ODate > '20210101' AND ODate < '20211018' AND OType = 'Walk-in' AND 
	CustomerNo = (SELECT CustomerNo FROM Customer WHERE CFirstName = 'Darcy' AND CLastName = 'Dempsey');

-- Q5
SELECT * FROM Orders WHERE ODate > '20210710' AND ODate < '20211018' AND 
	EmployeeNo = (SELECT EmployeeNo FROM Employee WHERE EType = 'Instore' AND EFirstName = 'Ethan' AND ELastName = 'Davey');

-- Q6 
SELECT TotalAmountPaid FROM Pay WHERE MONTH(PayPeriodEndDate) = MONTH(GETDATE()) AND 
	EmployeeNo = (SELECT EmployeeNo FROM Employee WHERE EFirstName = 'Ethan' AND ELastName = 'Davey');

-- Q7
SELECT MI.MenuItemCode, MI.MIName, SUM(MIO.Quantity) AS TimesOrdered
FROM MenuItem MI, MenuItemOrder MIO, Orders O
WHERE MI.MenuItemCode = MIO.MenuItemCode AND O.OrderNo = MIO.OrderNo AND DATEPART(YEAR, (O.ODate)) = YEAR(GETDATE())
GROUP BY MI.MenuItemCode, MI.MIName
HAVING SUM(MIO.Quantity) >= ALL (SELECT SUM(MIO2.Quantity)
	FROM MenuItem MI2, MenuItemOrder MIO2, Orders O2
	WHERE MI2.MenuItemCode = MIO2.MenuItemCode AND O2.OrderNo = MIO2.OrderNo AND DATEPART(YEAR, (O2.ODate)) = YEAR(GETDATE())
	GROUP BY MI2.MenuItemCode);


-- ADDITIONAL SELECTS

SELECT * FROM QIngredientOrder;
SELECT * FROM MenuItemOrder;
SELECT * FROM QIngredient;
SELECT * FROM Orders;
SELECT * FROM Customer;
SELECT * FROM Pay;
SELECT * FROM Shifts;
SELECT * FROM Delivery;
SELECT * FROM Employee;
SELECT * FROM OrderPayRecord;
SELECT * FROM IngredientOrder;
SELECT * FROM Ingredient;
SELECT * FROM MenuItem;

-- END SELECT