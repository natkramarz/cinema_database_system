IF OBJECT_ID('add_movie', 'P') IS NOT NULL DROP PROC add_movie

GO
CREATE PROC add_movie(@employeeID int, @MovieTitle nvarchar(196), @ReleaseYear smallint, @RunningTime time,  @genre nvarchar(40))
AS
BEGIN
	IF(@employeeID IS NOT NULL AND @employeeID = 1)
	BEGIN 
		IF (@genre IS NOT NULL)
		BEGIN 
			INSERT INTO Movies VALUES 
				(@MovieTitle, @ReleaseYear, @RunningTime, @genre)
		END 
		ELSE BEGIN
			print('Invalid parameters!')
		END
	END
	ELSE BEGIN 
		print 'Only cinema manager can add movies to cinema program!'
	END
END
GO


EXEC add_movie 1, "Harry Potter and the Philosopher's Stone", 2001, '02:13:00', 'Fantasy' 

DELETE FROM Movies WHERE MovieTitle = 'Harry Potter and the Philosopher''s Stone'

SELECT * FROM Movies 
