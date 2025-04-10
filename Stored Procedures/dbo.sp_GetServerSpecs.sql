SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE PROCEDURE [dbo].[sp_GetServerSpecs]

@ServerName VArchar(128)

AS
 select 
  [ServerName],
  Setting, 
 [Minimum],
[Maximum],
[ConfigValue],
[RunValue]
from  ServerConfigAudit
where serverName= @ServerName
GO
