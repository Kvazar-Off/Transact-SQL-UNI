use lab1

DECLARE @XML AS XML
SELECT @XML = LMX FROM AGENTS
------------- query
select @XML.query('/Agents/Agent')
-------------  value
DECLARE @XML AS XML
SELECT @XML = LMX FROM AGENTS
DECLARE @Name AS VARCHAR(50)
SET @Name = @XML.value('(/Agents/Agent/@Name)[1]', 'varchar(50)')
SELECT @Name
---------------- exist
DECLARE @XML AS XML
SELECT @XML = LMX FROM AGENTS
DECLARE @Name AS VARCHAR(50)
SET @Name = @XML.exist('/Agents/Agent[@Name="Ivan"]')
SELECT @Name 
-------------------  modify
declare @myDoc XML
set @myDoc = '<Agents>
  <Agent Name="Subbarao" WorkingArea="Bangalore" Commission="0.14" PhoneNo="077-12346674" Country="" />
  <Agent Name="Mukesh" WorkingArea="Mumbai" Commission="0.11" PhoneNo="029-12358964" Country="" />
  </Agents>'
set @myDoc.modify('insert <Agent Name="Petr" WorkingArea="Kazan" Commission="0.1" PhoneNo="555" Country="Russia"/> as first into (/Agents)[1]')
select @myDoc
--------------  nodes
declare @XML AS XML
SELECT @XML = LMX FROM AGENTS
SELECT
    Agent.value('@Name', 'VARCHAR(50)') AS AgentName,
    Agent.value('@WorkingArea', 'VARCHAR(50)') AS WorkingArea,
    Agent.value('@Commission', 'FLOAT') AS Commission,
    Agent.value('@PhoneNo', 'VARCHAR(50)') AS PhoneNo
FROM @XML.nodes('/Agents/Agent') Agents(Agent)  
