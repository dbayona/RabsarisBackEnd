DELIMITER $$
DROP PROCEDURE IF EXISTS createEmployee;
CREATE DEFINER=`root`@`localhost` PROCEDURE `createEmployee`(in piv_firstname varchar(100), 
															in piv_lastname varchar(100),
                                                            in piv_identification varchar(100),
                                                            in vid_birthday date,
															in piv_genre char(1), 
                                                            in piv_ocupation varchar(40), 
                                                            in pii_active int,
															in pid_rate DECIMAL(4,2), 
                                                            in pii_club int, 
                                                            in pii_term int,
                                                            out pio_responsecode integer, 
															out pvo_message varchar(100))
BEGIN
DECLARE last_id INT;
DECLARE total_rows INT;
	insert into employees (firstname, lastname, identification, birthday, genre, ocupation, active, rate, club, term)
	values(piv_firstname, piv_lastname, piv_identification, vid_birthday, piv_genre, piv_ocupation, pii_active, pid_rate, pii_club, pii_term);
    
    set last_id = LAST_INSERT_ID();
    
    insert into clubs (id_employee) values (last_id);
    
    select * from employees where id = last_id;
    
    set total_rows = FOUND_ROWS();
    if total_rows > 0 then
		set pio_responsecode = 200;
        set pvo_message = 'Ok';
	else
		set pio_responsecode = 400;
        set pvo_message = 'Error inserting data';
	end if;
    
END$$
DELIMITER ;
