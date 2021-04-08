IF OBJECT_ID('tr_seats_insert_delete', 'TR') IS NOT NULL DROP TRIGGER tr_seats_insert_delete
GO
CREATE TRIGGER tr_seats_insert_delete ON Seats
INSTEAD OF INSERT, DELETE
AS 
	PRINT ('Cannot delete or add new seats')
GO