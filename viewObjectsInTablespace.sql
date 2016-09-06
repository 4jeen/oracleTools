/*
* View objects in tablespace
*/
set linesize 8192;
set pagesize 4096;

SELECT * FROM dba_segments WHERE TABLESPACE_NAME='USERS' ORDER BY bytes DESC;