USE LAB1


--Простая параметризованная хранимая процедура для обновления данных агента
CREATE PROCEDURE UpdateAgentData
    @AgentCode CHAR(6),
    @AgentName VARCHAR(40),
    @WorkingArea VARCHAR(35),
    @Commission DECIMAL(10,2),
    @PhoneNo VARCHAR(15),
    @Country VARCHAR(25)
AS
BEGIN
    UPDATE AGENTS
    SET AGENT_NAME = @AgentName,
        WORKING_AREA = @WorkingArea,
        COMMISSION = @Commission,
        PHONE_NO = @PhoneNo,
        COUNTRY = @Country
    WHERE AGENT_CODE = @AgentCode;
END;

EXEC UpdateAgentData @AgentCode='A008', @AgentName='NewAgentName', @WorkingArea='TATAR', @Commission=0.14, @PhoneNo='123-456-7890', @Country='USA';
select * from AGENTS
--процедура, которая будет возвращать количество клиентов для определенного агента
CREATE PROCEDURE GetCustomerCountForAgent
    @AgentCode CHAR(6),
    @CustomerCount INT OUTPUT
AS
BEGIN
    SELECT @CustomerCount = COUNT(*)
    FROM CUSTOMER
    WHERE AGENT_CODE = @AgentCode;
END;
--------------------
DECLARE @AgentCode CHAR(6) = 'A008';
DECLARE @CustomerCount INT;

EXEC GetCustomerCountForAgent @AgentCode, @CustomerCount OUTPUT;

PRINT 'Number of customers for agent ' + @AgentCode + ': ' + CAST(@CustomerCount AS VARCHAR(10));
--------------------------



-- Создаем скалярную функцию, которая будет возвращать сумму открытых счетов для определенного агента
CREATE FUNCTION GetTotalOutstandingAmount (@AgentCode CHAR(6))
RETURNS DECIMAL(12,2)
AS
BEGIN
    DECLARE @TotalOutstanding DECIMAL(12,2);
    
    SELECT @TotalOutstanding = SUM(OUTSTANDING_AMT)
    FROM CUSTOMER
    WHERE AGENT_CODE = @AgentCode;
    
    RETURN @TotalOutstanding;
END;

-- Вызываем скалярную функцию для получения общей суммы задолженности для агента с кодом 'A008'
DECLARE @TotalOutstanding DECIMAL(12,2);
SET @TotalOutstanding = dbo.GetTotalOutstandingAmount('A008');
PRINT 'Total outstanding amount for agent A008: ' + CONVERT(VARCHAR(20), @TotalOutstanding);



-- Создаем подставляемую табличную функцию, которая возвращает список клиентов для заданного агента
CREATE FUNCTION GetCustomersForAgent (@AgentCode CHAR(6))
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM CUSTOMER
    WHERE AGENT_CODE = @AgentCode
);

-- Вызываем подставляемую табличную функцию для получения списка клиентов для агента с кодом 'A008'
SELECT *
FROM dbo.GetCustomersForAgent('A003');


-- Создаем многооператорную табличную функцию, которая возвращает список заказов для заданного агента и клиента
CREATE FUNCTION GetOrdersForAgentAndCustomer (@AgentCode CHAR(6), @CustomerCode VARCHAR(6))
RETURNS @Orders TABLE
(
    ORD_NUM DECIMAL(6,0),
    ORD_AMOUNT DECIMAL(12,2),
    ADVANCE_AMOUNT DECIMAL(12,2),
    ORD_DATE DATE,
    CUST_CODE VARCHAR(6),
    AGENT_CODE CHAR(6),
    ORD_DESCRIPTION VARCHAR(60)
)
AS
BEGIN
    INSERT INTO @Orders (ORD_NUM, ORD_AMOUNT, ADVANCE_AMOUNT, ORD_DATE, CUST_CODE, AGENT_CODE, ORD_DESCRIPTION)
    SELECT ORD_NUM, ORD_AMOUNT, ADVANCE_AMOUNT, ORD_DATE, CUST_CODE, AGENT_CODE, ORD_DESCRIPTION
    FROM ORDERS
    WHERE AGENT_CODE = @AgentCode AND CUST_CODE = @CustomerCode;
    
    RETURN;
END;

-- Вызываем многооператорную табличную функцию для получения списка заказов для агента 'A008' и клиента 'C00001'
SELECT *
FROM dbo.GetOrdersForAgentAndCustomer('A001', 'C00014');


