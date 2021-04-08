DROP VIEW EarningsPostalCode
GO
CREATE VIEW EarningsPostalCode AS
SELECT PostalCode, ISNULL(SUM(TicketPrice * NumOfTickets), 0) AS [Total Earnings] FROM Customers C
LEFT JOIN Reservations R
ON R.CustomerID IS NOT NULL AND R.CustomerID = C.CustomerID
GROUP BY PostalCode
GO

SELECT * FROM EarningsPostalCode


