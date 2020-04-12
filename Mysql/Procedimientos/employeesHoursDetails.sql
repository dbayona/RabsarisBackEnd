DELIMITER $$
DROP PROCEDURE IF EXISTS employeesHoursDetails;
CREATE DEFINER=`root`@`localhost` 
PROCEDURE `employeesHoursDetails`(in pii_id_hour integer,
								  in pii_id_emp integer,
								  out pio_responsecode integer, 
								  out pvo_message varchar(100))
BEGIN
	DECLARE total_rows INT;
	
    select hd.id,
		   hd.id_hour,
		   hd.id_employee,
		   hd.id_date, 
		   hd.start_regular_time,
		   hd.end_regular_time,
           hd.start_over_time,
		   hd.end_over_time,
		   hd.total_regular_time,
		   hd.total_over_time
	from rabsarisapp.hours_detail hd
	where hd.id_hour = pii_id_hour
	and id_employee = pii_id_emp;
    
    set total_rows = FOUND_ROWS();
    if total_rows > 0 then
		set pio_responsecode = 200;
        set pvo_message = 'Ok';
	else
		set pio_responsecode = 400;
        set pvo_message = 'Error retreiving data';
	end if;
END$$
DELIMITER ;