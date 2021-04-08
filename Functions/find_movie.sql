DROP FUNCTION [dbo].find_movie

GO
CREATE FUNCTION [dbo].find_movie(@movieTitle nvarchar(256)) RETURNS int 
BEGIN 
	return (SELECT MovieID FROM Movies WHERE MovieTitle = @movieTitle)
END
GO 