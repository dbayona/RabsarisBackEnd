DELIMITER $$
DROP PROCEDURE IF EXISTS allHours;
CREATE DEFINER=`root`@`localhost` 
PROCEDURE `allHours`(out pio_responsecode integer, 
						 out pvo_message varchar(100))
BEGIN
	DECLARE total_rows INT;

	/* SELECT h.id, h.startdate, h.enddate, SUM(hd.TOTAL_REGULAR_TIME) total
	FROM rabsarisapp.hours h, rabsarisapp.hours_DETAIL hd
	where h.id = hd.id_hour
	group by h.id; */
    
    select * from hours;
    
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