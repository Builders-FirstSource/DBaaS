SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[sp_UpdateServerSpecs]

AS

DELETE FROM [dbo].[ServerConfigAudit_Prod]
WHERE [ServerName] IN (SELECT DISTINCT ServerName from [dbo].[ServerConfigAudit_Staging])

INSERT [ServerConfigAudit_Prod]
([ServerName]
           ,[Setting]
           ,[Minimum]
           ,[Maximum]
           ,[Dynamic]
           ,[Advanced]
           ,[ConfigValue]
           ,[RunValue]
           )
 select 
  [ServerName],
  Setting, 
 [Minimum],
[Maximum],
[Dynamic],
[Advanced],
[ConfigValue],
[RunValue]
from  [ServerConfigAudit_Staging]
WHERE [ServerName] NOT IN (SELECT DISTINCT ServerName from [dbo].[ServerConfigAudit_Prod])

GO
