SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE PROCEDURE [dbo].[sp_GetServerSpecs_Audit]

@ServerName VArchar(128)

AS
 select 

  [ServerName],
	def.Setting, 
  SetVal as DefaultValue,
  [RunValue],
  Comment=case when def.Setval <>  [RunValue] THEN 'Setting updated on ' + @ServerName
    else 'Using default value' 
  end
from DefaultConfig def
join ServerConfigAudit ser
on ser.setting=def.setting 
and def.objectType='server'
and ser.serverName= @ServerName
GO
