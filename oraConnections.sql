set linesize 8192;
set pagesize 4096;
/*
* Display all current connections with executing queries
*/
select sesion.sid,
       sesion.serial#,
       sesion.username,
       sesion.OSUSER,
       optimizer_mode,
       hash_value,
       address,
       cpu_time,
       elapsed_time,
       sql_text
  from v$sqlarea sqlarea, v$session sesion
 where sesion.sql_hash_value = sqlarea.hash_value
   and sesion.sql_address    = sqlarea.address
   and sesion.username is not null;
/*
* disconnect and kill session
*/
alter system DISCONNECT session '158,34267' IMMEDIATE;
alter system KILL session '158,34267' IMMEDIATE;
   
/*
* Display sessions with some kind sql queries
*/   
select sesion.sid,
       sesion.serial#,
       sesion.username,
       sesion.OSUSER,
       optimizer_mode,
       hash_value,
       address,
       cpu_time,
       elapsed_time,
       sql_text
  from v$sqlarea sqlarea, v$session sesion
 where sesion.sql_hash_value = sqlarea.hash_value
   and sesion.sql_address    = sqlarea.address
   and UPPER(sqlarea.SQL_TEXT) LIKE 'CREATE INDEX%'
   and sesion.username is not null;
