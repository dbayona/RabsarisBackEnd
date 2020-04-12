DELIMITER $$
DROP PROCEDURE IF EXISTS readEmployee;
CREATE DEFINER=`root`@`localhost` PROCEDURE `readEmployee`(in pii_id integer, out pio_responsecode integer, out pvo_message varchar(100))
BEGIN
	DECLARE total_rows INT;updateEmployee
	select * from Employees where id = pii_id;
    set total_rows = FOUND_ROWS();
    if total_rows > 0 then
		set pio_responsecode = 200;
        set pvo_message = 'Ok';
	else
		set pio_responsecode = 400;
        set pvo_message = 'No data';
	end if;
END$$
DELIMITER ;