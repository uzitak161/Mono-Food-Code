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

@managers.route('/revenue/<string:employeeID>', methods=['GET'])
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

