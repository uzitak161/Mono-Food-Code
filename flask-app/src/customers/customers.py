from flask import Blueprint, request, jsonify, make_response, current_app
import datetime
import json
from src import db


customers = Blueprint('customers', __name__)

# register yourself as a new customer
@customers.route('/', methods=['POST'])
def signup():
    data = request.json

    first = data['first']
    last = data['last']
    phone1 = data['phone1']
    phone2 = data.get('phone2', 'NULL')
    card = data['card']
    cvv = data['cvv']
    expiration = data['expiration']
    street = data['street']
    city = data['city']
    state = data['state']
    zip_code = data['zip_code']
    
    query = f'''
    insert into Customers
    (first_name, last_name, phone1, phone2, card_num, cvv, expiration_date, street, city, state, zip_code)
    values ('{first}', '{last}', '{phone1}', {phone2}, '{card}', '{cvv}', '{expiration}', '{street}', '{city}', '{state}', '{zip_code}')
    '''
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    customer_id = cursor.lastrowid

    response = make_response(f'Successfully registered customer {first} {last}! Customer ID: {customer_id}')
    response.status_code = 200
    return response

# get a profile
@customers.route('/<customerID>', methods=['GET'])
def get_profile(customerID):
    query = f'''
    select customer_id, first_name, last_name, phone1, phone2,\
     card_num, cvv, expiration_date,\
     street, city, state, zip_code from Customers
    where customer_id = {customerID}
    '''

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

# update your profile
@customers.route('/<customerID>', methods=['PUT'])
def update_profile(customerID):
    data = request.json

    first = data['first_name']
    last = data['last_name']
    phone1 = data['phone1']
    try:
        phone2 = data['phone2']
    except:
        phone2 = None
    card = data['card_num']
    cvv = data['cvv']
    expiration = data['expiration_date']
    street = data['street']
    city = data['city']
    state = data['state']
    zip_code = data['zip_code']
    
    query = f'''
    update Customers
    set first_name = '{first}', last_name = '{last}', phone1 = '{phone1}', phone2 = '{phone2}', card_num = '{card}', cvv = '{cvv}',\
     expiration_date = '{expiration}', street = '{street}', city = '{city}', state = '{state}', zip_code = '{zip_code}'
    where customer_id = '{customerID}'
    '''

    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return f'Successfully updated profile for customer {customerID}!'

# place an order
@customers.route('/orders/<int:customerID>', methods=['POST'])
def place_order(customerID):
    data = request.json
    items = data['items']
    if not items:
        response = make_response('Bad request: order must contain items')
        response.status_code = 400
        return response
    employee = data.get('employee_id', 1)
    location = data['location_id']
    try:
        restrictions = data['restrictions']
    except:
        restrictions = ''
    query1 = f'''
    insert into Orders
    (location_id, customer_id, employee_id, status, restrictions)
    values({location}, {customerID}, {employee}, 0, '{restrictions}')
    '''
    current_app.logger.info(query1)
    cursor = db.get_db().cursor()
    cursor.execute(query1)
    order_id = cursor.lastrowid
    query2 = 'insert into OrderItems (item_id, order_id, item_quantity) values '
    for item in items:    
        id = item['id']
        qty = item['qty']
        query2 += f'({id}, {order_id}, {qty}),'
    query2 = query2[:-1] + ';'
    current_app.logger.info(query2)
    cursor.execute(query2)
    db.get_db().commit()
    response = make_response(f'Successfully placed order. Order ID: {order_id}')
    response.status_code = 200
    return response

# delete an order
@customers.route('orders/<int:orderID>', methods=['DELETE'])
def del_order(orderID):
    query = f'delete from Orders where order_id = {orderID}'
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    rows_affected = cursor.rowcount
    if rows_affected:
        response = make_response(f'Successfully deleted order {orderID}')
        response.status_code = 204
    else:
        response = make_response(f'Could not find order {orderID}')
        response.status_code = 404
    return response

# leave a review
@customers.route('/feedback/<int:customerID>', methods=['POST'])
def leave_review(customerID):
    data = request.json
    rating = data['rating']
    comments = data['comments']
    if rating not in range(1,6):
        response = make_response('Bad request: rating must be between 1 and 5 stars')
        response.status_code = 400
        return response
    query = f'''
    insert into Feedback (customer_id, comments, rating)
    values ({customerID}, '{comments}', {rating})
    '''
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    feedback_id = cursor.lastrowid
    response = make_response(f'Successfully left review. Feedback ID: {feedback_id}')
    response.status_code = 201
    return response

# make a reservation
@customers.route('/reservations/<int:customerID>', methods=['POST'])
def make_res(customerID):
    data = request.json
    dt = data['datetime']
    try:
        dt = datetime.datetime.strptime(dt, "%Y-%m-%d %H:%M:%S")
    except:
        response = make_response('Bad request: invalid date/time')
        response.status_code = 400
        return response
    party_size = data['party_size']
    location_id = data['location_id']
    query = f'''
    insert into Reservations (reservation_date, party_size, location_id, customer_id)
    values ('{dt}', {party_size}, {location_id}, {customerID})
    '''
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    res_id = cursor.lastrowid
    response = make_response(f'Successfully made reservation. Reservation ID: {res_id}')
    response.status_code = 201
    return response

# get order history
@customers.route('/orders/<int:customerID>')
def get_order_history(customerID):
    query = f'''
    select l.city, l.zip_code, o.order_id, l.location_id, o.customer_id, o.employee_id, o.status, o.order_date, o.restrictions
    from Orders o join Locations l on o.location_id = l.location_id
    where o.customer_id = {customerID};
    '''
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

# get available items
@customers.route('/items')
def get_avail_items():
    query = 'select item_id, item_name, item_price, ingredients from Items where availability = 1;'
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

# get location info
@customers.route('/locations/<int:locationID>')
def get_location_info(locationID):
    query = f'''
    select location_id, city, state, zip_code, phone, opening, closing
    from Locations
    where location_id = {locationID}
    '''
    cursor = db.get_db().cursor()
    cursor.execute(query)
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(json.dumps(json_data, default=str))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# get locations
@customers.route('/locations')
def get_locations():
    query = f'''
    select location_id, city, state, zip_code, phone, opening, closing
    from Locations
    '''
    cursor = db.get_db().cursor()
    cursor.execute(query)
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(json.dumps(json_data, default=str))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response