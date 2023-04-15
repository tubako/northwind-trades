## Mock data analysis to influence a business decision at Northwind Traders

<p align="center">
 <img src="https://user-images.githubusercontent.com/70372302/232221590-d4396fc2-6d87-4edd-a454-a7f0ea9cf20f.jpeg">
</p>

 

Northwind Traders is a fictional company that buys products and resells them to customers. 

As an incentive, the company decided to give a bonus to high performing employees. These high performing employees being the ones who are responsible for the five highest order amounts. This analysis will focus on correctly identifying the employees that are eligible for this bonus.
The figure below shows the Northwind database. According to this database, to get the highest order amounts and the employees who completed them, these following tables will be needed: Employees, Orders, OrderDetails and Products. 

<p align="center">
 <img src="https://user-images.githubusercontent.com/70372302/232210244-fa1c85a8-95cb-455b-a56f-a830a8abf444.JPG">
</p>


After examining these tables one by one, the following plan is made. FirstName and LastName columns from the Employees table are needed to have the names of the employees. Then, Employees and Orders tables can be joined using their common  column which is EmployeeID.  This join is important to be able to connect the EmployeeID to OrderID to figure out which employee is responsible for which order. 

```sql
SELECT LastName, FirstName, OrderID
FROM Employees
INNER JOIN Orders
ON Employees.EmployeeID = Orders.EmployeeID
ORDER BY LastName, FirstName
```
Using OrderID column Orders and OrderDetails tables can be joined, which would help in knowing the quantity of the order. 

```sql
SELECT LastName, FirstName, Orders.OrderID, Quantity
FROM Employees
INNER JOIN Orders
ON Employees.EmployeeID = Orders.EmployeeID
INNER JOIN OrderDetails
ON Orders.OrderID = OrderDetails.OrderID
ORDER BY LastName, FirstName
```

Finally, joining Products table with OrderDetails table via ProductID column is necessary to check the price of the product, which will help in finding the highest order amounts. 

```sql
SELECT LastName, FirstName, Orders.OrderID, Products.ProductID, Quantity, Price
FROM Employees
INNER JOIN Orders
ON Employees.EmployeeID = Orders.EmployeeID
INNER JOIN OrderDetails
ON Orders.OrderID = OrderDetails.OrderID
INNER JOIN Products
ON OrderDetails.ProductID = Products.ProductID
ORDER BY LastName, FirstName
```

To get to the highest sale amount  the total cost of each order is needed,  which can be easily calculated by first multiplying the Quantity column from the OrderDetails table with the Price column from the Products table and then summing the results per order. 
```sql
SELECT LastName, FirstName, Orders.OrderID, Products.ProductID, Quantity, Price, sum(Quantity*Price) AS SaleAmount
FROM Employees
INNER JOIN Orders
ON Employees.EmployeeID = Orders.EmployeeID
INNER JOIN OrderDetails
ON Orders.OrderID = OrderDetails.OrderID
INNER JOIN Products
ON OrderDetails.ProductID = Products.ProductID
GROUP BY Orders.OrderID
```

With this last code, the business question is ready to be answered. The only thing left to do is sort this final table’s SalesAmount column in a descending order which can be done by a simple ORDER BY clause. While at it, since only top five highest sales amount is needed, table length can also be limited by 5.

```sql
SELECT LastName, FirstName, Orders.OrderID, Products.ProductID, Quantity, Price, sum(Quantity*Price) AS SaleAmount
FROM Employees
INNER JOIN Orders
ON Employees.EmployeeID = Orders.EmployeeID
INNER JOIN OrderDetails
ON Orders.OrderID = OrderDetails.OrderID
INNER JOIN Products
ON OrderDetails.ProductID = Products.ProductID
GROUP BY Orders.OrderID
ORDER BY SaleAmount DESC
LIMIT 5
```

Results are intriguing.  Yes, this table shows exactly five of the highest sales amount, however they belong to these three employees only: Steven Buchanan, Robert King and Margaret Peacock. Since the business question is ambiguous about whether the bonus goes to the five highest sales regardless of the employee amount or it goes to the five highest sales by five different employees, it would be ideal to prepare an additional table with the latter scenario in mind. 
