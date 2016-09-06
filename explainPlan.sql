set linesize 8192;
set pagesize 4096;

explain plan for         
-- Query text here 
-- Then view results
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);