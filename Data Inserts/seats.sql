IF OBJECT_ID('seats_insertion_rooms', 'P') IS NOT NULL DROP PROC  seats_insertion_rooms
IF OBJECT_ID('seats_insertion', 'P') IS NOT NULL DROP PROC seats_insertion

GO 
CREATE PROCEDURE seats_insertion(@RoomID char, @RowsNumber tinyint, @SeatsInRow tinyint) AS BEGIN 
	DECLARE @i tinyint = 1
	DECLARE @j tinyint = 1
	WHILE @i <= @RowsNumber
	BEGIN
		SET @j = 1
		WHILE @j <= @SeatsInRow
		BEGIN 
			INSERT INTO Seats(RoomID, [Row], [Column])
			VALUES (@RoomID, @i, @j)
			SET @j += 1
		END 
		SET @i += 1
	END
END
GO

GO 
CREATE PROCEDURE seats_insertion_rooms AS BEGIN
DECLARE @RoomID char
SELECT TOP 1 @RoomID=RoomID FROM ScreeningRooms ORDER BY RoomID
DECLARE @RowsNumber tinyint
DECLARE @SeatsInRow tinyint 
DECLARE @i int
SELECT @i = COUNT(*) FROM ScreeningRooms 
WHILE @i > 0 
BEGIN 
	SELECT @RowsNumber = RowsNumber, @SeatsInRow = SeatsInRowNum FROM ScreeningRooms WHERE @RoomID = RoomID
	EXECUTE seats_insertion @RoomID, @RowsNumber,  @SeatsInRow
	PRINT @RoomID
	SELECT TOP 1 @RoomID=RoomID FROM ScreeningRooms WHERE RoomID > @RoomID ORDER BY RoomID
	SET @i -= 1
END
END
GO

EXECUTE seats_insertion_rooms

SELECT * FROM Seats