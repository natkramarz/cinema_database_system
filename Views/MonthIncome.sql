DROP VIEW MonthIncome

GO
CREATE VIEW MonthIncome AS
SELECT DATEPART(year,ReservationDate) AS [Year], DateName( month , DateAdd( month , DATEPART(month, ReservationDate) , -1 )) AS [Month], SUM(TicketPrice * NumOfTickets)
AS [Total Earnings] FROM Reservations
GROUP BY DATEPART(year, ReservationDate), DATEPART(month, ReservationDate)
GO


SELECT * FROM MonthIncome
SELECT * FROM Reservations
