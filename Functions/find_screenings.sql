DROP FUNCTION [dbo].find_screenings 
GO 
CREATE FUNCTION [dbo].find_screenings(@movieTitle nvarchar(256), @date datetime = NULL)
RETURNS @screenings_tab TABLE (ScreeningID int, MovieID int, [Date] datetime, RoomID char)
BEGIN
		if (@date IS NULL)
			SET @date = GETDATE()
		declare @movie_id int = (SELECT [dbo].find_movie(@movieTitle))
		INSERT INTO @screenings_tab(ScreeningID, MovieID, [Date], RoomID)
		 SELECT * FROM Screenings WHERE  MovieID = @movie_id AND DATEDIFF(day, @date, [Date]) >= 0
		return
END 
GO