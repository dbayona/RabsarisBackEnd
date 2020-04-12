DELIMITER $$
DROP PROCEDURE IF EXISTS payrollDetails;
CREATE DEFINER=`root`@`localhost` 
PROCEDURE `payrollDetails`(in pii_id_hour integer,
						   out pio_responsecode integer, 
					       out pvo_message varchar(100))
BEGIN
	DECLARE total_rows INT;
	
    select p.id, concat(e.firstname, " ", e.lastname) fullname, p.id_hour, p.id_emp, p.salaryhour, p.totalhour, p.netsalary, p.totaltaxes, p.totalsalary
	from rabsarisapp.employees e, rabsarisapp.payroll p
    where e.id = p.id_emp
	and p.id_hour = pii_id_hour;
    
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