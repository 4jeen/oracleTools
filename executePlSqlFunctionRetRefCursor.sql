/*
* Execute pl/sql function returning refcursor
* then print results
*/
set linesize 8192;
set pagesize 4096;
set serveroutput on;
set autoprint on;
variable x refcursor ;
exec :x := FUN_RETURN_REFCUSOR('','','','','','','','','','','','','','','','','','','','','','','','','','','','');