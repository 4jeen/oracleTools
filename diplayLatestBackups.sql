/*
* Display all backups
*/
select to_char(start_time,'DD.MM.YY HH24:MI:SS') as start_Time
	,to_char(end_time,'DD.MM.YY HH24:MI:SS') as end_Time
	,output_device_type
	,input_type
	,status
	,substr(time_taken_display,0,10) as time_taken
	,substr(input_bytes_display,0,15) as input_bytes
	,substr(output_bytes_display,0,15) as output_bytes from
  V$RMAN_BACKUP_JOB_DETAILS order by start_time ASC;

/*
* Display latatest full & archivelog backups
*/
set linesize 8192;
set pagesize 4096;
select to_char(start_time,'DD.MM.YY HH24:MI:SS')
	,to_char(end_time,'DD.MM.YY HH24:MI:SS')
	,output_device_type
	,input_type
	,status
	,substr(time_taken_display,0,10) as time_taken
	,substr(input_bytes_display,0,15) as input_bytes
	,substr(output_bytes_display,0,15) as output_bytes from
  V$RMAN_BACKUP_JOB_DETAILS where input_type='DB FULL' or input_type='ARCHIVELOG' order by start_time ASC;


/*
* Display only DBFULL backups
*/
select to_char(start_time, 'DD.MM.YY HH24:MI') AS timeStart
	,to_char(end_time , 'DD.MM.YY HH24:MI') as timeEnd
	,output_device_type
	,input_type
	,status
	,substr(time_taken_display,0,10) as time_taken
	,substr(input_bytes_display,0,15) as input_bytes
	,substr(output_bytes_display,0,15) as output_bytes from
  V$RMAN_BACKUP_JOB_DETAILS where input_type='DB FULL' order by start_time ASC;  


select 
  to_char(start_time, 'DD.MM.YY HH24:MI') AS timeStart
	,to_char(end_time , 'DD.MM.YY HH24:MI') as timeEnd
	,output_device_type
	,input_type
	,status
  ,SUBSTR (TRUNC ((end_time-start_time )*24 ) ||':'|| (TRUNC( (end_time-start_time ) *24*60 ) 
    - TRUNC ((end_time-start_time )*24 )*60), 0,10) as time_taken
  ,substr(input_bytes_display,0,15) as input_bytes
	,substr(output_bytes_display,0,15) as output_bytes from
  V$RMAN_BACKUP_JOB_DETAILS where input_type='DB FULL' order by start_time ASC
;  


select 
  to_char(start_time, 'DD.MM.YY HH24:MI') AS timeStart
	,to_char(end_time , 'DD.MM.YY HH24:MI') AS timeEnd
	,output_device_type
	,input_type
	,status
  ,SUBSTR (TRUNC ((end_time-start_time )*24 ) ||':'|| (TRUNC( (end_time-start_time ) *24*60 ) 
    - TRUNC ((end_time-start_time )*24 )*60), 0,10) as HOURS_TAKEN
  ,substr(input_bytes_display,0,15) as input_bytes
	,substr(output_bytes_display,0,15) as output_bytes from
  V$RMAN_BACKUP_JOB_DETAILS where input_type='DB FULL' order by start_time ASC;
  
set linesize 8192;
set pagesize 4096;
col status for A9 heading 'STATUS'
col time_taken for A11 heading 'TIME TAKEN'
col HOURS_TAKEN for A11 heading 'HOURS TAKEN'
col INPUT_TYPE for A8 heading 'INP_TYPE'
col OUTPUT_DEVICE for A6 heading 'DEVICE'

SELECT 
  to_char(start_time, 'DD.MM.YY HH24:MI') AS timeStart
	,to_char(end_time , 'DD.MM.YY HH24:MI') AS timeEnd
	,output_device_type AS OUTPUT_DEVICE
	,input_type AS INPUT_TYPE
	,status
  ,TRUNC(end_time-start_time)||'D '|| 
    (CASE WHEN TRUNC(( ( end_time - start_time ) - TRUNC( end_time - start_time ) ) *24 ) > 9 
      THEN 
        ''||TRUNC(( ( end_time - start_time )-TRUNC( end_time - start_time ) )*24) 
       ELSE
        '0'|| ( TRUNC( ( (end_time - start_time) - TRUNC( end_time - start_time ) ) *24 ) )
        END) || 'H ' 
    || (CASE WHEN (TRUNC( (end_time - start_time ) *24*60 )-TRUNC ((end_time - start_time )*24 ) *60) > 9
        THEN
            '' || ( TRUNC( (end_time - start_time ) *24*60 )-TRUNC ((end_time - start_time )*24 ) *60)
        ELSE
           '0' || ( TRUNC( (end_time - start_time ) *24*60 )-TRUNC ((end_time - start_time )*24 ) *60) 
        END) || 'M ' 
      as  TIME_TAKEN
  ,SUBSTR (TRUNC (( end_time - start_time ) * 24 ) ||':'|| (TRUNC( (end_time - start_time ) *24 * 60 ) 
                                      - TRUNC (( end_time - start_time ) * 24 ) * 60), 0,10 ) as HOURS_TAKEN
  --,time_taken_display as   time_taken
  ,substr(input_bytes_display,0,15) as input_bytes
	,substr(output_bytes_display,0,15) as output_bytes from
  V$RMAN_BACKUP_JOB_DETAILS where input_type != 'ARCHIVELOG' order by start_time ASC;
  
 /*****************************************
 *
 *
 */
set linesize 200;
set pagesize 4096;
col inst_id for 9999999 heading 'Instance #'
col file_nr for 9999999 heading 'File #'
col file_name for A100 heading 'File name'
col checkpoint_change_nr for 99999999999999 heading 'Checkpoint #'
col checkpoint_change_time for A20 heading 'Checkpoint time'
col last_change_nr for 99999999999999 heading 'Last change #'
SELECT
      fe.inst_id,
      fe.fenum file_nr,
      fn.fnnam file_name,
      TO_NUMBER (fe.fecps) checkpoint_change_nr,
      fe.fecpt checkpoint_change_time,
      fe.fests last_change_nr,
      DECODE (
              fe.fetsn,
              0, DECODE (BITAND (fe.festa, 2), 0, 'SYSOFF', 'SYSTEM'),
              DECODE (BITAND (fe.festa, 18),
                      0, 'OFFLINE',
                      2, 'ONLINE',
                      'RECOVER')
      ) status
FROM x$kccfe fe,
     x$kccfn fn
WHERE    (   (fe.fepax != 65535 AND fe.fepax != 0 )
          OR (fe.fepax = 65535 OR fe.fepax = 0)
         )
     AND fn.fnfno = fe.fenum
     AND fe.fefnh = fn.fnnum
     AND fe.fedup != 0
     AND fn.fntyp = 4
     AND fn.fnnam IS NOT NULL
     AND BITAND (fn.fnflg, 4) != 4
ORDER BY fe.fenum
;  

/*************************/