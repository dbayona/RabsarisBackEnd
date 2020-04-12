DELIMITER $$
DROP PROCEDURE IF EXISTS createHour;
CREATE DEFINER=`root`@`localhost` PROCEDURE `createHour`(in pid_startdate date, in pid_enddate date, out pio_responsecode integer, out pvo_message varchar(100))
BEGIN

DECLARE last_id, total_rows, hour_id, id_employee INT;
DECLARE vrate decimal(10, 2);
DECLARE currentDate date;

-- CURSOR DE CLIENTES ACTIVOS
DECLARE employees_cursor cursor for
SELECT id, rate FROM employees WHERE ACTIVE = 1;

-- Declaracion de un manejador de error tipo NOT FOUND
DECLARE CONTINUE HANDLER FOR NOT FOUND SET @hecho = TRUE;

INSERT INTO hours (startdate, enddate) 
values (pid_startdate, pid_enddate);

set last_id = LAST_INSERT_ID();

-- ABRIMOS EL CURSOR
OPEN employees_cursor;

-- CICLO DE LECTURA
ciclo: LOOP

	-- Seteamos la fecha inicial
	set currentDate = pid_startdate;

	-- Obtenemos la primera fila en la variables correspondientes
	FETCH employees_cursor INTO id_employee, vrate;

	-- Si el cursor se quedo sin elementos, entonces nos salimos del bucle
	IF @hecho THEN
		-- SELECT 'Record Finished' + ID_EMPLOYEE;
		LEAVE ciclo;
	END IF;
    
    -- Planilla de los empleados
	insert into payroll (id_hour, id_emp, salaryhour) values (last_id, id_employee, vrate);
    
    REPEAT
		-- Detalle de las horas
		insert into hours_detail (id_hour, id_employee, id_date) values(last_id, id_employee, currentDate);
		
        set currentDate = Date_Add(currentDate, Interval 1 day);

	UNTIL currentDate > pid_enddate END REPEAT;

end loop ciclo;

-- Cerramos el cursor
CLOSE employees_cursor;

-- Reiniciamos el control del cursor para que no salga prematuramente
SET @hecho = FALSE;

select * from hours where id = last_id;

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
