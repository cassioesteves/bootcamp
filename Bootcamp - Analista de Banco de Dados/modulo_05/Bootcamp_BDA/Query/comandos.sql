use AdventureWorks2019
go

SELECT Name, ProductNumber
from Production.Product
go

SELECT *
from Production.Product
go

SELECT *
from AdventureWorks2019.Production.Product
go

SELECT *
from person.person
go

SELECT NAME, NAME AS NOME_DO_PRODUTO, PRODUCTNUMBER, PRODUCTNUMBER AS NUMERO_DO_PRODUTO
FROM Production.Product
GO

SELECT ProductNumber, PRODUCTNUMBER AS NUMERO_DO_PRODUTO
FROM Production.Product
GO

SELECT 
NOME_DO_PRODUTO = Name,
NUMERO_DO_PRODUTO = ProductNumber
FROM Production.Product
GO

select 
name as "nome do produto", name as [nome do produto]
from Production.Product
go

select 
name as "nome do produto"
from Production.Product
go

select 
name as [nome do produto]
from Production.Product
go

select name, productnumber
from Production.Product
go

select name, productnumber
from production.product as p
go

select name, productnumber
from production.product p
go

select p.name, p.productnumber
from Production.Product p
go

USE AdventureWorks2019
GO
CREATE SYNONYM production.product FOR p;

SELECT * FROM production.product;
SELECT * FROM pp;

SELECT p.name as NOME_DO_PRODUTO, PRODUCTNUMBER, PRODUCTNUMBER AS NUMERO_DO_PRODUTO
FROM Production.Product p
GO

select name productnumber
from Production.Product, Production.Location
go

select * from Production.Product;
select * from Production.Location;

select p.name, p.productnumber, l.name
from Production.Product p, Production.Location l
go

select Product.name, productnumber, Location.name
from Production.Product, Production.Location
go

select productnumber as "numero do produto", name as "nome do produto", listprice as "preco", 
"faixa de preco" = 
	case
		when listprice = 0 then 'não disponivel para venda'
		when listprice < 50 then 'abaixo de $50'
		when listprice >= 50 and listprice <250 then 'abaixo de $250'
		when listprice >= 250 and listprice <1000 then 'abaixo de $1000'
		else 'acima de 1000'
	end
from Production.Product
go

select productid, name, productsubcategoryid,
case productsubcategoryid
	when 1 then 'mountain bikes'
	when 2 then 'mountain bikes'
	when 3 then 'mountain bikes'
	else 'unknow category'
end as subcategoryname
from Production.Product
go

select FirstName, middlename, lastname,
FirstName +' '+ middlename +' '+ lastname as nomecompleto
from Person.Person;

select unitprice, orderqty, (unitprice * orderqty) as totalvalue
from sales.SalesOrderDetail;

select 'drop table' + name + ';'
from sys.tables

select FirstName, middlename, lastname
from Person.Person
order by firstname;

select FirstName, middlename, lastname
from Person.Person
order by firstname desc;

select FirstName, middlename, lastname
from Person.Person
order by firstname asc;

select FirstName, middlename, lastname
from Person.Person
order by firstname asc, LastName desc;

select FirstName, middlename, lastname
from Person.Person
order by firstname asc, LastName asc;

select FirstName, middlename, lastname
from Person.Person
order by 1 asc, 3 desc;

select name, color
from Production.Product
where color = 'black'
or color = 'silver'
order by name;

select name, color
from Production.Product
where name like 'chain%'
and (Color = 'black' or color = 'silver')
order by name;

select name, color
from Production.Product
where color <> 'black'
order by name;

select name as produto, color as cor, listprice as "preço de lista"
from Production.Product
where listprice > 1000
order by name;

select name, color
from Production.Product
where name like 'chain%'
and (color = 'silver')
order by name;

select name, color
from Production.Product
where name like '_a%'
order by name;

select name, color
from Production.Product
where color = 'black'
--order by name;

select count (*) from Production.Product;

select top (10) percent name as nome_produto
from Production.Product
order by nome_produto;

select name as nome_produto
from Production.Product
order by nome_produto
offset 0 rows fetch next 50 rows only;


select color as 'cores de produtos'
from Production.Product
where color  is not null
order by 'cores de produtos'

select distinct firstname, middlename, lastname
from person.Person
order by FirstName, MiddleName, LastName;

select name as nome_original, lower (name) as nome_minusculo 
from production.product 
order by name 
go

select name as nome_original, upper (name) as nome_minusculo 
from production.product 
order by name 
go

select min (unitprice) as preco_minimo, max (unitprice) as preco_maximo
from sales.SalesOrderDetail;

select min (BirthDate) as nascido_mais_antigo, max(BirthDate) as nascido_mais_rescente
from HumanResources.Employee;

select min (name) as primeiro_nome_produto, max (name) as ultimo_nome_produto
from Production.Product;

select top (1) name
from Production.Product
order by name asc;

select top (1) name
from Production.Product
order by name desc;


select	count (*) as total_de_produtos,
		count (color) as total_de_produtos_com_cor
from Production.Product;


select sum (linetotal) as valor_total_de_vendas,
	   avg (linetotal) as valor_medio_de_vendas
	from sales.SalesOrderDetail;

select sum (linetotal) / count (LineTotal) as valor_total_de_vendas_sem_avg,
	   avg (linetotal) as valor_medio_de_vendas_com_avg
	from sales.SalesOrderDetail;

select min (year(orderdate)) as ano_da_compra_mais_antiga,
	   max (year(orderdate)) as ano_da_compra_mais_recente
	from sales.salesorderheader;

select avg (Weight) as "peso_medio_dos_produtos (usando avg - ok",
sum (Weight) / count (Weight) as [peso_medio_dos_produtos (sem avg - ok)],
sum (Weight) / count (*) as [peso_medio_dos_produtos(sem avg - não ok)]
	from Production.Product;

select weight as "sem peso", coalesce (weight,0) as "peso zerado"
from Production.Product;

select count (*)
from Production.Product
where Weight is null

--COMANDO JOIN

--INNER JOIN
--CROSS JOIN
--OUTER JOIN 
	--LEFT OUTER JOIN
	--RIGHT OUTER JOIN 
	--FULL OUTER JOIN


--INNER JOIN

use AdventureWorks2019

SELECT	Production.ProductCategory.Name AS NOME_DA_CATEGORIA,
		Production.ProductSubcategory.NAME AS NOME_DA_SUBCATEGORIA
FROM Production.ProductCategory
INNER JOIN Production.ProductSubcategory
ON Production.ProductCategory.ProductCategoryID = Production.ProductSubcategory.ProductSubcategoryID
ORDER BY NOME_DA_CATEGORIA ASC, NOME_DA_SUBCATEGORIA ASC;


SELECT	Production.ProductCategory.Name AS NOME_DA_CATEGORIA,
		Production.ProductSubcategory.NAME AS NOME_DA_SUBCATEGORIA
FROM Production.ProductCategory, Production.ProductSubcategory
WHERE Production.ProductCategory.ProductCategoryID = Production.ProductSubcategory.ProductSubcategoryID
ORDER BY NOME_DA_CATEGORIA ASC, NOME_DA_SUBCATEGORIA ASC;


SELECT	Production.Product.Name AS NOME_DO_PRODUTO,
		Production.ProductSubcategory.NAME AS NOME_DA_SUBCATEGORIA,
		Production.ProductCategory.Name AS NOME_DA_CATEGORIA
		FROM Production.Product
INNER JOIN Production.ProductSubcategory
ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductCategoryID
INNER JOIN Production.ProductCategory
ON Production.ProductCategory.ProductCategoryID = Production.ProductSubcategory.ProductSubcategoryID
ORDER BY NOME_DO_PRODUTO ASC;


--SUBCONSULTA ESCALADA

SELECT MAX(SalesOrderID) AS ULTIMA_VENDA FROM Sales.SalesOrderHeader;

SELECT SalesOrderID, SalesOrderDetailID, OrderQty, ProductID, LineTotal
FROM Sales.SalesOrderDetail
WHERE SalesOrderID = ( SELECT MAX(SalesOrderID) AS ULTIMA_VENDA FROM Sales.SalesOrderHeader)


--SUBCONSULTA MULTIVALORADA NOT IN 
SELECT CustomerID AS 'ID DO CLIENTE', AccountNumber AS 'NUMERO DA CONTA', TerritoryID AS 'LOCAL PAIS'
FROM Sales.Customer
WHERE TerritoryID NOT IN ( SELECT TerritoryID FROM Sales.SalesTerritory 
WHERE NAME = 'AUSTRALIA' OR NAME = 'FRANCE');

--SUBCONSULTA MULTIVALORADA IN

SELECT CustomerID AS 'ID DO CLIENTE', AccountNumber AS 'NUMERO DA CONTA', TerritoryID AS 'LOCAL PAIS'
FROM Sales.Customer
WHERE TerritoryID IN ( SELECT TerritoryID FROM Sales.SalesTerritory 
WHERE NAME = 'AUSTRALIA' OR NAME = 'FRANCE');

--USANDO OS JOINN

SELECT C.CustomerID, C.AccountNumber
FROM Sales.Customer C
JOIN SALES.SalesTerritory T
ON C.TerritoryID = T.TerritoryID
WHERE NAME = 'AUSTRALIA'OR NAME = 'FRANCE'








