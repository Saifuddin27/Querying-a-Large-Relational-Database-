                               ---PROJECT1
							   --QUERING A LARGE RELATIONAL DATABASE


--a. Get all the details from the person table including email ID, phone
--number and phone number type
 select P.*,E.EmailAddress,[PhoneNumber],PN.[Name] from [Person].[Person] P
  inner join
  [Person].[EmailAddress] E on P.businessentityID = E.businessentityID 
  inner join
  [Person].[PersonPhone] PP on E.BusinessEntityID = PP.BusinessEntityID
  inner join
  [Person].[PhoneNumberType] PN on PP.PhoneNumberTypeID = PN.PhoneNumberTypeID


--b. Get the details of the sales header order made in May 2011
SELECT *FROM sales.SalesOrderHeader
WHERE DATEPART(YEAR, OrderDate) = 2011 AND DATEPART(MONTH, OrderDate) = 5;

--c. Get the details of the sales details order made in the month of May
--2011
SELECT *FROM Sales.SalesOrderDetail
WHERE DATEPART(YEAR, ModifiedDate) = 2011 AND DATEPART(MONTH, ModifiedDate) = 5;

--d. Get the total sales made in May 2011
SELECT SUM(LineTotal) AS total_sales
FROM Sales.SalesOrderDetail
WHERE DATEPART(YEAR, ModifiedDate) = 2011 AND DATEPART(MONTH, ModifiedDate) = 5;

--e. Get the total sales made in the year 2011 by month order by increasing sales
SELECT
    DATEPART(MONTH, ModifiedDate) AS order_month,
    SUM(LineTotal) AS monthly_sales FROM Sales.SalesOrderDetail
WHERE DATEPART(YEAR, ModifiedDate) = 2011 GROUP BY DATEPART(YEAR, ModifiedDate),
DATEPART(MONTH, ModifiedDate)ORDER BY monthly_sales;

--f. Get the total sales made to the customer with FirstName='Gustavo' and LastName ='Achong'	   
SELECT
     p.Title, p.FirstName, p.MiddleName, p.LastName, tmp.TotalAmount
FROM Sales.Customer c
INNER JOIN Person.Person AS p ON p.BusinessEntityID=c.PersonID
LEFT JOIN
   (
     SELECT soh.CustomerID, SUM(LineTotal) AS TotalAmount
     FROM  Sales.SalesOrderDetail AS sod
     INNER JOIN Sales.SalesOrderHeader AS soh ON soh.SalesOrderID=sod.SalesOrderID
     GROUP BY soh.CustomerID
   ) tmp ON tmp.CustomerID=c.CustomerID
WHERE
    p.FirstName = 'Gustavo' AND p.LastName ='Achong';







