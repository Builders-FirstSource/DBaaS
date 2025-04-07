SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


/*-- =============================================
-- Author:		Jennifer Burris
-- Create date: 03/17/2025
-- Description:	Gets the default and custom configurations for Server or Database
-- Parameters:	@GUID - the GUID for the Database or Server to get Configurations for
--				@ObjectType - Database or Server -- Not used yet
-- =============================================*/
CREATE PROCEDURE [dbo].[sp_GetConfigurations]
(@GUID UNIQUEIDENTIFIER, @ObjectType VARCHAR(128))
AS
BEGIN
	SET NOCOUNT ON;

	DROP TABLE IF EXISTS #Config;
	CREATE TABLE #Config (Setting VARCHAR(128),SetVal VARCHAR(128));

	INSERT INTO #Config(Setting, SetVal) -- need to add logic to get database or server
	SELECT Setting,
		   SetVal
	FROM DatabaseConfig
	WHERE Database_GUID = @GUID


	SELECT DC.Setting, ISNULL(C.SetVal, DC.SetVal)
	FROM DefaultConfig DC
	LEFT JOIN #Config C
		ON DC.Setting = C.Setting
	WHERE DC.ObjectType = 'Database'
	AND Automation = 1
	UNION
	SELECT 'ObjectName', DatabaseName
	FROM Databases
	WHERE Database_GUID = @GUID
	UNION
	SELECT 'ServerName', ServerName
	FROM Databases
	WHERE Database_GUID = @GUID
	
END
GO
