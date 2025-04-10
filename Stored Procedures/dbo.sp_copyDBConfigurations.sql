SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*
┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
│           Name: sp_copyDBConfigurations
│ 
│          Description: copies the database configurations to a new guid. 
│
│          Parameters:
│				@newGuid uniqueidentifier this is the new object to coput configurations to
|				@SourceGuid uniqueidentifer this is the object to copy configurations from
│          Author:	Jennifer Burris 
│          Date:	3/31/2025
|
|  
╞═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════	
│          Change History:
├──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
│DATE:		AUTHOR:			VERSION:		DESCRIPTION:
└──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
*/
CREATE PROCEDURE [dbo].[sp_copyDBConfigurations]
	@newGuid UNIQUEIDENTIFIER
	,@SourceGuid UNIQUEIDENTIFIER
AS
BEGIN
	SET NOCOUNT ON;

	IF EXISTS (SELECT * FROM DatabaseConfig WHERE Database_GUID = @newGuid)
		DELETE DatabaseConfig WHERE Database_GUID = @newGuid

	INSERT INTO dbo.DatabaseConfig(Database_GUID,Setting,SetVal)
	SELECT @newGuid, Setting, SetVal
	FROM DatabaseConfig 
	WHERE Database_GUID = @SourceGuid
END
GO
