IF OBJECT_ID('backup_multikino', 'P') IS NOT NULL DROP PROC backup_multikino 
GO
CREATE PROCEDURE backup_multikino
AS
BACKUP DATABASE [Multikino] 
TO DISK = N'C:\temp\Multikino.bak' 
WITH NOFORMAT, NOINIT,  
NAME = N'Multikino Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

EXEC backup_multikino


USE [master]
RESTORE DATABASE [Multikino] 
FROM DISK = N'C:\temp\Multikino.bak' WITH  FILE = 1,  NOUNLOAD,  STATS = 5
GO

SELECT * FROM Customers


SELECT * FROM SeatStatus

DELETE FROM Tickets WHERE TicketID IN (SELECT TicketID FROM Tickets T JOIN Reservations R ON T.ReservationID = R.ReservationID JOIN Screenings S ON S.ScreeningID = R.ScreeningID AND DATEDIFF(day, GETDATE(), S.[Date]) > 7)

SELECT * FROM Tickets

SELECT ReservationDate, DATEDIFF(day, GETDATE(), ReservationDate) FROM Reservations

