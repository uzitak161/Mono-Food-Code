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
    return "Success"

@managers.route('/employee', methods=['POST'])
def create_employee():

    req_data = request.get_json()
    current_app.logger.info(req_data)


    # TODO: take in correct values for employee info

    prod_name = req_data['product_name']
    prod_description = req_data['product_description']
    prod_price = req_data['product_listprice']

    insert_stmt = 'INSERT INTO Employees (product_name, description, list_price) VALUES ("'
    insert_stmt += prod_name + '", "' + prod_description + '", ' + str(prod_price) + ')'

    current_app.logger.info(insert_stmt)

    #execute the query
    cursor = db.get_db().cursor()
    cursor.execute(insert_stmt)
    db.get_db().commit()
    return "Success"