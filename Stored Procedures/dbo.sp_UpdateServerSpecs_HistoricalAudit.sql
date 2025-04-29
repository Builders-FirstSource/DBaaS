SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[sp_UpdateServerSpecs_HistoricalAudit]

--@ServerName VArchar(128)

AS
 select 

  [ServerName],
	def.Setting, 
  SetVal as DefaultValue,
  [RunValue],
  Comment=case when def.Setval <>  [RunValue] THEN 'Setting updated on ' + [ServerName]
    else 'Using default value' 
  end
into #temp1
from DefaultConfig def
join ServerConfigAudit ser
on ser.setting=def.setting 
and def.objectType='server'
--and ser.serverName= @ServerName

--SELECT * from #temp1 where comment <> 'Using default value' 
--ORDER BY [ServerName]



INSERT INTO [dbo].[ServerConfigAudit_Historical]
           ([ServerName]
           ,[Setting]
           ,[DefaultValue]
           ,[RunValue]
		   ,Comment)
      SELECT * from #temp1 where comment <> 'Using default value' 
ORDER BY [ServerName]

GO
