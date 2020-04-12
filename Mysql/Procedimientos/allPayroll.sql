DELIMITER $$
DROP PROCEDURE IF EXISTS allPayroll;
CREATE DEFINER=`root`@`localhost` 
PROCEDURE `allPayroll`(out pio_responsecode integer, 
					   out pvo_message varchar(100))
BEGIN
	DECLARE total_rows INT;
	
    select h.id, h.startdate, h.enddate, sum(totalsalary) total 
	from rabsarisapp.hours h, rabsarisapp.payroll p
	where h.id = p.id_hour
	group by h.id, h.startdate, h.enddate;
    
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