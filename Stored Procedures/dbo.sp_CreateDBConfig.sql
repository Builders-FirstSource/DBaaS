SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


/*
┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
│           Name: sp_CreateDBConfig
│ 
│          Description: enters custom database configurations in DatabaseConfig
│
│          Parameters:
│				@DBGUID UNIQUEIDENTIFER
|				@Setting varchar(128)
|				@SetVal varchar(128)
│
│          Author:	Jennifer Burris 
│          Date:	3/31/2025
|
|  EXEC SP_CreateDBConfig @DBName = 'DBaaS_Test'
╞═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════	
│          Change History:
├──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
│DATE:		AUTHOR:			VERSION:		DESCRIPTION:
└──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
*/

CREATE    PROCEDURE [dbo].[sp_CreateDBConfig]
	@DBGuid UNIQUEIDENTIFIER, @Setting varchar(128), @SetVal varchar(128) 
AS
BEGIN

	SET NOCOUNT ON;

	INSERT INTO DatabaseConfig (Database_GUID, Setting, SetVal)
	VALUES
	(@DBGuid, @Setting, @SetVal)

END
GO
