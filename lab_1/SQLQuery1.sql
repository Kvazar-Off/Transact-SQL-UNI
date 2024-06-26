USE AdventureWorks2019

/*
SELECT Cust.CustomerID CustID, SalesOrderID 
FROM Sales.Customer Cust JOIN Sales.SalesOrderHeader [Order] 
ON Cust.CustomerID = [Order].CustomerID 
ORDER BY Cust.CustomerID 
FOR XML RAW	
*/

--SELECT Cust.CustomerID CustID, SalesOrderID 
--FROM Sales.Customer Cust JOIN Sales.SalesOrderHeader [Order] 
--ON Cust.CustomerID = [Order].CustomerID 
--ORDER BY Cust.CustomerID 
--FOR XML RAW, ELEMENTS		

--SELECT Cust.CustomerID CustID, SalesOrderID 
--FROM Sales.Customer Cust JOIN Sales.SalesOrderHeader [Order] 
--ON Cust.CustomerID = [Order].CustomerID 
--ORDER BY Cust.CustomerID 
--FOR XML RAW('Order'), ROOT('Orders') 

--SELECT Cust.CustomerID CustID, SalesOrderID 
--FROM Sales.Customer Cust JOIN Sales.SalesOrderHeader [Order] 
--ON Cust.CustomerID = [Order].CustomerID 
--ORDER BY Cust.CustomerID 
--FOR XML AUTO 

--SELECT Cust.CustomerID CustID, SalesOrderID 
--FROM Sales.Customer Cust JOIN Sales.SalesOrderHeader [Order] 
--ON Cust.CustomerID = [Order].CustomerID 
--ORDER BY Cust.CustomerID 
--FOR XML AUTO, ELEMENTS 

--SELECT Cust.CustomerID CustID, SalesOrderID 
--FROM Sales.Customer Cust JOIN Sales.SalesOrderHeader [Order] 
--ON Cust.CustomerID = [Order].CustomerID 
--ORDER BY Cust.CustomerID 
--FOR XML AUTO, ELEMENTS, ROOT('Orders') 

--SELECT 1 AS Tag, 
--NULL AS Parent, 
--SalesOrderID    AS    [Invoice!1!InvoiceNo], 
--OrderDate    AS    [Invoice!1!Date!Element] 
--FROM Sales.SalesOrderHeader 
--FOR XML EXPLICIT 

--SELECT Person.BusinessEntityID "@EmpID", 
--FirstName "EmpName/First", 
--LastName "EmpName/Last" 
--FROM Person.Person INNER JOIN 
--HumanResources.Employee ON Person.Person.BusinessEntityID = HumanResources.Employee.BusinessEntityID
--FOR XML PATH 

--SELECT Person.BusinessEntityID "@EmpID", 
--FirstName "EmpName/First", 
--LastName "EmpName/Last" 
--FROM Person.Person INNER JOIN 
--HumanResources.Employee ON Person.Person.BusinessEntityID = HumanResources.Employee.BusinessEntityID 
--FOR XML PATH('Employee')

--SELECT Cust.CustomerID CustID, SalesOrderID 
--FROM Sales.Customer Cust JOIN Sales.SalesOrderHeader [Order] 
--ON Cust.CustomerID = [Order].CustomerID 
--ORDER BY Cust.CustomerID 
--FOR XML AUTO, ELEMENTS

--SELECT Name CategoryName, 
--(SELECT Name SubCategoryName 
--FROM Production.ProductSubCategory SubCategory 
--WHERE SubCategory.ProductCategoryID=Category.ProductCategoryID 
--FOR XML AUTO, TYPE, ELEMENTS) 
--FROM Production.ProductCategory Category 
--FOR XML AUTO 

--SELECT 1 AS Tag, 
--NULL AS Parent, 
--SalesOrderID AS [Invoice!1!InvoiceNo], 
--OrderDate AS [Invoice!1!Date!Element], 
--NULL AS [LineItem!2!ProductID], 
--NULL AS [LineItem!2] 
--FROM Sales.SalesOrderHeader 
--UNION ALL 
--SELECT 2 AS Tag,
--1 AS Parent, 
--OrderDetail.SalesOrderID, 
--NULL, 
--OrderDetail.ProductID, 
--Product.Name 
--FROM Sales.SalesOrderDetail OrderDetail JOIN 
--Sales.SalesOrderHeader OrderHeader 
--ON OrderDetail.SalesOrderID= OrderHeader.SalesOrderID 
--JOIN Production.Product Product 
--ON OrderDetail.ProductID = Product.ProductID 
--ORDER BY [Invoice!1!InvoiceNo], [LineItem!2!ProductID] 
--FOR XML EXPLICIT 


--CREATE DATABASE LAB1
USE LAB1

--CREATE TABLE AGENTS
--(
--    AGENT_CODE CHAR(6) NOT NULL PRIMARY KEY,
--    AGENT_NAME VARCHAR(40),
--    WORKING_AREA VARCHAR(35),
--    COMMISSION DECIMAL(10,2),
--    PHONE_NO VARCHAR(15),
--    COUNTRY VARCHAR(25)
--);


--INSERT INTO AGENTS VALUES ('A007', 'Ramasundar', 'Bangalore', '0.15', '077-25814763', '');
--INSERT INTO AGENTS VALUES ('A003', 'Alex ', 'London', '0.13', '075-12458969', '');
--INSERT INTO AGENTS VALUES ('A008', 'Alford', 'New York', '0.12', '044-25874365', '');
--INSERT INTO AGENTS VALUES ('A011', 'Ravi Kumar', 'Bangalore', '0.15', '077-45625874', '');
--INSERT INTO AGENTS VALUES ('A010', 'Santakumar', 'Chennai', '0.14', '007-22388644', '');
--INSERT INTO AGENTS VALUES ('A012', 'Lucida', 'San Jose', '0.12', '044-52981425', '');
--INSERT INTO AGENTS VALUES ('A005', 'Anderson', 'Brisban', '0.13', '045-21447739', '');
--INSERT INTO AGENTS VALUES ('A001', 'Subbarao', 'Bangalore', '0.14', '077-12346674', '');
--INSERT INTO AGENTS VALUES ('A002', 'Mukesh', 'Mumbai', '0.11', '029-12358964', '');
--INSERT INTO AGENTS VALUES ('A006', 'McDen', 'London', '0.15', '078-22255588', '');
--INSERT INTO AGENTS VALUES ('A004', 'Ivan', 'Torento', '0.15', '008-22544166', '');
--INSERT INTO AGENTS VALUES ('A009', 'Benjamin', 'Hampshair', '0.11', '008-22536178', '');

--CREATE TABLE  "CUSTOMER" 
--   (	"CUST_CODE" VARCHAR(6) NOT NULL PRIMARY KEY, 
--	"CUST_NAME" VARCHAR(40) NOT NULL, 
--	"CUST_CITY" CHAR(35), 
--	"WORKING_AREA" VARCHAR(35) NOT NULL, 
--	"CUST_COUNTRY" VARCHAR(20) NOT NULL, 
--	"GRADE" DECIMAL, 
--	"OPENING_AMT" DECIMAL(12,2) NOT NULL, 
--	"RECEIVE_AMT" DECIMAL(12,2) NOT NULL, 
--	"PAYMENT_AMT" DECIMAL(12,2) NOT NULL, 
--	"OUTSTANDING_AMT" DECIMAL(12,2) NOT NULL, 
--	"PHONE_NO" VARCHAR(17) NOT NULL, 
--	"AGENT_CODE" CHAR(6) NOT NULL REFERENCES AGENTS
--); 

--INSERT INTO CUSTOMER VALUES ('C00013', 'Holmes', 'London', 'London', 'UK', '2', '6000.00', '5000.00', '7000.00', '4000.00', 'BBBBBBB', 'A003');
--INSERT INTO CUSTOMER VALUES ('C00001', 'Micheal', 'New York', 'New York', 'USA', '2', '3000.00', '5000.00', '2000.00', '6000.00', 'CCCCCCC', 'A008');
--INSERT INTO CUSTOMER VALUES ('C00020', 'Albert', 'New York', 'New York', 'USA', '3', '5000.00', '7000.00', '6000.00', '6000.00', 'BBBBSBB', 'A008');
--INSERT INTO CUSTOMER VALUES ('C00025', 'Ravindran', 'Bangalore', 'Bangalore', 'India', '2', '5000.00', '7000.00', '4000.00', '8000.00', 'AVAVAVA', 'A011');
--INSERT INTO CUSTOMER VALUES ('C00024', 'Cook', 'London', 'London', 'UK', '2', '4000.00', '9000.00', '7000.00', '6000.00', 'FSDDSDF', 'A006');
--INSERT INTO CUSTOMER VALUES ('C00015', 'Stuart', 'London', 'London', 'UK', '1', '6000.00', '8000.00', '3000.00', '11000.00', 'GFSGERS', 'A003');
--INSERT INTO CUSTOMER VALUES ('C00002', 'Bolt', 'New York', 'New York', 'USA', '3', '5000.00', '7000.00', '9000.00', '3000.00', 'DDNRDRH', 'A008');
--INSERT INTO CUSTOMER VALUES ('C00018', 'Fleming', 'Brisban', 'Brisban', 'Australia', '2', '7000.00', '7000.00', '9000.00', '5000.00', 'NHBGVFC', 'A005');
--INSERT INTO CUSTOMER VALUES ('C00021', 'Jacks', 'Brisban', 'Brisban', 'Australia', '1', '7000.00', '7000.00', '7000.00', '7000.00', 'WERTGDF', 'A005');
--INSERT INTO CUSTOMER VALUES ('C00019', 'Yearannaidu', 'Chennai', 'Chennai', 'India', '1', '8000.00', '7000.00', '7000.00', '8000.00', 'ZZZZBFV', 'A010');
--INSERT INTO CUSTOMER VALUES ('C00005', 'Sasikant', 'Mumbai', 'Mumbai', 'India', '1', '7000.00', '11000.00', '7000.00', '11000.00', '147-25896312', 'A002');
--INSERT INTO CUSTOMER VALUES ('C00007', 'Ramanathan', 'Chennai', 'Chennai', 'India', '1', '7000.00', '11000.00', '9000.00', '9000.00', 'GHRDWSD', 'A010');
--INSERT INTO CUSTOMER VALUES ('C00022', 'Avinash', 'Mumbai', 'Mumbai', 'India', '2', '7000.00', '11000.00', '9000.00', '9000.00', '113-12345678','A002');
--INSERT INTO CUSTOMER VALUES ('C00004', 'Winston', 'Brisban', 'Brisban', 'Australia', '1', '5000.00', '8000.00', '7000.00', '6000.00', 'AAAAAAA', 'A005');
--INSERT INTO CUSTOMER VALUES ('C00023', 'Karl', 'London', 'London', 'UK', '0', '4000.00', '6000.00', '7000.00', '3000.00', 'AAAABAA', 'A006');
--INSERT INTO CUSTOMER VALUES ('C00006', 'Shilton', 'Torento', 'Torento', 'Canada', '1', '10000.00', '7000.00', '6000.00', '11000.00', 'DDDDDDD', 'A004');
--INSERT INTO CUSTOMER VALUES ('C00010', 'Charles', 'Hampshair', 'Hampshair', 'UK', '3', '6000.00', '4000.00', '5000.00', '5000.00', 'MMMMMMM', 'A009');
--INSERT INTO CUSTOMER VALUES ('C00017', 'Srinivas', 'Bangalore', 'Bangalore', 'India', '2', '8000.00', '4000.00', '3000.00', '9000.00', 'AAAAAAB', 'A007');
--INSERT INTO CUSTOMER VALUES ('C00012', 'Steven', 'San Jose', 'San Jose', 'USA', '1', '5000.00', '7000.00', '9000.00', '3000.00', 'KRFYGJK', 'A012');
--INSERT INTO CUSTOMER VALUES ('C00008', 'Karolina', 'Torento', 'Torento', 'Canada', '1', '7000.00', '7000.00', '9000.00', '5000.00', 'HJKORED', 'A004');
--INSERT INTO CUSTOMER VALUES ('C00003', 'Martin', 'Torento', 'Torento', 'Canada', '2', '8000.00', '7000.00', '7000.00', '8000.00', 'MJYURFD', 'A004');
--INSERT INTO CUSTOMER VALUES ('C00009', 'Ramesh', 'Mumbai', 'Mumbai', 'India', '3', '8000.00', '7000.00', '3000.00', '12000.00', 'Phone No', 'A002');
--INSERT INTO CUSTOMER VALUES ('C00014', 'Rangarappa', 'Bangalore', 'Bangalore', 'India', '2', '8000.00', '11000.00', '7000.00', '12000.00', 'AAAATGF', 'A001');
--INSERT INTO CUSTOMER VALUES ('C00016', 'Venkatpati', 'Bangalore', 'Bangalore', 'India', '2', '8000.00', '11000.00', '7000.00', '12000.00', 'JRTVFDD', 'A007');
--INSERT INTO CUSTOMER VALUES ('C00011', 'Sundariya', 'Chennai', 'Chennai', 'India', '3', '7000.00', '11000.00', '7000.00', '11000.00', 'PPHGRTS', 'A010');

--CREATE TABLE  "ORDERS" 
--   (
--        "ORD_NUM" DECIMAL(6,0) NOT NULL PRIMARY KEY, 
--	"ORD_AMOUNT" DECIMAL(12,2) NOT NULL, 
--	"ADVANCE_AMOUNT" DECIMAL(12,2) NOT NULL, 
--	"ORD_DATE" DATE NOT NULL, 
--	"CUST_CODE" VARCHAR(6) NOT NULL REFERENCES CUSTOMER, 
--	"AGENT_CODE" CHAR(6) NOT NULL REFERENCES AGENTS, 
--	"ORD_DESCRIPTION" VARCHAR(60) NOT NULL
--   );


   SELECT 
    AGENT_CODE AS "AgentCode",
    AGENT_NAME AS "AgentName",
    WORKING_AREA AS "WorkingArea",
    COMMISSION AS "Commission",
    PHONE_NO AS "PhoneNo",
    COUNTRY AS "Country"
FROM AGENTS
FOR XML RAW ('Agent'), ROOT ('Agents')

--   SELECT 
--    AGENT_CODE AS "AgentCode",
--    AGENT_NAME AS "AgentName",
--    WORKING_AREA AS "WorkingArea",
--    COMMISSION AS "Commission",
--    PHONE_NO AS "PhoneNo",
--    COUNTRY AS "Country"
--FROM AGENTS
--FOR XML RAW, ELEMENTS

SELECT 
    AGENT_CODE,
    AGENT_NAME,
    WORKING_AREA,
    COMMISSION,
    PHONE_NO,
    COUNTRY
FROM AGENTS
FOR XML AUTO,ELEMENTS

SELECT 
    AGENT_CODE AS "@AgentCode", 
    AGENT_NAME AS "Agent/AgentName", 
    WORKING_AREA AS "Agent/WorkingArea", 
    COMMISSION AS "Agent/Commission", 
    PHONE_NO AS "Agent/PhoneNo", 
    COUNTRY AS "Agent/Country" 
FROM AGENTS 
FOR XML PATH('Agent')


SELECT
    Cust.CustomerID AS "@CustID",
    (
        SELECT
            SalesOrderID
        FROM Sales.SalesOrderHeader [Order]
        WHERE Cust.CustomerID = [Order].CustomerID
        FOR XML AUTO, TYPE
    ) AS "SalesOrders"
FROM Sales.Customer Cust
JOIN Sales.SalesOrderHeader [Order] ON Cust.CustomerID = [Order].CustomerID
ORDER BY Cust.CustomerID
FOR XML AUTO, ROOT('Customers');

SELECT
    C.CUST_CODE AS "@CustID",
    (
        SELECT
            O.ORD_NUM AS "OrderID",
            O.ORD_AMOUNT AS "OrderAmount",
            O.ADVANCE_AMOUNT AS "AdvanceAmount",
            O.ORD_DATE AS "OrderDate",
            O.ORD_DESCRIPTION AS "OrderDescription"
        FROM ORDERS O
        WHERE C.CUST_CODE = O.CUST_CODE
        FOR XML AUTO, TYPE
    ) AS "Orders"
FROM CUSTOMER C
ORDER BY C.CUST_CODE
FOR XML AUTO, ROOT('Customers');


SELECT 
    1 AS Tag,
    NULL AS Parent,
    AGENT_CODE AS [Agent!1!AgentCode],
    AGENT_NAME AS [Agent!1!AgentName!Element]
FROM AGENTS
FOR XML EXPLICIT


