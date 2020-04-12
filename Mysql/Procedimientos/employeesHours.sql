DELIMITER $$
DROP PROCEDURE IF EXISTS employeesHours;
CREATE DEFINER=`root`@`localhost` 
PROCEDURE `employeesHours`(in pii_id_hour integer,
						 out pio_responsecode integer, 
						 out pvo_message varchar(100))
BEGIN
	DECLARE total_rows INT;
	
    -- Select * from employees where active = 1;
    select e.id, concat(e.firstname, " ", e.lastname) fullname , sum(hd.total_regular_time) totalHoursRegulars, sum(hd.total_over_time) totalHoursXtras
	from rabsarisapp.hours_detail hd, rabsarisapp.employees e
	where hd.id_hour = pii_id_hour
    and hd.id_employee = e.id
	group by hd.id_employee;
    
    set total_rows = FOUND_ROWS();
    if total_rows > 0 then
		set pio_responsecode = 200;
        set pvo_message = 'Ok';
	else
		set pio_responsecode = 400;
        set pvo_message = 'Error retreiving data';
        set pvo_message = concat('Error retreiving data: ', " ", pii_id_hour);
	end if;
END$$
DELIMITER ;