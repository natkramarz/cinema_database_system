DROP FUNCTION [dbo].employee_who_sold_most_tickets_week

GO
CREATE FUNCTION [dbo].employee_who_sold_most_tickets_week(@date date = NULL) RETURNS INT 
BEGIN 
	IF (@date IS NULL)
		SET @date = GETDATE()
	declare @empId int 
	SELECT TOP 1 @empID = Employees.EmployeeID FROM Employees 
	JOIN Reservations 
	ON Reservations.EmployeeID IS NOT NULL AND Reservations.EmployeeID = Employees.EmployeeID
	AND ReservationDate >= DATEADD(day,-7, @date)
	GROUP BY Employees.EmployeeID
	ORDER BY(SUM(TicketPrice * NumOfTickets))

	return @empID
END 
GO

SELECT [dbo].employee_who_sold_most_tickets_week(default)