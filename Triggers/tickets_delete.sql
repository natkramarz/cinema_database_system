IF OBJECT_ID('tr_tickets_delete', 'TR') IS NOT NULL DROP TRIGGER tr_tickets_delete
GO
CREATE TRIGGER tr_tickets_delete ON Tickets
INSTEAD OF DELETE 
AS
	DELETE FROM Tickets WHERE TicketID IN (SELECT TicketID FROM DELETED)
	DELETE FROM SeatStatus WHERE StatusID IN (SELECT StatusID FROM DELETED)
GO 