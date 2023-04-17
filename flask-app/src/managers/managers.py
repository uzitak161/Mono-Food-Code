from flask import Blueprint, request, jsonify, make_response
import json
from src import db


managers = Blueprint('managers', __name__)

@managers.route('/revenue', methods=['GET'])
def get_total_revenue():
    query = """
    select SUM(OrderSum) as revenue from (select SUM(item_quantity * item_price) as OrderSum from Orders join OrderItems on Orders.order_id = OrderItems.order_id join Items I on OrderItems.item_id = I.item_id
    group by Orders.order_id) as OrderTotals
    """
    cursor = db.get_db().cursor()
    cursor.execute(query)
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

@managers.route('/revenue/employee/<string:employeeID>', methods=['GET'])
def get_revenue_for_employee(employeeID):
    query = """
    select SUM(OrderSum) as revenue from (select SUM(item_quantity * item_price) as OrderSum from Orders join OrderItems on Orders.order_id = OrderItems.order_id join Items I on OrderItems.item_id = I.item_id
    where employee_id = {ID}
    group by Orders.order_id) as OrderTotals
    """
    query = query.format(ID = employeeID)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

@managers.route('/revenue/location/<string:locationID>', methods=['GET'])
def get_revenue_for_location(locationID):



    query = """
    select SUM(OrderSum) as revenue from (select SUM(item_quantity * item_price) as OrderSum from Orders join OrderItems on Orders.order_id = OrderItems.order_id join Items I on OrderItems.item_id = I.item_id
    where location_id = {ID}
    group by Orders.order_id) as OrderTotals
    """
    query = query.format(ID = locationID)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# This is not a hard deletion, we do not want to completely get rid of employee work history so we simply update the fire_date column in the Employments table
@managers.route('/employee', methods=['DELETE'])
def delete_employee():

    req_data = request.get_json()

    if not req_data or 'employee_id' not in req_data or 'location_id' not in req_data:
        return make_response(jsonify({'error': 'Invalid request body, must include employee_id and location_id'}), 400)

    employee_id = req_data['employee_id']
    location_id = req_data['location_id']
    fire_date = req_data.get('fire_date', None)


    query = None

    if (not fire_date):
        query = """
            UPDATE Employments
            SET fire_date = DATE_FORMAT(fire_date , CURRENT_DATE)
            where location_id = {locID} and employee_id = {employeeID};
            """
        query = query.format(locID = location_id, employeeID = employee_id)
    else: 
        query = """
            UPDATE Employments
            SET fire_date = DATE_FORMAT(fire_date ,'{date}')
            where location_id = {locID} and employee_id = {employeeID};
            """
        query = query.format(date = fire_date, locID = location_id, employeeID = employee_id)
        
    

    #execute the query
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return "Employee set as fired"

# This adds the employee to the DB, the employee is not associated with a location or 'Employment' until they are added via a schedule. So while they may be added to
# the employee table they are not considered hired. 
@managers.route('/employee', methods=['POST'])
def create_employee():

    req_data = request.get_json()


    if not req_data or 'manager_id' not in req_data or 'phone1' not in req_data \
        or 'first_name' not in req_data or 'last_name' not in req_data:
        return make_response(jsonify({'error': 'Invalid request body, must include manager_id, phone1, and name'}), 400)


    manager_id = req_data['manager_id']
    phone1 = req_data['phone1']
    first_name = req_data['first_name']
    last_name = req_data['last_name']


    if 'phone2' not in req_data:
        insert_stmt = """
        INSERT INTO Employees(manager, phone1, first_name, last_name)
        VALUES ({manager}, {p1}, '{fName}', '{lName}');
        """
        insert_stmt = insert_stmt.format(manager = manager_id, p1 = phone1, fName = first_name, lName = last_name)

    else:
        phone2 = req_data['phone2']

        insert_stmt = """
        INSERT INTO Employees(manager, phone1, phone2, first_name, last_name)
        VALUES ({manager}, {p1}, {p2}, '{fName}', '{lName}');
        """
        insert_stmt = insert_stmt.format(manager = manager_id, p1 = phone1, p2 = phone2, fName = first_name, lName = last_name)

    #execute the query
    cursor = db.get_db().cursor()
    cursor.execute(insert_stmt)
    db.get_db().commit()
    return "Employee {fName} {lName} Added".format(fName = first_name, lName = last_name)

# Changed route from /locations<string:locationId>/schedule/<string:employeeId> to /schedule


@managers.route('/schedule', methods=['PUT'])
def update_schedule():
    data = request.get_json()

    if not data or 'start_time' not in data or 'end_time' not in data \
        or 'location_id' not in data or 'employee_id' not in data:
        return make_response(jsonify({'error': 'must include employee, location, and times'}), 400)
    
    start_time = data['start_time']
    end_time = data['end_time']
    locationID = data['location_id']
    employeeID = data['employee_id']

    query = """
    INSERT INTO Shifts (employee_id, shift_start, shift_end, location_id)
    VALUES ({employeeId}, '{startTime}', '{endTime}', {locID});
    """.format(employeeId = employeeID, startTime = start_time, endTime = end_time, locID = locationID)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    deletion_query = """
    DELETE FROM Shifts where
                       employee_id = {employeeId} and location_id = {locID} and shift_start > '{startTime}' and shift_end < '{endTime}';
    """.format(employeeId = employeeID, startTime = start_time, endTime = end_time, locID = locationID)

    cursor = db.get_db().cursor()
    cursor.execute(deletion_query)
    db.get_db().commit()

    return "Added Shift for employee {employee} from {start} to {finish}".format(employee = employeeID, start = start_time, finish = end_time)