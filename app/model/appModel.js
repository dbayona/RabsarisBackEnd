'use strict';

var sql = require('./db.js');

//Employee object constructor
var Employee = function(employee) {
    this.firstname = employee.firstName;
    this.lastname = employee.lastName;
    this.identification = employee.identification;
    this.birthday = new Date();
    this.genre = employee.genre;
    this.ocupation = employee.ocupation;
    this.rate = employee.rate;
    this.active = employee.active;
    this.club = employee.club;
};

//Listar todos los empleados
Employee.getAllEmployee = (result) => {
    let sp_query = `CALL allEmployees(@responsecode, @message); select @responsecode as responsecode, @message as message`;
    sql.query(sp_query, true, (err, res, fields) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
        } else {
            // console.log("Get All Employees: ", res);
            result(null, res);
        }
    });
};

//Listar las horas de los empleados
Employee.getEmployeeHoursById = (id, result) => {
    let sp_query = `CALL employeesHours(?, @responsecode, @message); select @responsecode as responsecode, @message as message`;
    sql.query(sp_query, [id], (err, res, fields) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
        } else {
            console.log("Get Employee id: ", res);
            result(null, res);
        }
    });
};

//Listar el detalle de las horas de los empleados
Employee.getEmployeeHoursDetailsById = (data, result) => {
    let sp_query = `CALL employeesHoursDetails(?, ?, @responsecode, @message); select @responsecode as responsecode, @message as message`;
    sql.query(sp_query, [data.id_hour, data.id_emp], (err, res, fields) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
        } else {
            console.log("Get Employee id: ", data);
            result(null, res);
        }
    });
};

//Listar un empleado por su id unico de la tabla
Employee.getEmployeeById = (id, result) => {
    let sp_query = `CALL readEmployee(?, @responsecode, @message); select @responsecode as responsecode, @message as message`;
    sql.query(sp_query, [id], (err, res, fields) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
        } else {
            console.log("Get Employee id: " + id);
            result(null, res);
        }
    });
};

//Crear un empleado
Employee.postCreateEmployee = (data, result) => {
    let sp_query = `CALL createEmployee(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, @responsecode, @message); select @responsecode as responsecode, @message as message`;
    sql.query(sp_query, [data.firstname, data.lastname, data.identification, data.birthday, data.genre, data.ocupation, data.active, data.rate, data.club, data.term], (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
        } else {
            console.log("Create Employee" + res);
            result(null, res);
        }
    });
};

//Borrar un empleado por su id unico de la tabla
Employee.deleteEmployeeById = (id, result) => {
    let sp_query = `CALL deleteEmployee(?)`;
    sql.query(sp_query, [id], (err, res, fields) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
        } else {
            console.log("Delete Employee id: " + id);
            result(null, id);
        }
    });
};

// Actualizar un empleado
Employee.putUpdateEmployee = (data, result) => {
    let sp_query = `SET @id = ?; CALL updateEmployee(@id, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, @responsecode, @message); select @id as id, @responsecode as responsecode, @message as message`;
    sql.query(sp_query, [data.id, data.firstname, data.lastname, data.identification, data.birthday, data.genre, data.ocupation, data.active, data.rate, data.club, data.term], (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
        } else {
            console.log("Update Employee: " + res);
            result(null, res);
        }
    });
};

//Crear Registro de Horas
Employee.postCreateHour = (data, result) => {
    let sp_query = `CALL createHour(?, ?, @responsecode, @message); select @responsecode as responsecode, @message as message`;
    sql.query(sp_query, [data.startdate, data.enddate], (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
        } else {
            console.log("Create Hour" + res);
            result(null, res);
        }
    });
};

//Borrar un empleado por su id unico de la tabla
Employee.deleteHourById = (id, result) => {
    let sp_query = `SET @id = ?; CALL deleteHour(@id, @responsecode, @message); select @id as id, @responsecode as responsecode, @message as message`;
    sql.query(sp_query, [id], (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
        } else {
            console.log("Delete Employee id: " + id);
            result(null, res);
        }
    });
};

//Listar todos las horas trabajadas de los empleados
Employee.getAllHour = (result) => {
    let sp_query = `CALL allHours(@responsecode, @message); select @responsecode as responsecode, @message as message`;
    sql.query(sp_query, true, (err, res, fields) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
        } else {
            console.log("Get All Hours: ", res);
            result(null, res);
        }
    });
};

// Actualizar las horas trabajadas de empleado
Employee.putUpdateHoursDetails = (data, result) => {
    // console.log('appModel - putUpdateHoursDetails');
    // console.log(JSON.stringify(data));
    let sp_query = `SET @data = ?; CALL updateHoursDetailsJSON(@data, @responsecode, @message); select @responsecode as responsecode, @message as message`;
    sql.query(sp_query, [JSON.stringify(data)], (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
        } else {
            console.log("Update Hours Details Employee: " + res);
            result(null, res);
        }
    });
};

//Listar todos los empleados
Employee.getAllClub = (result) => {
    let sp_query = `CALL allClub(@responsecode, @message); select @responsecode as responsecode, @message as message`;
    sql.query(sp_query, true, (err, res, fields) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
        } else {
            console.log("Get All Clubs: ", res);
            result(null, res);
        }
    });
};

// Actualizar el Club de un Empleado
Employee.putUpdateClub = (data, result) => {
    console.log("putUpdateClub");
    console.log(data.id);
    let sp_query = `SET @id = ?; CALL updateClub(@id, ?, ?, ?, @responsecode, @message); select @id as id, @responsecode as responsecode, @message as message`;
    sql.query(sp_query, [data.id, data.start_date, data.end_date, data.monthly_fee], (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
        } else {
            console.log("Update Club: " + res);
            result(null, res);
        }
    });
};

module.exports = Employee;