/*
*
*
*
*/

DECLARE
/*
* Table Name
*/
TNAME VARCHAR2(30) := 'TABLE_NAME';
/*
* Table Name
*/
INAME VARCHAR2(30) := 'INDEX_NAME';
/*
* TableSpace Name. Leave it empty for using default tablespace to this index 
*/
TSPACENAME VARCHAR2(30)  := 'TABLE_SPACE_NAME';
/*
* Sql Command Buffer
*/
BUF VARCHAR2(300);


 BEGIN
	FOR aRec IN ( 
			SELECT UIP.PARTITION_NAME AS "PN" , UI.INDEX_NAME AS "UIN" , UI.TABLE_NAME AS "TN" 
			FROM USER_IND_PARTITIONS UIP 
				JOIN USER_INDEXES UI ON UI.INDEX_NAME = UIP.INDEX_NAME 
				WHERE UI.TABLE_NAME = TNAME AND  UI.INDEX_NAME = INAME
		)LOOP
      BUF :=  'ALTER INDEX '|| aRec.UIN || ' REBUILD PARTITION "' || aRec.PN || 
      	CASE WHEN TSPACENAME IS NOT NULL THEN
      		'" TABLESPACE '|| TSPACENAME ||' ;'
      	ELSE
      		'" ;'	
      	END;
      	
      DBMS_OUTPUT.PUT_LINE(BUF);	
      --EXECUTE IMMEDIATE REGEXP_REPLACE(BUF,' ;$','');
	END LOOP;
END;
/

