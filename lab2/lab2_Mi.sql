  --declare @departaments xml = '
--<Departaments DeptID="1" DeptName="Канцтовары">
--  <Goods DeptID="1" GoodID="10" GName="Pen" Descr="ball" Price="17.2857" GCount="100" />
--  <Goods DeptID="1" GoodID="20" GName="Pen" Descr="Gel" Price="27.2857" GCount="10" />
--</Departaments>
--';
--DECLARE @h int;
--execute sp_xml_preparedocument @h output, @departaments, '';

--select * from openxml(@h, '/Departaments/Goods',1)
--with (GName nvarchar(30) , GoodID int , Descr nvarchar(30) );

--execute sp_xml_removedocument @h;




--USE RestaurantDB

--declare @departaments xml;
--SET @departaments = (
--	SELECT 1 AS Tag, NULL AS Parent, Menu.DishName AS [Order!1!DishName], Orders.Id AS [Order!1!OrderID], Orders.[Table] AS [Order!1!TableNo], Orders.WaiterId AS [Order!1!WaiterId]
--	FROM Orders 
--	JOIN OrderedDishes
--		ON Orders.Id = OrderedDishes.OrderId
--	JOIN Menu
--		ON OrderedDishes.DishId = Menu.DishID
--	ORDER BY Orders.Id
--	FOR XML EXPLICIT, Root('Orders'))

--DECLARE @h int;
--execute sp_xml_preparedocument @h output, @departaments, '';

--select * from openxml(@h, '/Orders/Order',1)
--with (DishName nvarchar(30) , TableNo int , WaiterId int );

--execute sp_xml_removedocument @h;


---------------------------------------------------------------------------------


--declare @departaments xml;
--SET @departaments = (
--	SELECT 1 AS Tag, NULL AS Parent, Orders.Id AS [Order!1!OrderID], Orders.[Table] AS [Order!1!TableNo], Orders.WaiterId AS [Order!1!WaiterId]
--	FROM Orders 
--	JOIN OrderedDishes
--		ON Orders.Id = OrderedDishes.OrderId
--	JOIN Menu
--		ON OrderedDishes.DishId = Menu.DishID
--	ORDER BY Orders.Id
--	FOR XML EXPLICIT, Root('Orders'))

--DECLARE @h int;
--execute sp_xml_preparedocument @h output, @departaments, '';


--select * from openxml(@h, '/Orders/Order',1)
--with (OrderID nvarchar(30) , TableNo int , WaiterId int );

--execute sp_xml_removedocument @h;


------------------------ Начало

--USE RestaurantDB
--GO

--ALTER TABLE OrderedDishes ADD LMX xml

--SELECT * FROM OrderedDishes

--UPDATE OrderedDishes

--SET LMX = (
--	SELECT Orders.[Table], Orders.WaiterId, Menu.DishName
--	FROM Orders 
--	JOIN OrderedDishes
--		ON Orders.Id = OrderedDishes.OrderId
--	JOIN Menu
--		ON OrderedDishes.DishId = Menu.DishID
--	ORDER BY Orders.Id
--	FOR XML RAW, Root('Orders')
--)

--DECLARE @XML AS XML, @hDoc AS INT
--SELECT @XML = LMX FROM OrderedDishes

--EXEC sp_xml_preparedocument @hDoc OUTPUT, @XML, '';

--SELECT * FROM OPENXML(@hDoc, '/Orders/row', 1)
--WITH
--(
--	DishName nvarchar(30),
--	[Table] int, 
--	WaiterId int
--)

--EXEC sp_xml_removedocument @hDoc

---------------  Попытка 2

USE RestaurantDB
GO

ALTER TABLE OrderedDishes ADD LMX xml

SELECT * FROM OrderedDishes

UPDATE OrderedDishes

SET LMX = (
	SELECT 1 AS Tag, NULL AS Parent, Menu.DishName AS [Order!1!DishName], Orders.[Table] AS [Order!1!TableNo], Orders.WaiterId AS [Order!1!WaiterId]
	FROM Orders 
	JOIN OrderedDishes
		ON Orders.Id = OrderedDishes.OrderId
	JOIN Menu
		ON OrderedDishes.DishId = Menu.DishID
	ORDER BY Orders.Id
	FOR XML EXPLICIT, Root('Orders')
)
GO 

DECLARE @XML AS XML, @hDoc AS INT
SELECT @XML = LMX FROM OrderedDishes

EXEC sp_xml_preparedocument @hDoc OUTPUT, @XML, '';

SELECT * FROM OPENXML(@hDoc, '/Orders/Order', 1)
WITH
(
	DishName nvarchar(30),
	[TableNo] int, 
	WaiterId int
)

EXEC sp_xml_removedocument @hDoc
