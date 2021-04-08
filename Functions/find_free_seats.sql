DROP FUNCTION [dbo].find_free_seats

GO
CREATE FUNCTION [dbo].find_free_seats(@screeningID int)
RETURNS @seatsTab TABLE (SeatID int)
BEGIN
	declare @roomID char 
	SELECT @roomID = RoomID FROM SCREENINGS WHERE ScreeningID = @screeningID
	INSERT INTO @seatsTab 
		SELECT SeatID FROM Seats WHERE @roomID = RoomID and NOT EXISTS (SELECT SeatID FROM SeatStatus WHERE ScreeningID = @screeningID)
	return 
END
GO