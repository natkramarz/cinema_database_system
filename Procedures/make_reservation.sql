CREATE TYPE SeatsTableType 
AS TABLE (SeatsID int)

IF OBJECT_ID('make_reservation', 'P') IS NOT NULL DROP PROC  make_reservation
GO
CREATE PROC make_reservation(@SeatsTab SeatsTableType READONLY, @screeningID int, @EmployeeID int = NULL, @CustomerID int = NULL)
AS
		BEGIN TRAN
		SET XACT_ABORT ON 
		declare @ticketPrice money
		declare @numOfTickets int 
		SELECT @numOfTickets = COUNT(DISTINCT SeatsID) FROM @SeatsTab
		SELECT @ticketPrice = [dbo].find_ticket_price(default)
		INSERT INTO Reservations (CustomerID, EmployeeID, ScreeningID, ReservationDate, TicketPrice, NumOfTickets) VALUES
		(@CustomerID, @EmployeeID, @screeningID, GETDATE(), @ticketPrice, @numOfTickets)
		declare @reservationID int 
		SELECT @reservationID = SCOPE_IDENTITY() 
		DECLARE @StatusIds TABLE (id int)
		INSERT INTO SeatStatus
			OUTPUT INSERTED.StatusID INTO @StatusIds
			SELECT *, @screeningID FROM @SeatsTab
		INSERT INTO Tickets
			SELECT @reservationID, id FROM @StatusIds
		COMMIT
GO

GO
DECLARE @SeatsTab SeatsTableType
INSERT INTO @SeatsTab VALUES
	(88), (87), (86)


EXEC make_reservation @SeatsTab, 1, 3, default