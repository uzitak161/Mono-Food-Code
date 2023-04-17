from flask import Blueprint, request, jsonify, make_response
import json
from src import db


managers = Blueprint('managers', __name__)

@managers.route('/revenue', methods=['GET'])
def get_total_revenue():
    query = """
    select SUM(OrderSum) from (select SUM(item_quantity * item_price) as OrderSum from Orders join OrderItems on Orders.order_id = OrderItems.order_id join Items I on OrderItems.item_id = I.item_id
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
    select SUM(OrderSum) from (select SUM(item_quantity * item_price) as OrderSum from Orders join OrderItems on Orders.order_id = OrderItems.order_id join Items I on OrderItems.item_id = I.item_id
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
    select SUM(OrderSum) from (select SUM(item_quantity * item_price) as OrderSum from Orders join OrderItems on Orders.order_id = OrderItems.order_id join Items I on OrderItems.item_id = I.item_id
    where location_id = {ID}
    group by Orders.order_id) as OrderTotals
    """
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
