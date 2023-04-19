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

@managers.route('/revenue/start/<string:start>/end/<string:end>', methods=['GET'])
def get_total_revenue_overTime(start, end):
    query = """
    select SUM(OrderSum) as revenue from (select SUM(item_quantity * item_price) as OrderSum from Orders join OrderItems on Orders.order_id = OrderItems.order_id join Items I on OrderItems.item_id = I.item_id
    where order_date < '{end}' and order_date > '{start}'
    group by Orders.order_id) as OrderTotals
    """.format(start = start, end = end)
    
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

@managers.route('/revenue/location/<string:locationID>/start/<string:start>/end/<string:end>', methods=['GET'])
def get_revenue_for_location(locationID, start, end):

    query = """
    select SUM(OrderSum) as revenue from (select SUM(item_quantity * item_price) as OrderSum from Orders join OrderItems on Orders.order_id = OrderItems.order_id join Items I on OrderItems.item_id = I.item_id
    where location_id = {ID} and order_date < '{end}' and order_date > '{start}'
    group by Orders.order_id) as OrderTotals
    """
    query = query.format(ID = locationID, start = start, end = end)

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
            SET fire_date = CURRENT_DATE
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


@managers.route('/employments', methods=['GET'])
def get_employments():
    query = """
    select Employees.employee_id as 'Employee ID', first_name as 'First Name', last_name as 'Last Name', L.location_id as 'Location ID', hire_date as 'Hire Date',
    fire_date as 'Fire Date', wage, manager, phone1, phone2, city, state, zip_code from Employees
    LEFT OUTER join Employments E on Employees.employee_id = E.employee_id
    LEFT OUTER join Locations L on E.location_id = L.location_id;
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

@managers.route('/employments', methods=['POST'])
def assign_job():

    req_data = request.get_json()

    employee_id = req_data['employee_id']
    location_id = req_data['location_id']
    wage = req_data['wage']

    query = """
    INSERT INTO Employments (employee_id, location_id, hire_date, fire_date, wage)
    VALUES ({employee}, {location}, CURRENT_DATE, null, {wage})
    """.format(employee = employee_id, location = location_id, wage = wage)

    #execute the query
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    query = """
    INSERT INTO Shifts (employee_id, location_id)
    VALUES ({employee}, {location});
    """.format(employee = employee_id, location = location_id)

    cursor.execute(query)
    db.get_db().commit()

    return "Employee {employee} Employed at Location: {location}".format(employee = employee_id, location = location_id)


@managers.route('/customers', methods=['GET'])
def get_customers():
    query = """
    select customer_id, first_name, last_name, phone1, phone2,\
     street, city, state, zip_code from Customers
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


@managers.route('/orders/location/<string:locationID>', methods=['GET'])
def get_orders_for_location(locationID):
    start_date = request.args.get('startDate')
    end_date = request.args.get('endDate')
    query = """
    select order_id, customer_id, employee_id, status,\
     order_date, restrictions from Orders
    where location_id = {ID}
    """
    if start_date and end_date:
        query += f"and order_date BETWEEN '{start_date}' AND '{end_date}'"
    query = query.format(ID=locationID)
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


@managers.route('/orders/employee/<string:employeeID>', methods=['GET'])
def get_orders_for_employee(employeeID):
    start_date = request.args.get('startDate')
    end_date = request.args.get('endDate')
    query = """
    select order_id, customer_id, employee_id, status,\
     order_date, restrictions from Orders
    where employee_id = {ID}
    """
    if start_date and end_date:
        query += f"and order_date BETWEEN '{start_date}' AND '{end_date}'"
    query = query.format(ID=employeeID)
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


@managers.route('/items', methods=['POST'])
def add_menu_item():
    data = request.get_json()

    if not data or 'item_name' not in data or 'item_price' not in data \
            or 'ingredients' not in data or 'availability' not in data:
        return make_response(jsonify({'error': 'Invalid request body'}), 400)

    item_name = data['item_name']
    item_price = data['item_price']
    ingredients = data['ingredients']
    availability = data['availability']

    query = """
    INSERT INTO Items (item_name, item_price, ingredients, availability)
    VALUES ('{name}', {price}, '{ingredients}', {availability})
    """.format(name=item_name, price=item_price, ingredients=ingredients, availability=availability)
    
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return make_response(jsonify({'message': 'Item added'}), 201)


@managers.route('/items/<string:itemID>', methods=['PUT'])
def update_menu_item(itemID):
    data = request.get_json()

    if not data or 'item_name' not in data or 'item_price' not in data \
            or 'ingredients' not in data or 'availability' not in data:
        return make_response(jsonify({'error': 'Invalid request body'}), 400)

    item_name = data['item_name']
    item_price = data['item_price']
    ingredients = data['ingredients']
    availability = data['availability']

    query = """
    UPDATE Items
    SET item_name = '{name}', item_price = {price}, ingredients = '{ingredients}', availability = {availability}
    WHERE item_id = {ID}
    """.format(name=item_name, price=item_price, ingredients=ingredients, availability=availability, ID=itemID)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return make_response(jsonify({'message': 'Item updated'}), 200)

@managers.route('/items/<string:itemID>/orders', methods=['GET'])
def num_orders_for_item(itemID):
    query = """
    SELECT SUM(item_quantity) FROM Orders JOIN OrderItems ON Orders.order_id = OrderItems.order_id
    WHERE item_id = {ID}
    """
    query = query.format(ID=itemID)
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

