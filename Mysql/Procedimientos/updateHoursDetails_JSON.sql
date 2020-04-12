DELIMITER $$
DROP PROCEDURE IF EXISTS updateHoursDetailsJSON;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateHoursDetailsJSON`( 
                                    in jsonData json,
                                    out pio_responsecode integer, 
                                    out pvo_message varchar(100))
BEGIN
	DECLARE total_rows, i, jCount, pid, pid_hour, pid_emp, totalhours, totaloverhours INT;
    SET jCount = 0;
    SET i = 0;
	-- SET @jsonData = '[{"from":12,"to":0},{"from":11,"to":-1},{"from":1,"to":1},{"a":"teste"}]' ;
    /* 	id: 66
		id_hour: 18
		id_employee: 2
		id_date: "2020-03-02T05:00:00.000Z"
		start_regular_time: "07:00:00"
		end_regular_time: "15:00:00"
		start_over_time: "15:00:00"
		end_over_time: "16:00:00"
		total_regular_time: 8
		total_over_time: 1 */
        
	SET jCount = jCount + JSON_LENGTH( jsonData, '$' );
	-- select jCount;
    WHILE ( i < jCount ) DO
		
        -- select JSON_EXTRACT(jsonData, CONCAT( '$[', i, '].id'));
        set pid = JSON_EXTRACT(jsonData, CONCAT( '$[', i, '].id'));
        set pid_hour = JSON_EXTRACT(jsonData, CONCAT( '$[', i, '].id_hour'));
        set pid_emp = JSON_EXTRACT(jsonData, CONCAT( '$[', i, '].id_employee'));
        
        -- select i, pid, pid_hour, pid_emp;
		-- select CAST( JSON_UNQUOTE( JSON_EXTRACT(jsonData, CONCAT( '$[', i, '].start_regular_time'))) as Time);
        -- select JSON_EXTRACT(jsonData, CONCAT( '$[', i, '].start_regular_time')) ;
        -- select if ( JSON_TYPE( JSON_EXTRACT(jsonData, CONCAT( '$[', i, '].start_regular_time'))) = 'NULL',NULL, CAST( JSON_UNQUOTE( JSON_EXTRACT(jsonData, CONCAT( '$[', i, '].start_regular_time'))) as Time) );
        
        -- Actualización de las horas trabajas por empleado
        update rabsarisapp.hours_detail
		set start_regular_time = if ( JSON_TYPE( JSON_EXTRACT(jsonData, CONCAT( '$[', i, '].start_regular_time'))) = 'NULL',NULL, CAST( JSON_UNQUOTE( JSON_EXTRACT(jsonData, CONCAT( '$[', i, '].start_regular_time'))) as Time) ), -- if (JSON_UNQUOTE( JSON_EXTRACT(jsonData, CONCAT( '$[', i, '].start_regular_time'))) = NULL, NULL, CAST( JSON_UNQUOTE( JSON_EXTRACT(jsonData, CONCAT( '$[', i, '].start_regular_time'))) as Time)),
			end_regular_time = if ( JSON_TYPE( JSON_EXTRACT(jsonData, CONCAT( '$[', i, '].end_regular_time'))) = 'NULL',NULL, CAST( JSON_UNQUOTE( JSON_EXTRACT(jsonData, CONCAT( '$[', i, '].end_regular_time'))) as Time) ),
			start_over_time = if ( JSON_TYPE( JSON_EXTRACT(jsonData, CONCAT( '$[', i, '].start_over_time'))) = 'NULL',NULL, CAST( JSON_UNQUOTE( JSON_EXTRACT(jsonData, CONCAT( '$[', i, '].start_over_time'))) as Time) ),
			end_over_time = if ( JSON_TYPE( JSON_EXTRACT(jsonData, CONCAT( '$[', i, '].end_over_time'))) = 'NULL',NULL, CAST( JSON_UNQUOTE( JSON_EXTRACT(jsonData, CONCAT( '$[', i, '].end_over_time'))) as Time) ),
			total_regular_time = JSON_EXTRACT(jsonData, CONCAT( '$[', i, '].total_regular_time')), -- pii_total_regular_time,
			total_over_time = JSON_EXTRACT(jsonData, CONCAT( '$[', i, '].total_over_time')) -- pii_total_over_time,
		where id = pid
        and id_hour = pid_hour
		and id_employee = pid_emp;
    
		set total_rows = ROW_COUNT();
        -- select total_rows;
		SET i = i + 1;
	END WHILE;
    
    -- Actualizamos la tabla maestra con el total de las horas
    update rabsarisapp.hours h, 
	   ( SELECT hd1.id_hour, SUM(hd1.TOTAL_REGULAR_TIME) as total
		 FROM rabsarisapp.hours_DETAIL hd1
		 group by hd1.id_hour
	   ) hd
	set h.total = hd.total
	where h.id = hd.id_hour
	and h.id > 0;
    
    -- Buscamos el total de horas
    -- select total into totalhours from hours where id = pid_hour;
    
    SELECT SUM(hd1.TOTAL_REGULAR_TIME) as total_regular_time, sum(hd1.total_over_time) as total_over_time
    INTO totalhours, totaloverhours
	FROM rabsarisapp.hours_DETAIL hd1
	where hd1.id_hour = pid_hour
	and hd1.id_employee = pid_emp
	group by hd1.id_employee;
    
    -- Actualizamos la Planilla de Empleados
    update payroll
    set totalhour = totalhours,
		totaloverhour = totaloverhours,
		netsalary = totalhours * salaryhour,
        socialsecuritytax = netsalary * 0.0975,
        educationalinsurancetax = netsalary * 0.0125,
        incometax = if ( ( ( netsalary - socialsecuritytax - educationalinsurancetax ) * 13 ) - 11000  < 0, 0, ( ( ( ( netsalary - socialsecuritytax - educationalinsurancetax ) * 13 ) ) - 11000 ) * 0.15),
        totaltaxes = socialsecuritytax + educationalinsurancetax + incometax,
        totalsalary = netsalary - socialsecuritytax - educationalinsurancetax - incometax
    where id_hour = pid_hour
    and id_emp = pid_emp;
    
    if total_rows > 0 then
		set pio_responsecode = 200;
        set pvo_message = 'Ok';
	else
		set pio_responsecode = 400;
        set pvo_message = 'No updated';
	end if;
END$$
DELIMITER ;
