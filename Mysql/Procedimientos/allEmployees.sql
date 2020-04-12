DELIMITER $$
DROP PROCEDURE IF EXISTS allEmployees;
CREATE DEFINER=`root`@`localhost` 
PROCEDURE `allEmployees`(out pio_responsecode integer, 
						 out pvo_message varchar(100))
BEGIN
	DECLARE total_rows INT;
	Select * from employees;
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
