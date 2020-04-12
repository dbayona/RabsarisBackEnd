DELIMITER $$
DROP PROCEDURE IF EXISTS allClub;
CREATE DEFINER=`root`@`localhost` 
PROCEDURE `allClub`(out pio_responsecode integer, 
					out pvo_message varchar(100))
BEGIN
	DECLARE total_rows INT;
    select clu.id, emp.firstname, emp.lastname, clu.start_date, clu.end_date, 
		   clu.monthly_fee 
	from rabsarisapp.employees emp, rabsarisapp.clubs clu
	where emp.id = clu.id_employee
	and emp.active = 1;
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
