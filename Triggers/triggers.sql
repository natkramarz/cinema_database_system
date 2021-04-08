IF OBJECT_ID('tr_screening_rooms_insert_delete', 'TR') IS NOT NULL DROP TRIGGER tr_screening_rooms_insert_delete
GO
CREATE TRIGGER tr_screening_rooms_insert_delete ON ScreeningRooms
INSTEAD OF INSERT, DELETE
AS 
	PRINT ('Cannot delete or add a new screening room')
GO


IF OBJECT_ID('tr_seats_insert_delete', 'TR') IS NOT NULL DROP TRIGGER tr_seats_insert_delete
GO
CREATE TRIGGER tr_seats_insert_delete ON Seats
INSTEAD OF INSERT, DELETE
AS 
	PRINT ('Cannot delete or add new seats')
GO

IF OBJECT_ID('tr_screening_insert', 'TR') IS NOT NULL DROP TRIGGER tr_screening_insert
GO
CREATE TRIGGER tr_screening_insert ON Screenings 
INSTEAD OF INSERT
AS
	IF NOT EXISTS (SELECT INSERTED.[DATE] FROM INSERTED JOIN StartEndTimeScreening ON INSERTED.[DATE] >= StartTime AND INSERTED.[DATE] <= EndTime AND
	Inserted.RoomID = StartEndTimeScreening.RoomID) 
	   AND NOT EXISTS(SELECT INSERTED.[DATE] FROM INSERTED WHERE [DATE] <= GETDATE())
	BEGIN

		INSERT INTO Screenings(MovieID, [Date], RoomID)
			SELECT MovieID, [Date], RoomID FROM Inserted
	END 
GO

IF OBJECT_ID('tr_tickets_delete', 'TR') IS NOT NULL DROP TRIGGER tr_tickets_delete
GO
CREATE TRIGGER tr_tickets_delete ON Tickets
INSTEAD OF DELETE 
AS
	DELETE FROM Tickets WHERE TicketID IN (SELECT TicketID FROM DELETED)
	DELETE FROM SeatStatus WHERE StatusID IN (SELECT StatusID FROM DELETED)
GO 

IF OBJECT_ID('tr_reservations_delete', 'TR') IS NOT NULL DROP TRIGGER tr_reservations_delete
GO
CREATE TRIGGER tr_reservations_delete ON Reservations
INSTEAD OF DELETE 
AS
	DELETE FROM Tickets WHERE ReservationID IN (SELECT ReservationID FROM DELETED)
	DELETE FROM Reservations WHERE ReservationID IN (SELECT ReservationID FROM DELETED)
GO