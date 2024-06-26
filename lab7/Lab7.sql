USE LAB1


--������� ����������������� �������� ��������� ��� ���������� ������ ������
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
--���������, ������� ����� ���������� ���������� �������� ��� ������������� ������
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



-- ������� ��������� �������, ������� ����� ���������� ����� �������� ������ ��� ������������� ������
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

-- �������� ��������� ������� ��� ��������� ����� ����� ������������� ��� ������ � ����� 'A008'
DECLARE @TotalOutstanding DECIMAL(12,2);
SET @TotalOutstanding = dbo.GetTotalOutstandingAmount('A008');
PRINT 'Total outstanding amount for agent A008: ' + CONVERT(VARCHAR(20), @TotalOutstanding);



-- ������� ������������� ��������� �������, ������� ���������� ������ �������� ��� ��������� ������
CREATE FUNCTION GetCustomersForAgent (@AgentCode CHAR(6))
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM CUSTOMER
    WHERE AGENT_CODE = @AgentCode
);

-- �������� ������������� ��������� ������� ��� ��������� ������ �������� ��� ������ � ����� 'A008'
SELECT *
FROM dbo.GetCustomersForAgent('A003');


-- ������� ���������������� ��������� �������, ������� ���������� ������ ������� ��� ��������� ������ � �������
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

-- �������� ���������������� ��������� ������� ��� ��������� ������ ������� ��� ������ 'A008' � ������� 'C00001'
SELECT *
FROM dbo.GetOrdersForAgentAndCustomer('A001', 'C00014');


