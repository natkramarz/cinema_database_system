DROP FUNCTION [dbo].find_ticket_price

GO 
CREATE FUNCTION [dbo].find_ticket_price(@date datetime = NULL)
RETURNS money 
BEGIN 
	declare @weekday int 
	if (@date IS NULL)
			SET @date = GETDATE()
	SELECT  @weekday = DATEPART(WEEKDAY, @date)
	if @weekday = 0
		return (SELECT PRICE FROM TicketPrices WHERE TicketType = 'monday' AND EndDate IS NULL) 
	if @weekday = 2
		return (SELECT PRICE FROM TicketPrices WHERE TicketType = 'wednesday' AND EndDate IS NULL) 

	return (SELECT PRICE FROM TicketPrices WHERE TicketType = 'regular' AND EndDate IS NULL) 
END 
GO