USE LAB1
--���������� ������� XML � ������� AGENTS:
ALTER TABLE AGENTS ADD LMX xml

SELECT * FROM AGENTS
--���������� ������� XML �������
UPDATE AGENTS
SET LMX = (
    SELECT 
        1 AS Tag, 
        NULL AS Parent, 
        AGENT_NAME AS [Agent!1!Name],
        WORKING_AREA AS [Agent!1!WorkingArea],
        COMMISSION AS [Agent!1!Commission],
        PHONE_NO AS [Agent!1!PhoneNo],
        COUNTRY AS [Agent!1!Country]
    FROM AGENTS
    FOR XML EXPLICIT, Root('Agents')
)
--��������� XML-���������
DECLARE @XML AS XML, @hDoc AS INT
SELECT @XML = LMX FROM AGENTS

--��������� ����������� ������������� ������
EXEC sp_xml_preparedocument @hDoc OUTPUT, @XML, ''

--������������ � ��������� �����
SELECT * FROM OPENXML(@hDoc, '/Agents/Agent', 1)
WITH
(
    Name varchar(40),
    WorkingArea varchar(35),
    Commission decimal(10,2),
    PhoneNo varchar(15),
    Country varchar(25)
)
--�������� ����������� ������
EXEC sp_xml_removedocument @hDoc

