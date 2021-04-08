IF OBJECT_ID('tr_screening_rooms_insert_delete', 'TR') IS NOT NULL DROP TRIGGER tr_screening_rooms_insert_delete
GO
CREATE TRIGGER tr_screening_rooms_insert_delete ON ScreeningRooms
INSTEAD OF INSERT, DELETE
AS 
	PRINT ('Cannot delete or add a new screening room')
GO