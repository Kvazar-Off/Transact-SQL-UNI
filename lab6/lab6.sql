USE LAB1

select * from CUSTOMER
select * from AGENTS
select * from ORDERS
-------------------------------
create trigger TriggerForInsert
ON CUSTOMER
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE CUSTOMER
	SET GRADE = CUSTOMER.GRADE + 1
	FROM CUSTOMER JOIN
	inserted i
	ON CUSTOMER.CUST_CODE = i.CUST_CODE
END

INSERT INTO CUSTOMER VALUES	('C11111', 'Pop Hop', 'Ninqwer', 'Bali', 'Pakistan', 2, 9000.00, 12000.00, 6000.00, 15000.00, '123-4567888', 'A008')
-------------------------------
CREATE TABLE LOG_TABLE
(
    LOG_ID INT IDENTITY(1,1) PRIMARY KEY,
    TABLE_NAME VARCHAR(50) NOT NULL,
    ACTION_TYPE VARCHAR(10) NOT NULL,
    LOG_DATE DATETIME DEFAULT GETDATE(),
    USER_NAME VARCHAR(50)
);
-------------------------------
-- Триггер для таблицы AGENTS, который будет записывать в лог изменения в агентах
CREATE TRIGGER AgentChangesLog
ON AGENTS
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @ActionType VARCHAR(10);

    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        IF EXISTS (SELECT * FROM deleted)
            SET @ActionType = 'UPDATE';
        ELSE
            SET @ActionType = 'INSERT';
    END
    ELSE
        SET @ActionType = 'DELETE';

    INSERT INTO LOG_TABLE (TABLE_NAME, ACTION_TYPE, USER_NAME)
    VALUES ('AGENTS', @ActionType, SUSER_SNAME());
END;
-------------------------------
-- Триггер для таблицы CUSTOMER, который будет записывать в лог изменения в клиентах
CREATE TRIGGER CustomerChangesLog
ON CUSTOMER
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @ActionType VARCHAR(10);

    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        IF EXISTS (SELECT * FROM deleted)
            SET @ActionType = 'UPDATE';
        ELSE
            SET @ActionType = 'INSERT';
    END
    ELSE
        SET @ActionType = 'DELETE';

    INSERT INTO LOG_TABLE (TABLE_NAME, ACTION_TYPE, USER_NAME)
    VALUES ('CUSTOMER', @ActionType, SUSER_SNAME());
END;
-------------------------------
-- Триггер для таблицы ORDERS, который будет записывать в лог изменения в заказах
CREATE TRIGGER OrderChangesLog
ON ORDERS
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @ActionType VARCHAR(10);

    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        IF EXISTS (SELECT * FROM deleted)
            SET @ActionType = 'UPDATE';
        ELSE
            SET @ActionType = 'INSERT';
    END
    ELSE
        SET @ActionType = 'DELETE';

    INSERT INTO LOG_TABLE (TABLE_NAME, ACTION_TYPE, USER_NAME)
    VALUES ('ORDERS', @ActionType, SUSER_SNAME());
END;
------------------------------------
-- Просмотр списка всех триггеров в базе данных
SELECT 
    name AS TriggerName,
    OBJECT_SCHEMA_NAME(object_id) AS SchemaName,
    OBJECT_NAME(object_id) AS TableName,
    type_desc AS TriggerType
FROM sys.triggers;
------------------------------------
-- Вставка данных в таблицу AGENTS
INSERT INTO AGENTS (AGENT_CODE, AGENT_NAME, WORKING_AREA, COMMISSION, PHONE_NO, COUNTRY)
VALUES ('A013', 'John Doe', 'Sydney', 0.12, '043-12345678', 'Australia');
select * from AGENTS
select * from LOG_TABLE

-- Вставка данных в таблицу CUSTOMER
INSERT INTO CUSTOMER (CUST_CODE, CUST_NAME, CUST_CITY, WORKING_AREA, CUST_COUNTRY, GRADE, OPENING_AMT, RECEIVE_AMT, PAYMENT_AMT, OUTSTANDING_AMT, PHONE_NO, AGENT_CODE)
VALUES ('C01', 'Emma', 'New York', 'New York', 'USA', 2, 4000.00, 6000.00, 3000.00, 7000.00, '123-4567890', 'A008');

-- Вставка данных в таблицу ORDERS
INSERT INTO ORDERS (ORD_NUM, ORD_AMOUNT, ADVANCE_AMOUNT, ORD_DATE, CUST_CODE, AGENT_CODE, ORD_DESCRIPTION)
VALUES (1011, 8000.00, 3000.00, '2024-04-25', 'C00026', 'A008', 'New order');
------------------------------------
-- Обновление данных в таблице AGENTS
UPDATE AGENTS
SET AGENT_NAME = 'Updated Name', PHONE_NO = '999-88887777'
WHERE AGENT_CODE = 'A013';

-- Обновление данных в таблице CUSTOMER
UPDATE CUSTOMER
SET GRADE = 3, OUTSTANDING_AMT = 9000.00
WHERE CUST_CODE = 'C00026';

-- Обновление данных в таблице ORDERS
UPDATE ORDERS
SET ORD_AMOUNT = 9000.00, ADVANCE_AMOUNT = 4000.00
WHERE ORD_NUM = 1001;

-----------------------------------
-- Удаление данных из таблицы AGENTS
DELETE FROM AGENTS
WHERE AGENT_CODE = 'A013';

-- Удаление данных из таблицы CUSTOMER
DELETE FROM CUSTOMER
WHERE CUST_CODE = 'C00026';

-- Удаление данных из таблицы ORDERS
DELETE FROM ORDERS
WHERE ORD_NUM = 1001;
------------------------------------