SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE   PROCEDURE [dbo].[sp_GetDatabaseSpecs] 

@DBName VArchar(128)

AS

select 
  def.Setting, 
  db.DatabaseName,
  SetVal=isnull(dbc.SetVal, def.setVal),
  Comment=case when dbc.Setval is null then '' 
    else '#Default override' 
  end
from DefaultConfig def
left join DatabaseConfig dbc
on dbc.setting=def.setting 
left join [DATABASES] db
on dbc.Database_GUID=db.Database_GUID
and objectType='database'
and db.DatabaseName=@DBName
GO
