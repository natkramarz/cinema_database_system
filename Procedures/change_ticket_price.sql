IF OBJECT_ID('change_ticket_price', 'P') IS NOT NULL DROP PROC change_ticket_price 

GO
CREATE PROC change_ticket_price(@employeeID int, @ticketType nvarchar(20),  @price money,  @date date = NULL)
AS
BEGIN 
	IF(@employeeID IS NOT NULL AND @employeeID = 1)
	BEGIN 
		if (@date IS NULL)
			SET @date = GETDATE()
		UPDATE TicketPrices 
		SET EndDate = DATEADD(day, -1, @date) 
		WHERE @ticketType = TicketType AND EndDate IS NULL 
		INSERT INTO TicketPrices VALUES 
			(@ticketType, @price, NULL)
	END
	ELSE BEGIN 
		print 'Only cinema manager can change ticket prices!'
	END
END
GO

EXEC change_ticket_price 1, 'regular', 22, default
SELECT * FROM Employees
SELECT * FROM TicketPrices
