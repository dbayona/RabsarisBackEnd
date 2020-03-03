'use strict';

module.exports = (app) => {
    var action = require('../controller/appController');

    //List all employees
    app.route('/employees/all').get(action.list_employees);

    //List employees hours
    app.route('/employees/hours').post(action.list_employees_hours);

    //List employees hours details
    app.route('/employees/hours/details').post(action.list_employees_hours_details);

    //List a employee by id
    app.route('/employees/read').post(action.list_employee_by_id);

    //Update a employee by id
    app.route('/employees/update/').put(action.update_employee);

    //Add employee
    app.route('/employees/create').post(action.add_employee);

    //Delete a employee by id
    app.route('/employees/delete/:id').get(action.delete_employee_by_id);

    //Add hour
    app.route('/hours/create').post(action.add_hour);

    //Delete Hour by id
    app.route('/hours/delete/:id').get(action.delete_hour_by_id);

    //List all hours
    app.route('/hours/all').get(action.list_hours);

    //List all clubs
    app.route('/clubs/all').get(action.list_clubs);

    //Update a club by id
    app.route('/clubs/update/').put(action.update_club);
};