DELIMITER $$
DROP PROCEDURE IF EXISTS updateEmployee;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEmployee`(	inout pii_id integer,
									in piv_firstname varchar(100), 
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
	DECLARE total_rows INT;
	update Employees
    set firstname = piv_firstname, 
		lastname = piv_lastname,
        identification = piv_identification,
        birthday = vid_birthday, 
        genre = piv_genre, 
        ocupation = piv_ocupation, 
        active = pii_active, 
        rate = pid_rate, 
        club = pii_club, 
        term = pii_term
	where id = pii_id;
    set total_rows = ROW_COUNT();
    if total_rows > 0 then
		set pio_responsecode = 200;
        set pvo_message = 'Ok';
	else
		set pio_responsecode = 400;
        set pvo_message = 'No updated';
	end if;
END$$
DELIMITER ;
