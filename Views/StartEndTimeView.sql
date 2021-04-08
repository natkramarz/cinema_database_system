CREATE VIEW StartEndTimeScreening
AS
SELECT ScreeningID, [DATE] AS StartTime, [Date] + CAST(RunningTime AS datetime) AS EndTime, RoomID 
FROM Screenings 
JOIN Movies 
ON Movies.MovieID = Screenings.MovieID


SELECT * FROM StartEndTimeScreening
