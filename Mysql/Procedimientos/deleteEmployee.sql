DELIMITER $$
DROP PROCEDURE IF EXISTS deleteEmployee;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteEmployee`(in pii_id int)
BEGIN
	delete from employees where id = pii_id;
    delete from clubs where id_employee = pii_id;
END$$
DELIMITER ;
