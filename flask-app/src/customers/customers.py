from flask import Blueprint, request, jsonify, make_response
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
    try:
        phone2 = data['phone2']
    except:
        phone2 = None
    card = data['card']
    cvv = data['cvv']
    expiration = data['expiration']
    street = data['street']
    city = data['city']
    state = data['state']
    zip_code = data['zip_code']
    
    query = f'''
    insert into customers
    (first_name, last_name, phone1, phone2, card_num, cvv, expiration_date, street, city, state, zip_code)
    values ({first}, {last}, {phone1}, {phone2}, {card}, {cvv}, {expiration}, {street}, {city}, {state}, {zip_code})
    '''

    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return f'Successfully registered customer {first} {last}!'

# get a profile
@customers.route('/<customerID>', methods=['GET'])
def get_profile(customerID):
    query = f'''
    select customer_id, first_name, last_name, phone1, phone2,\
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
    card = data['card']
    cvv = data['cvv']
    expiration = data['expiration']
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
@customers.route('/orders/<customerID>', methods=['POST'])
def place_order(customerID):
    data = request.json()
    item_ids = data['items']
    employee = data['employee_id']
    location = data['location_id']
    restrictions = data['restrictions']

    query1 = f'''
    insert into orders
    (location_id, customer_id, employee_id, status, restrictions)
    values({location}, {customerID}, {employee}, 0, {restrictions})
    '''

    cursor = db.get_db().cursor()
    cursor.execute(query1)

    query2= 'insert into orderitems (item_id, order_id, item_quantity)'

    

    for item in item_ids:
        query2 += f'values({item}, {cursor.lastrowid}, {qty})'
    

    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

