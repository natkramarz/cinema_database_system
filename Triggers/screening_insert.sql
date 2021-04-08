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