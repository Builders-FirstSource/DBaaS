SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[sp_GetServerSpecs]

@ServerName VArchar(128)

AS
 select 

  def.Setting, 
  SetVal=isnull(ser.SetVal, def.setVal),
  Comment=case when ser.Setval is null then '' 
    else '#Default override' 
  end
from DefaultConfigAudit def
left join ServerConfig ser
on ser.setting=def.setting 
and objectType='server'
and ser.serverName= @ServerName
GO
