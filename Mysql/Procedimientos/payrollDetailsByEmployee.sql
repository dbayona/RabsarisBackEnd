DELIMITER $$
DROP PROCEDURE IF EXISTS payrollDetailsByEmployee;
CREATE DEFINER=`root`@`localhost` 
PROCEDURE `payrollDetailsByEmployee`(in pii_id_hour integer,
									 in pii_id_emp integer,
									 out pio_responsecode integer, 
									 out pvo_message varchar(100))
BEGIN
	DECLARE total_rows INT;
	
    select e.id, concat(e.firstname, " ", e.lastname) fullname, e.identification, e.rate,
		   ifnull(p.netsalary, 0) netsalary, ifnull(p.overhour, 0) overhour, ifnull(p.task, 0) task, ifnull(p.sunday, 0) sunday, ( ifnull(p.netsalary, 0) + ifnull(p.overhour, 0) + ifnull(p.task, 0) + ifnull(p.sunday, 0) ) total_imcome,
           ifnull(p.socialsecuritytax, 0) socialsecuritytax, ifnull(p.educationalinsurancetax, 0) educationalinsurancetax, ifnull(p.suntracs, 0) suntracs, ifnull(p.groupinsurance, 0) groupinsurance, ( ifnull(p.socialsecuritytax, 0) + ifnull(p.educationalinsurancetax, 0) + ifnull(p.suntracs, 0) + ifnull(p.groupinsurance, 0) ) total_discounts
	from rabsarisapp.employees e, rabsarisapp.payroll p
	where e.id = p.id_emp
	and p.id_hour = pii_id_hour
	and p.id_emp = pii_id_emp;
    
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