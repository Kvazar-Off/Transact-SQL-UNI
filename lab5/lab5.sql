USE LAB1

select * from [vCustomers]
----------------------------
CREATE VIEW [vCustomers] AS
SELECT *
FROM CUSTOMER
WHERE CUST_COUNTRY = 'India'
----------------------------
SELECT *
FROM [vCustomers]

SELECT CUST_CODE, CUST_NAME, PAYMENT_AMT
FROM [vCustomers]
WHERE PAYMENT_AMT > 5000
----------------------------
UPDATE [vCustomers]
SET CUST_CITY = 'Vladivostok'
WHERE CUST_NAME = 'Sundariya';

DELETE FROM [vCustomers]
WHERE CUST_NAME = 'Yearannaidu';

INSERT INTO [vCustomers] (CUST_CODE, CUST_NAME, CUST_CITY, WORKING_AREA, CUST_COUNTRY, GRADE, OPENING_AMT, RECEIVE_AMT, PAYMENT_AMT, OUTSTANDING_AMT, PHONE_NO, AGENT_CODE)
VALUES ('C00028', 'John Doe', 'Mumbai', 'Baoa', 'India', 2, 9000.00, 12000.00, 6000.00, 15000.00, '123-4567890', 'A008');
--------------------------------
CREATE VIEW [vCustomers1] AS
SELECT *
FROM CUSTOMER
WHERE CUST_COUNTRY = 'India'
WITH CHECK OPTION
--------------------------------
select * from [vCustomers1]
--------------------------------
UPDATE [vCustomers1]
SET CUST_CITY = 'Kazan'
WHERE CUST_NAME = 'John Doe';

DELETE FROM [vCustomers1] --- fail
WHERE CUST_NAME = 'Sasikant';

INSERT INTO [vCustomers1] (CUST_CODE, CUST_NAME, CUST_CITY, WORKING_AREA, CUST_COUNTRY, GRADE, OPENING_AMT, RECEIVE_AMT, PAYMENT_AMT, OUTSTANDING_AMT, PHONE_NO, AGENT_CODE)
VALUES ('C01138', 'Max Kor', 'Ninat', 'Baoa', 'India', 1, 4000.00, 12000.00, 6000.00, 15000.00, '124-4567890', 'A001');
--------------------------------
--Представление на основе нескольких таблиц--
CREATE VIEW vCustomerOrders
AS
SELECT C.CUST_CODE, C.CUST_NAME, C.CUST_CITY, O.ORD_NUM, O.ORD_AMOUNT, O.ORD_DATE
FROM CUSTOMER C
JOIN ORDERS O ON C.CUST_CODE = O.CUST_CODE;
--Представление на основе существующего представления--
CREATE VIEW vHighGradeCustomers
AS
SELECT *
FROM vCustomers
WHERE GRADE >= 2;
--Представление с объединением и GROUP BY--
CREATE VIEW vAgentSummary
AS
SELECT A.AGENT_CODE, A.AGENT_NAME, A.WORKING_AREA,
       COUNT(C.CUST_CODE) AS NUM_CUSTOMERS,
       SUM(C.PAYMENT_AMT) AS TOTAL_PAYMENTS
FROM AGENTS A
LEFT JOIN CUSTOMER C ON A.AGENT_CODE = C.AGENT_CODE
GROUP BY A.AGENT_CODE, A.AGENT_NAME, A.WORKING_AREA;

CREATE VIEW vHighValueOrders
WITH SCHEMABINDING
AS
SELECT O.ORD_NUM, O.ORD_AMOUNT, C.CUST_CODE, C.CUST_NAME, C.CUST_CITY
FROM dbo.ORDERS O
JOIN dbo.CUSTOMER C ON O.CUST_CODE = C.CUST_CODE
WHERE O.ORD_AMOUNT > 10000;	
------------------------------
SELECT * FROM sys.views

EXEC sp_helptext vAgentSummary
------------------------------
SELECT DISTINCT OBJECT_NAME(OBJECT_ID) as Name
FROM sys.sql_dependencies WHERE referenced_major_id = OBJECT_ID('AGENTS')

SELECT DISTINCT OBJECT_NAME(OBJECT_ID) as Name
FROM sys.sql_dependencies WHERE referenced_major_id = OBJECT_ID('CUSTOMER')
-----------------------------
select * from vHighValueOrders

CREATE UNIQUE CLUSTERED INDEX IX_vHighValueOrders_ORD_NUM
ON vHighValueOrders (ORD_NUM);

DROP index vHighValueOrders.IX_vHighValueOrders_ORD_NUM




