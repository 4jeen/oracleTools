/*
* Find objects in datafile
*/
select *  from ( 
 select * 
 from dba_extents 
 where file_id = ( select file_id 
 from dba_data_files 
 where file_name = '/mnt/sdd/sdd1/oracle/oradata/datafile.dbf' ) and block_id BETWEEN 2354817 and 2361992
 order by block_id desc  )  where rownum <= 15 ;