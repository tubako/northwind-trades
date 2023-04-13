# northwind-trades
Mock data analysis to influence a business decision. 

Northwind Traders is a fictional company that buys products and resells them to customers. 

As an incentive, the company decided to give a bonus to high performing employees. These high performing employees being the ones who are responsible for the five highest order amounts. This analysis will focus on correctly identifying the employees that are eligible for this bonus.
The figure below shows the Northwind database. According to this database, to get the highest order amounts and the employees who completed them, these following tables will be needed: Employees, Orders, OrderDetails and Products. 

After examining these tables one by one, the following plan is made. FirstName and LastName columns from the Employees table are needed to have the names of the employees. Then, Employees and Orders tables can be joined using their common  column which is EmployeeID.  This join is important to be able to connect the EmployeeID to OrderID to figure out which employee is responsible for which order. 

