DELIMITER $$
DROP PROCEDURE IF EXISTS updateClub;
CREATE DEFINER=`root`@`localhost`  
PROCEDURE `updateClub` (inout pii_id integer,
					    in pid_start_date date,
					    in pid_end_date date,
					    in pnn_monthly_fee decimal(10, 2),
                        out pio_responsecode integer, 
						out pvo_message varchar(100)
					   )
BEGIN
	DECLARE total_rows INT;
	update rabsarisapp.clubs
    set start_date = pid_start_date,
		end_date = pid_end_date,
        monthly_fee = pnn_monthly_fee
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