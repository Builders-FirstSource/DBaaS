SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
│           Name: sp_CreateDBConfig
│ 
│          Description: Generates Statements to create a database with the stored configurations
│
│          Parameters:
│				@DatabaseName
|				@ServerName - Default BFS-SQLDBA01
│
│          Author:	Jennifer Burris 
│          Date:	3/17/2025
╞═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════	
│          Change History:
├──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
│DATE:		AUTHOR:			VERSION:		DESCRIPTION:
└──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
*/

CREATE   PROCEDURE [dbo].[sp_CreateDBConfig]
	@DBName VARCHAR(120), @ServerName VARCHAR(128) = 'BFS-SQLDBA01'
AS
BEGIN

	SET NOCOUNT ON;
	IF @DBName IS NULL
	BEGIN
	 RAISERROR('A Database Name cannot be NULL', 16, 1)
	 RETURN;
	END

	DECLARE @DBGUID UNIQUEIDENTIFIER
	
	SELECT Database_GUID
	FROM Databases 
	WHERE DatabaseName = @DBName
	AND ServerName = @ServerName
	
	IF @@ROWCOUNT != 0
		BEGIN
			INSERT INTO Databases(DatabaseName, ServerName)
			VALUES (@DBName, @ServerName)
		END

	SELECT @DBGUID = Database_GUID
	FROM Databases 
	WHERE DatabaseName = @DBName
	AND ServerName = @ServerName
END
GO
