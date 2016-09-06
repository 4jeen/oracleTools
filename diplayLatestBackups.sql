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
select to_char(start_time, 'DD.MM.YY HH24:MI') AS start_Time
	,to_char(end_time , 'DD.MM.YY HH24:MI') as timeend
	,output_device_type
	,input_type
	,status
	,substr(time_taken_display,0,10) as time_taken
	,substr(input_bytes_display,0,15) as input_bytes
	,substr(output_bytes_display,0,15) as output_bytes from
  V$RMAN_BACKUP_JOB_DETAILS where input_type='DB FULL' order by start_time ASC;  

