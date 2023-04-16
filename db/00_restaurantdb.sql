# Create Database
CREATE DATABASE restaurantdb;

# Use Created Database
USE restaurantdb;

# STRONG ENTITIES

# Create Customer Table
CREATE TABLE Customers(
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(15),
    last_name VARCHAR(15),
    phone1 NUMERIC(10,0) UNIQUE,
    phone2 NUMERIC(10,0) UNIQUE,
    card_num NUMERIC(16,0) UNIQUE,
    cvv TEXT,
    expiration_date DATE,
    street VARCHAR(20)
    city VARCHAR(10),
    state VARCHAR(15),
    zip_code NUMERIC(5,0)
);

# Create Locations Table
CREATE TABLE Locations(
    location_id INT PRIMARY KEY,
    city VARCHAR(10),
    state VARCHAR(15),
    zip_code NUMERIC(5,0),
    phone NUMERIC(10,0) UNIQUE,
    hours TIME
);


# Create Employees Table
CREATE TABLE Employees(
    employee_id INT PRIMARY KEY,
    manager INT,
    phone1 NUMERIC(10,0) UNIQUE,
    phone2 NUMERIC(10, 0) UNIQUE,
    first_name VARCHAR(15),
    last_name VARCHAR(15),
    CONSTRAINT fk_manager FOREIGN KEY (manager)
        REFERENCES Employees(employee_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

# Create HireStatus Table
CREATE TABLE Employments(
    employee_id INT,
    location_id INT,
    hire_date DATE,
    fire_date DATE,
    wage INT,
    PRIMARY KEY (employee_id, location_id),
    CONSTRAINT fk_emp_id2 FOREIGN KEY (employee_id)
        REFERENCES Employees(employee_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_loc_id4 FOREIGN KEY(location_id)
        REFERENCES Locations(location_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

# Create Items Table
CREATE TABLE Items(
    item_id INT PRIMARY KEY,
    item_name VARCHAR(20),
    item_price NUMERIC(4,2),
    ingredients VARCHAR(50),
    availability BOOL
);

# Create Orders Table
CREATE TABLE Orders(
    order_id INT PRIMARY KEY,
    location_id INT,
    customer_id INT,
    employee_id INT,
    status INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    restrictions VARCHAR(30),
    CONSTRAINT fk_cust_id FOREIGN KEY(customer_id)
        REFERENCES Customers(customer_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_emp_id FOREIGN KEY(employee_id)
        REFERENCES Employees(employee_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_loc_id2 FOREIGN KEY (location_id)
        REFERENCES Locations(location_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

# Create Reservation Table
CREATE TABLE Reservations(
    reservation_id INT PRIMARY KEY,
    reservation_date DATETIME,
    party_size NUMERIC(2,0),
    customer_id INT,
    location_id INT,
    CONSTRAINT fk_cust_id2 FOREIGN KEY(customer_id)
        REFERENCES Customers(customer_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_loc_id3 FOREIGN KEY (location_id)
        REFERENCES Locations(location_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

# RELATIONSHIP ENTITY TABLES



# Create OrderItems Table
CREATE TABLE OrderItems(
    item_id INT,
    order_id INT,
    item_quantity INT,
    PRIMARY KEY (item_id, order_id),
    CONSTRAINT fk_item_id2 FOREIGN KEY (item_id)
        REFERENCES Items(item_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_order_id FOREIGN KEY(order_id)
        REFERENCES Orders(order_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

# WEAK ENTITIES

# Create Feedback Table
CREATE TABLE Feedback(
    feedback_id INT,
    customer_id INT,
    comments VARCHAR(50),
    rating INT,
    PRIMARY KEY (feedback_id),
    CONSTRAINT fk_cust_id3 FOREIGN KEY(customer_id)
        REFERENCES Customers(customer_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

# Create Schedule Table
CREATE TABLE Shifts(
    shift_id INT,
    employee_id INT,
    shift_start DATETIME DEFAULT CURRENT_TIMESTAMP,
    shift_end DATETIME DEFAULT CURRENT_TIMESTAMP
                  ON UPDATE CURRENT_TIMESTAMP,
    location_id INT,
    PRIMARY KEY (shift_id),
    CONSTRAINT fk_emp_id3 FOREIGN KEY(employee_id)
        REFERENCES Employees(employee_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_loc_id5 FOREIGN KEY (location_id)
        REFERENCES Locations(location_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

# INSERTIONS INTO DDL STATEMENTS

INSERT INTO Locations
VALUES (1, 'Buffalo', 'New York', 14201, 7322005454, 6);

INSERT INTO Locations
VALUES (2, 'Belmar', 'New Jersey', 07723, 7325450167, 8);


INSERT INTO Customers(customer_id, first_name, last_name, phone1, phone2, card_num, cvv, expiration_date, city, state, zip_code)
VALUES (1, 'Uzay', 'Takil', 7325005000, null, 451242147543, '023', '2022-05-22', '123 Jellyfish Ave', 'Holmdel', 'New Jersey', 07733);

INSERT INTO Customers
VALUES (2, 'Lionel', 'Messi', 7325005001, 7325005003, 452245144543, '024', '2022-06-22', '92 Fontenot Drive', 'Lexington', 'Kentucky', 54467);



INSERT INTO Feedback (customer_id, comments, rating, feedback_id)
VALUES (1, 'Food was terrible', 1, 9);

INSERT INTO Feedback (customer_id, comments, rating, feedback_id)
VALUES (2, 'Food was great!', 10, 10);


INSERT INTO Reservations(reservation_id, reservation_date, party_size, customer_id, location_id)
VALUES (5, '2022-05-22', 3, 1, 2);

INSERT INTO Reservations(reservation_id, reservation_date, party_size, customer_id, location_id)
VALUES (6, '2022-07-23', 2, 2, 1);



INSERT INTO Items(item_id, item_name, item_price, ingredients, availability)
VALUES (1, 'Burger', 11, 'Meat, Bun, Cheese', 1);

INSERT INTO Items(item_id, item_name, item_price, ingredients, availability)
VALUES (2, 'Fries', 4.50, 'Potatoes', 0);



INSERT INTO Employees(employee_id, manager, phone1, phone2, first_name, last_name)
VALUES (100, 100, 7325005000, null, 'John', 'Doe');

INSERT INTO Employees(employee_id, manager, phone1, phone2, first_name, last_name)
VALUES (506, 100, 9985456786, 7567000167, 'Pedro', 'Conti');



INSERT INTO Employments(employee_id, location_id, hire_date, fire_date, wage)
VALUES (100, 1, '2017-07-23', null, 20);

INSERT INTO Employments(employee_id, location_id, hire_date, fire_date, wage)
VALUES (506, 1, '2019-07-23', '2019-07-24', 12);


INSERT INTO Orders (order_id, location_id, customer_id, employee_id, status, order_date, restrictions)
VALUES (905, 1, 1, 506, 1, '2019-07-23', 'None');

INSERT INTO Orders (order_id, location_id, customer_id, employee_id, status, order_date, restrictions)
VALUES (906, 1, 1, 506, 0, '2019-07-23', 'Nut Allergy');



INSERT INTO OrderItems(item_id, order_id, item_quantity)
VALUES (1, 905, 2);

INSERT INTO OrderItems(item_id, order_id, item_quantity)
VALUES (2, 906, 1);



INSERT INTO Shifts(shift_id, shift_start, shift_end, location_id)
VALUES (505, '2023-4-07 12:00:00', '2023-4-07 17:00:00', 2);


INSERT INTO Shifts(shift_id, shift_start, shift_end, location_id)
VALUES (506, '2023-4-07 12:00:00', '2023-4-07 17:00:00', 1);