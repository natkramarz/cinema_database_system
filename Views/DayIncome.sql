DROP VIEW DayIncome

CREATE VIEW DayIncome 
AS
SELECT CONVERT(date, ReservationDate) AS [Date], SUM(TicketPrice * NumOfTickets) AS [Total Earnings] FROM Reservations
GROUP BY 
CONVERT(date, ReservationDate) 


SELECT * FROM DayIncome

SELECT * FROM Reservations