SELECT LastName, FirstName, OrderID
FROM Employees
INNER JOIN
Orders
ON Employees.EmployeeID = Orders.EmployeeID
ORDER BY LastName, FirstName
