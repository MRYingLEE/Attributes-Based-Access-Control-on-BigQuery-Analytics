CREATE OR REPLACE PROCEDURE `poised-renderer-284307.abac.CreateViewWithContext`(context_name STRING)
BEGIN

DECLARE pii BOOL;
DECLARE cols STRING;
DECLARE view_name STRING;

set pii=(select max(c.PII_Allowed) from `poised-renderer-284307.abac.Context_Attributes` as c where c.Context=context_name );

IF (pii is NULL) or (pii = FALSE) THEN
    set pii=FALSE;
    set view_name='poised-renderer-284307.without_PII.view_of_data';
    CREATE SCHEMA  IF NOT EXISTS `poised-renderer-284307.without_PII`;
ELSE 
    set pii=TRUE;
    set view_name='poised-renderer-284307.with_PII.view_of_data';
    CREATE SCHEMA  IF NOT EXISTS `poised-renderer-284307.with_PII`;
END IF;

IF pii THEN
    SET cols = (
    select String_Agg(d.col_name,",") from `poised-renderer-284307.abac.Data_Attributes` as d, `poised-renderer-284307.abac.User_Attributes` as u 
    where u.Session_User=Session_User() and u.Region in UNNEST(split(d.Regions,";")));
ELSE 
    SET cols = (
    select String_Agg(d.col_name,",") from `poised-renderer-284307.abac.Data_Attributes` as d, `poised-renderer-284307.abac.User_Attributes` as u 
    where u.Session_User=Session_User() and u.Region in UNNEST(split(d.Regions,";")) and d.PII=FALSE );
END IF;

EXECUTE IMMEDIATE format("""
  CREATE or REPLACE View %s as  
  SELECT 
    %s
  FROM `poised-renderer-284307.abac.data`
  where email=Session_User() and Region in 
  ( select Region from `poised-renderer-284307.abac.User_Attributes` 
    where Session_User=Session_User() 
  )
""",  view_name, cols);

END;
