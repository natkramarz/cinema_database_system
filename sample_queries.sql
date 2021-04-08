SELECT FirstName, LastName, PostalCode FROM Customers
SELECT FirstName, LastName FROM Employees

SELECT * FROM Screenings WHERE [Date] <= DATEADD(day, 7, GETDATE())

SELECT MovieTitle, [Date] FROM Movies
JOIN Screenings 
ON Movies.MovieID = Screenings.MovieID
WHERE [Date] <= DATEADD(day, 7, GETDATE())

SELECT MovieTitle, ReleaseYear, RunningTime FROM Movies
WHERE GENRE = 'Thriller'

SELECT * FROM MonthIncome ORDER BY [Total Earnings] DESC 

SELECT Screenings.ScreeningID, ISNULL(SUM(NumOfTickets), 0) [Number of sold tickets] FROM Screenings
LEFT JOIN Reservations 
ON Screenings.ScreeningID = Reservations.ScreeningID
GROUP BY Screenings.ScreeningID
ORDER BY COUNT(ReservationID) DESC