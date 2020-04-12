DELIMITER $$
DROP PROCEDURE IF EXISTS deleteHour;
CREATE DEFINER=`root`@`localhost` 
PROCEDURE `deleteHour`(in pii_id int, out pio_responsecode integer, out pvo_message varchar(100))
BEGIN
DECLARE total_rows INT;

	delete from payroll where id_hour = pii_id;
	delete from hours_detail where id_hour = pii_id;
	delete from hours where id = pii_id;
    
    select row_count() into total_rows;
    if total_rows > 0 then
		set pio_responsecode = 200;
        set pvo_message = 'Ok';
	else
		set pio_responsecode = 400;
        set pvo_message = 'Error deleting data';
	end if;
    
END$$
DELIMITER ;