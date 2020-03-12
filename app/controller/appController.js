'use strict';

var Employee = require('../model/appModel.js');

let jsondata = {
    "responsecode": null,
    "message": null,
    "data": null,
    "error": null
};

// List all Employees
exports.list_employees = (req, res) => {
    Employee.getAllEmployee((err, employee) => {
        console.log('controller');

        if (err)
            jsondata.error = err;

        console.log('res', employee);

        jsondata.responsecode = employee[2][0].responsecode;
        jsondata.message = employee[2][0].message;

        if (employee[0] == null) {
            jsondata.data = null;
        } else {
            jsondata.data = employee[0];
        }
        res.json(jsondata);
    });
};

// List Employees Actives
exports.list_employees_hours = (req, res) => {
    Employee.getEmployeeHoursById(req.body.id, (err, employee) => {
        console.log('controller: ' + req.body.id);

        if (err)
            jsondata.error = err;

        console.log('res', employee);

        jsondata.responsecode = employee[2][0].responsecode;
        jsondata.message = employee[2][0].message;

        if (employee[0] == null) {
            jsondata.data = null;
        } else {
            jsondata.data = employee[0];
        }
        res.json(jsondata);
    });
};

// List Employees Actives
exports.list_employees_hours_details = (req, res) => {
    Employee.getEmployeeHoursDetailsById(req.body, (err, employee) => {
        console.log('controller: ' + req.body);

        if (err)
            jsondata.error = err;

        console.log('res', employee);

        jsondata.responsecode = employee[2][0].responsecode;
        jsondata.message = employee[2][0].message;

        if (employee[0] == null) {
            jsondata.data = null;
        } else {
            jsondata.data = employee[0];
        }
        res.json(jsondata);
    });
};

// List a Employee by id
exports.list_employee_by_id = (req, res) => {
    Employee.getEmployeeById(req.body.id, (err, employee) => {

        if (err) {
            jsondata.error = err;
        }

        jsondata.responsecode = employee[2][0].responsecode;
        jsondata.message = employee[2][0].message;

        if (employee[0][0] == null) {
            jsondata.data = null;
        } else {
            jsondata.data = employee[0][0];
        }
        res.json(jsondata);
    });
};

// Add Employee
exports.add_employee = (req, res) => {
    Employee.postCreateEmployee(req.body, (err, employee) => {
        console.log('controller');

        if (err)
            jsondata.error = err;

        console.log('res', employee);

        jsondata.responsecode = employee[2][0].responsecode;
        jsondata.message = employee[2][0].message;

        if (employee == null) {
            jsondata.data = null;
        } else {
            jsondata.data = { id: employee[0][0].id };
        }
        res.json(jsondata);
    });
};

// Delete Employee
exports.delete_employee_by_id = (req, res) => {
    Employee.deleteEmployeeById(req.params.id, (err, employee) => {
        console.log('controller');

        if (err)
            res.send(err);

        //res.send(employee);
        res.json(req.params.id);
    });
};

// Update Employee by id
exports.update_employee = (req, res) => {
    Employee.putUpdateEmployee(req.body, (err, employee) => {
        console.log('controller');

        if (err) {
            jsondata.error = err;
        }
        console.log('res: ', employee);

        jsondata.responsecode = employee[2][0].responsecode;
        jsondata.message = employee[2][0].message;

        if (employee === null) {
            jsondata.data = null;
        } else {
            jsondata.data = { id: employee[2][0].id };
        }

        //res.send(employee);
        res.json(jsondata);
    });
};

// Add Hour
exports.add_hour = (req, res) => {
    console.log(req.body);
    Employee.postCreateHour(req.body, (err, employee) => {
        console.log('controller');

        if (err)
            jsondata.error = err;

        console.log('res', employee);

        jsondata.responsecode = employee[2][0].responsecode;
        jsondata.message = employee[2][0].message;

        if (employee == null) {
            jsondata.data = null;
        } else {
            jsondata.data = { id: employee[0][0].id };
        }
        res.json(jsondata);
    });
};

// Delete Hour Employee
exports.delete_hour_by_id = (req, res) => {
    Employee.deleteHourById(req.params.id, (err, employee) => {
        console.log('controller');

        if (err)
            jsondata.error = err;
        //res.send(err);

        console.log('res', employee[2][0]);

        jsondata.responsecode = employee[2][0].responsecode;
        jsondata.message = employee[2][0].message;

        if (employee[0] == null) {
            jsondata.data = null;
        } else {
            jsondata.data = employee[2][0].id;
        }
        res.json(jsondata);
    });
};

// List all Hours
exports.list_hours = (req, res) => {
    Employee.getAllHour((err, employee) => {
        console.log('controller');

        if (err)
            jsondata.error = err;
        console.log('res', employee);

        jsondata.responsecode = employee[2][0].responsecode;
        jsondata.message = employee[2][0].message;

        if (employee[0] == null) {
            jsondata.data = null;
        } else {
            jsondata.data = employee[0];
        }
        res.json(jsondata);
    });
};

// Update Hours Details Employee
exports.update_hours_details_employee = (req, res) => {
    Employee.putUpdateHoursDetails(req.body, (err, employee) => {
        console.log('controller');

        if (err) {
            jsondata.error = err;
        }
        console.log('res: ', employee);

        jsondata.responsecode = employee[2][0].responsecode;
        jsondata.message = employee[2][0].message;

        /*if (employee === null) {
            jsondata.data = null;
        } else {
            jsondata.data = {
                id_hour: employee[2][0].id_hour,
                id_emp: employee[2][0].id_emp
            };
        }*/

        jsondata.data = null;

        //res.send(employee);
        res.json(jsondata);
    });
};

// List all Clubs
exports.list_clubs = (req, res) => {
    Employee.getAllClub((err, employee) => {
        console.log('controller');

        if (err)
            jsondata.error = err;
        console.log('res', employee);

        jsondata.responsecode = employee[2][0].responsecode;
        jsondata.message = employee[2][0].message;

        if (employee[0] == null) {
            jsondata.data = null;
        } else {
            jsondata.data = employee[0];
        }
        res.json(jsondata);
    });
};

// Update Employee by id
exports.update_club = (req, res) => {
    console.log("Req.body --> ");
    console.log(req.body);
    Employee.putUpdateClub(req.body, (err, employee) => {
        console.log('controller');

        if (err) {
            jsondata.error = err;
        }
        console.log('res: ', employee);

        jsondata.responsecode = employee[2][0].responsecode;
        jsondata.message = employee[2][0].message;

        if (employee === null) {
            jsondata.data = null;
        } else {
            jsondata.data = { id: employee[2][0].id };
        }

        //res.send(employee);
        res.json(jsondata);
    });
};