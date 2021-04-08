IF OBJECT_ID('tr_reservations_delete', 'TR') IS NOT NULL DROP TRIGGER tr_reservations_delete
GO
CREATE TRIGGER tr_reservations_delete ON Reservations
INSTEAD OF DELETE 
AS
	DELETE FROM Tickets WHERE ReservationID IN (SELECT ReservationID FROM DELETED)
	DELETE FROM Reservations WHERE ReservationID IN (SELECT ReservationID FROM DELETED)
GO