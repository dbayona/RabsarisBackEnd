DELIMITER $$
DROP PROCEDURE IF EXISTS updateHoursDetails;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateHoursDetails`( inout pii_id_hour integer,
									inout pii_id_emp integer,
									in pti_start_regular_time time,
									in pti_end_regular_time time,
									in pti_start_over_time time,
									in pti_end_over_time time,
									in pii_total_regular_time integer,
									in pii_total_over_time integer,
                                    out pio_responsecode integer, 
                                    out pvo_message varchar(100))
BEGIN
	DECLARE total_rows INT;
    
	update rabsarisapp.hours_detail
	set start_regular_time = pti_start_regular_time,
		end_regular_time = pti_end_regular_time,
		start_over_time = pti_start_over_time,
		end_over_time = pti_end_over_time,
		total_regular_time = pii_total_regular_time,
		total_over_time = pii_total_over_time
	where id_hour = pii_id_hour
	and id_employee = pii_id_emp;
    
    set total_rows = ROW_COUNT();
    if total_rows > 0 then
		set pio_responsecode = 200;
        set pvo_message = 'Ok';
	else
		set pio_responsecode = 400;
        set pvo_message = 'No updated';
	end if;
END$$
DELIMITER ;
