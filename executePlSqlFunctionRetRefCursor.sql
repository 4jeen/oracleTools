/*
* Execute pl/sql function returning refcursor
* then print results
*/
set linesize 8192;
set pagesize 4096;
set serveroutput on;
set autoprint on;
variable x refcursor ;
exec :x := ADMEXP.ZCASCADE.ZCASCADELICO('','','','','','090232313','01.01.2016','01.01.2017','','','','','','','','','','','','','','','','','','','','DATE_OF_BORDER_CROSS DESC');