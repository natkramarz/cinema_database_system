DROP VIEW FilmsEarnings
GO
CREATE View FilmsEarnings AS 
SELECT M.MovieTitle, ISNULL(SUM(TicketPrice * NumOfTickets), 0) [Total Earnings] FROM Movies M
LEFT JOIN Screenings S	ON M.MovieID = S.MovieID
LEFT JOIN Reservations R ON S.ScreeningID = R.ScreeningID
GROUP BY M.MovieID, M.MovieTitle
GO

SELECT * FROM FilmsEarnings