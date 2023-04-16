# Create Database
CREATE DATABASE restaurantdb;

# Use Created Database
USE restaurantdb;

# STRONG ENTITIES

# Create Customer Table
CREATE TABLE Customers(
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(15),
    last_name VARCHAR(15),
    phone1 NUMERIC(10,0) UNIQUE,
    phone2 NUMERIC(10,0) UNIQUE,
    card_num NUMERIC(16,0) UNIQUE,
    cvv TEXT,
    expiration_date DATE,
    street VARCHAR(20),
    city VARCHAR(20),
    state VARCHAR(20),
    zip_code NUMERIC(5,0)
);

# Create Locations Table
CREATE TABLE Locations(
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    city VARCHAR(10),
    state VARCHAR(15),
    zip_code NUMERIC(5,0),
    phone NUMERIC(10,0) UNIQUE,
    opening TIME,
    closing TIME
);


# Create Employees Table
CREATE TABLE Employees(
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    manager INT,
    phone1 NUMERIC(10,0) UNIQUE,
    phone2 NUMERIC(10, 0) UNIQUE,
    first_name VARCHAR(15),
    last_name VARCHAR(15),
    CONSTRAINT fk_manager FOREIGN KEY (manager)
        REFERENCES Employees(employee_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

# Create Employments Table
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
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    item_name VARCHAR(20),
    item_price NUMERIC(4,2),
    ingredients VARCHAR(50),
    availability BOOL
);

# Create Orders Table
CREATE TABLE Orders(
    order_id INT PRIMARY KEY AUTO_INCREMENT,
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
    reservation_id INT PRIMARY KEY AUTO_INCREMENT,
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
    feedback_id INT AUTO_INCREMENT,
    customer_id INT,
    comments VARCHAR(50),
    rating INT,
    PRIMARY KEY (feedback_id),
    CONSTRAINT fk_cust_id3 FOREIGN KEY(customer_id)
        REFERENCES Customers(customer_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

# Create Shifts Table
CREATE TABLE Shifts(
    shift_id INT AUTO_INCREMENT,
    employee_id INT,
    shift_start TIME,
    shift_end TIME,
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

# CUSTOMERS TABLE
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Merrill','Scranny','508-881-9511','302-856-0629',3.74288E+14,4930,'1/31/2023','085 Carpenter Plaza','Worcester','MA',1654);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Matty','Lippitt','339-742-9986','317-334-4894',6.3965E+15,1537,'12/14/2022','40390 Brown Alley','Woburn','MA',1813);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Clarette','Kuzemka','617-323-8221','803-151-0055',5.10014E+15,601,'5/15/2022','8698 Hoard Way','Boston','MA',2208);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Wang','Jan','339-775-6774','616-707-2855',3.74622E+14,8879,'3/7/2023','52 Messerschmidt Plaza','Woburn','MA',1813);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Evangelin','Cavanagh','617-315-7794','208-950-6495',3.44508E+14,6232,'2/22/2023','2 Ridgeway Center','Boston','MA',2203);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Florie','Doe','508-583-5441','513-995-6836',5.60221E+15,8036,'11/14/2022','8 Garrison Parkway','Worcester','MA',1654);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Francisca','Guiton','617-598-2637','203-790-6086',4.01796E+12,4423,'9/9/2022','9379 Huxley Circle','Boston','MA',2114);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Jorge','Bickle','857-724-8766','571-277-5817',4.50824E+15,3732,'1/15/2023','10675 Green Ridge Park','Boston','MA',2163);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Justino','Sproul','781-297-5420','941-685-6899',6.38345E+15,6487,'10/17/2022','9213 Holy Cross Way','Waltham','MA',2453);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Chadwick','Hook','617-788-9296','941-942-8821',5.60223E+15,2092,'5/11/2022','619 Rutledge Drive','Lynn','MA',1905);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Keslie','Threadgould','508-674-8334','603-100-9149',5.10014E+15,7196,'6/16/2022','99381 Thompson Plaza','Brockton','MA',2405);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Lela','Honeywood','617-617-4390','262-664-3996',5.60224E+15,6972,'12/21/2022','0365 Armistice Point','Boston','MA',2124);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Tremaine','Mears','318-436-6892','571-757-7727',5.60224E+15,3406,'11/28/2022','20426 Shasta Way','Boston','MA',2104);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Tuck','Hambling','617-448-4735','603-744-9049',6.39368E+15,4195,'6/1/2022','63276 Mcguire Terrace','Lynn','MA',1905);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Ollie','Vaines','413-627-4290','432-649-5764',4.01795E+12,3184,'9/8/2022','755 Anzinger Alley','Springfield','MA',1152);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Costa','Boas','617-628-8271','205-351-8743',4.01795E+15,516,'6/13/2022','3039 Crescent Oaks Place','Newton','MA',2458);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Norry','Geary','617-729-5525','317-171-6218',5.00236E+15,5519,'4/26/2022','4 Toban Way','Boston','MA',2203);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Vere','Keyhoe','413-985-4741','504-335-9183',5.61064E+15,8868,'6/6/2022','0463 Crest Line Avenue','Springfield','MA',1129);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Anderson','Beverley','508-129-6066','706-665-8418',4.91373E+15,7271,'12/25/2022','959 Vernon Way','Worcester','MA',1610);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Gael','Erett','617-285-8685','940-758-6419',6.37948E+15,7255,'6/29/2022','870 Waywood Junction','Boston','MA',2298);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Wallis','Cree','508-782-6602','405-251-9670',4.84408E+15,7727,'7/2/2022','6 Stoughton Pass','New Bedford','MA',2745);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Kinny','Robrow','413-602-4782','504-117-9172',5.01012E+15,6491,'2/18/2023','29 Larry Lane','Springfield','MA',1105);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Edsel','Eagland','617-807-1131','269-939-6088',3.74623E+14,2046,'1/21/2023','36 Paget Circle','Lynn','MA',1905);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Pippa','Trevena','413-402-4501','202-798-0529',4.01795E+12,8426,'7/12/2022','46 Hoepker Lane','Springfield','MA',1129);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Terese','Flanner','781-237-9636','501-610-2492',5.04837E+15,3656,'6/19/2022','44955 Amoth Junction','Lynn','MA',1905);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Ernesto','Tomaskunas','413-109-3800','402-833-7613',4.91373E+15,1856,'5/15/2022','842 Warrior Point','Springfield','MA',1129);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Parsifal','Beceril','508-737-1381','210-942-2949',4.84439E+15,9451,'8/29/2022','0 Alpine Road','Newton','MA',2162);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Trevar','Gerrit','508-236-2463','814-931-5605',3.72302E+14,2237,'3/15/2023','97389 Lotheville Way','Worcester','MA',1605);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Hortense','Fruin','617-556-0986','718-329-6988',4.91726E+15,7407,'9/17/2022','33 Morningstar Drive','Boston','MA',2216);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Nikolas','Aves','413-851-8440','203-679-9800',5.61062E+15,4525,'1/18/2023','169 Talmadge Center','Springfield','MA',1114);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Tabatha','Coverley','617-863-6350','321-884-7060',5.00236E+15,1697,'10/27/2022','47180 Commercial Street','Boston','MA',2298);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Daile','Clopton','318-278-6227','623-171-8471',3.72301E+14,3129,'7/3/2022','40446 Forest Dale Avenue','Boston','MA',2104);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Bernete','Waldocke','617-723-6749','915-439-6858',3.74623E+14,6258,'1/9/2023','50 Stuart Trail','Boston','MA',2208);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Marjy','Brokenshaw','617-649-8685','212-897-0406',5.60225E+15,2823,'1/30/2023','40 Vernon Alley','Boston','MA',2109);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Dotti','Tredget','617-120-4655','334-136-7482',5.10015E+15,6851,'4/13/2023','11 Carberry Terrace','Cambridge','MA',2142);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Alidia','Lowsely','978-525-9043','432-943-7792',6.38125E+15,6862,'11/18/2022','19363 3rd Pass','Watertown','MA',2472);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Cece','Rebbeck','774-315-6338','540-841-1147',4.4958E+15,5103,'9/23/2022','57 Havey Avenue','Worcester','MA',1610);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Mella','Mussington','318-467-0905','574-172-9908',4.91303E+15,1989,'4/17/2022','9957 Utah Park','Boston','MA',2104);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Sharai','Halgarth','617-984-7933','754-113-0878',6.37907E+15,7125,'5/14/2022','564 Everett Parkway','Boston','MA',2124);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Sheryl','Cobon','508-319-6971','260-568-2831',3.73296E+14,288,'12/22/2022','72171 Village Green Place','Brockton','MA',2405);

# LOCATIONS TABLE
INSERT INTO Locations(city,state,zip_code,phone,opening,closing) VALUES ('Boston','MA',2216,'617-973-7699','11:00','10:00');
INSERT INTO Locations(city,state,zip_code,phone,opening,closing) VALUES ('Boston','MA',2203,'617-731-9892','11:00','10:00');
INSERT INTO Locations(city,state,zip_code,phone,opening,closing) VALUES ('Boston','MA',2216,'617-430-4335','11:00','10:00');
INSERT INTO Locations(city,state,zip_code,phone,opening,closing) VALUES ('Springfield','MA',1129,'413-361-5631','11:00','10:00');
INSERT INTO Locations(city,state,zip_code,phone,opening,closing) VALUES ('Springfield','MA',1105,'413-788-9759','11:00','10:00');

# EMPLOYEES TABLE
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (NULL,'383-196-1701','714-210-9831','Sheree','Jeffryes');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (NULL,'434-364-8981','140-837-9001','Tonnie','O''Sherin');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (NULL,'584-576-1312','115-651-3414','Katherine','Stringer');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (1,'657-761-6004','724-316-5024','Murray','Viner');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (1,'999-435-1654','354-467-4775','Modesta','Wyvill');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (3,'756-173-5882','620-515-6685','Tyne','Fassan');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (3,'202-513-7392','390-591-8242','Aigneis','Ilyushkin');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (1,'400-811-3709','249-488-7345','Krishnah','Brickett');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (3,'154-793-0434','996-101-0927','Paxon','Moniker');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (1,'127-886-3458','796-489-5554','Berny','Hotson');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (2,'398-398-6209','901-385-5483','Viki','Cristobal');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (3,'473-358-8354','534-190-9473','Elinor','Seadon');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (3,'861-710-8305','871-802-8644','Crysta','Desport');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (2,'621-138-0944','869-123-6616','Joyous','Isgate');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (3,'540-485-1784','974-732-1792','Carmine','Else');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (1,'939-927-1770','941-623-4977','Zacharia','Alibone');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (2,'398-294-0599','726-248-1008','Doyle','Glastonbury');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (1,'350-918-0849','302-811-1780','Cody','Corbett');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (2,'425-107-2804','146-251-9724','Bryce','Goulbourne');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (2,'260-888-7704','688-819-4461','Norman','Denzilow');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (2,'740-551-8543','731-922-1062','Mandy','Iremonger');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (3,'737-771-5121','593-782-6197','Boyce','Southall');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (2,'777-393-9631','106-297-2916','Gustave','Scholcroft');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (3,'278-692-8191','336-710-0844','Deerdre','Goodchild');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (3,'295-851-7435','643-304-0213','Osmund','Treadwell');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (1,'645-668-6013','710-673-1027','Elvera','Rambaut');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (1,'262-574-4580','228-843-4503','Lynnelle','McCarry');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (2,'127-240-2851','243-998-2676','Court','Eloi');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (1,'969-211-6939','164-301-6621','Hedi','Collick');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (1,'578-215-7964','412-630-2497','Whitby','Tibalt');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (3,'335-778-1993','308-649-7547','Harriott','Olifard');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (1,'606-741-5602','530-968-9183','Schuyler','Grutchfield');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (1,'791-511-4299','922-680-3979','Neysa','Filan');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (1,'946-884-9284','296-973-4316','Nadiya','Lymer');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (1,'340-447-0265','646-395-6196','Darya','Collingridge');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (3,'494-154-4015','394-916-3707','Marin','Tomlinson');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (1,'799-588-5322','449-482-2653','Wendye','Gettings');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (2,'147-967-7912','706-395-9367','Kirk','Camelia');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (3,'502-195-1974','321-488-2465','Titos','Bibb');
INSERT INTO Employees(manager,phone1,phone2,first_name,last_name) VALUES (2,'549-757-1299','979-115-5978','Christoffer','McDuffie');

# EMPLOYMENTS TABLE - Right now, every employee is eventually getting fired.
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (19,3,'2/14/2023','7/27/2023','$24.59');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (35,4,'1/15/2023','6/6/2023','$19.07');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (5,5,'1/25/2023','7/17/2023','$20.21');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (26,3,'1/4/2023','6/28/2023','$24.18');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (31,5,'5/6/2023','6/5/2023','$23.82');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (1,4,'5/17/2023','6/22/2023','$24.14');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (37,3,'4/18/2023','6/10/2023','$22.36');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (14,2,'2/27/2023','7/18/2023','$19.50');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (34,1,'1/10/2023','7/22/2023','$24.43');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (27,3,'4/5/2023','7/29/2023','$20.13');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (4,3,'1/14/2023','7/22/2023','$19.62');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (20,1,'3/16/2023','6/11/2023','$22.05');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (20,5,'1/22/2023','7/10/2023','$17.67');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (38,2,'2/19/2023','6/20/2023','$19.24');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (8,3,'3/3/2023','7/17/2023','$17.57');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (36,4,'1/29/2023','7/2/2023','$23.38');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (21,4,'5/8/2023','7/4/2023','$23.44');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (22,2,'3/22/2023','6/2/2023','$17.24');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (36,5,'3/18/2023','6/25/2023','$20.16');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (35,2,'1/16/2023','6/23/2023','$16.64');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (20,4,'4/12/2023','6/7/2023','$23.76');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (10,5,'3/8/2023','6/7/2023','$18.40');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (9,2,'1/26/2023','7/7/2023','$24.11');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (27,1,'1/18/2023','7/10/2023','$15.16');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (37,3,'2/18/2023','7/13/2023','$17.68');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (30,1,'2/20/2023','6/30/2023','$17.75');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (20,1,'2/28/2023','6/16/2023','$22.51');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (23,5,'5/24/2023','7/1/2023','$19.17');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (37,2,'4/26/2023','7/27/2023','$18.22');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (22,3,'5/11/2023','6/23/2023','$15.21');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (11,3,'3/17/2023','6/12/2023','$18.28');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (39,2,'2/22/2023','6/18/2023','$23.62');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (31,2,'4/11/2023','7/22/2023','$15.61');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (3,5,'4/25/2023','6/15/2023','$23.44');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (22,3,'1/31/2023','7/4/2023','$23.32');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (5,1,'1/30/2023','6/8/2023','$21.28');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (13,1,'4/2/2023','6/13/2023','$22.97');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (12,2,'3/2/2023','6/19/2023','$17.11');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (20,4,'5/29/2023','6/6/2023','$18.02');
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (12,3,'2/16/2023','7/2/2023','$15.43');

# ITEMS TABLE
INSERT INTO Items(item_name,item_price,ingredients,availability) VALUES ('Grilled Cheese','$17.59','bread, cheese, butter','TRUE');
INSERT INTO Items(item_name,item_price,ingredients,availability) VALUES ('Caesar Salad','$7.27','lettuce, croutons, cheese, dressing','TRUE');
INSERT INTO Items(item_name,item_price,ingredients,availability) VALUES ('Chicken Quesadilla','$16.61','chicken, tortilla, cheese','TRUE');
INSERT INTO Items(item_name,item_price,ingredients,availability) VALUES ('French Fries','$8.75','potato','TRUE');
INSERT INTO Items(item_name,item_price,ingredients,availability) VALUES ('Spaghetti','$7.54','pasta, tomato sauce, cheese','TRUE');
INSERT INTO Items(item_name,item_price,ingredients,availability) VALUES ('Cheese Pizza','$9.95','cheese, dough, tomato sauce','TRUE');
INSERT INTO Items(item_name,item_price,ingredients,availability) VALUES ('Tomato Soup','$16.41','tomato, heavy cream','FALSE');
INSERT INTO Items(item_name,item_price,ingredients,availability) VALUES ('Hamburger','$12.87','bread, tomato, cheese, lettuce, beef, onion','TRUE');

# ORDERS TABLE
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (2,29,18,'FALSE','9/25/2023','Dairy Free');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (1,26,35,'FALSE','8/3/2023','No Eggs');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (1,27,37,'TRUE','7/4/2023','Spicy');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (3,16,15,'FALSE','12/30/2023','Very mild');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (4,34,39,'FALSE','10/18/2023','No Eggs');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (5,25,1,'FALSE','8/31/2023','Gluten Free');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (4,32,11,'TRUE','9/22/2023','Spicy');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (1,5,13,'FALSE','11/10/2023','Very mild');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (3,29,30,'FALSE','2/14/2023','Gluten Free');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (4,13,11,'FALSE','1/11/2023','Dairy Free');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (2,30,23,'TRUE','1/4/2023','Dairy Free');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (5,32,38,'TRUE','11/9/2023','Spicy');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (3,3,33,'TRUE','1/22/2023','Spicy');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (1,14,15,'TRUE','3/10/2023','Gluten Free');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (1,33,15,'TRUE','11/30/2023','No nuts');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (4,18,5,'FALSE','2/13/2023','No Eggs');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (5,25,13,'FALSE','5/21/2023','Very mild');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (2,24,18,'FALSE','3/9/2023','N/A');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (5,22,25,'TRUE','12/20/2023','Dairy Free');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (1,27,3,'TRUE','5/21/2023','Dairy Free');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (2,12,6,'TRUE','12/22/2023','N/A');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (1,2,9,'TRUE','2/13/2023','Gluten Free');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (2,35,39,'FALSE','12/20/2023','No nuts');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (3,6,4,'TRUE','10/26/2023','Spicy');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (3,38,11,'TRUE','7/3/2023','N/A');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (1,13,4,'FALSE','6/19/2023','N/A');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (3,36,2,'TRUE','10/17/2023','N/A');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (4,31,25,'FALSE','2/21/2023','Spicy');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (1,32,17,'FALSE','10/2/2023','Very mild');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (3,36,3,'TRUE','3/1/2023','N/A');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (4,19,28,'FALSE','6/16/2023','Very mild');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (1,6,34,'FALSE','8/3/2023','No nuts');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (1,11,4,'TRUE','6/10/2023','Spicy');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (4,3,3,'FALSE','4/8/2023','No nuts');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (2,21,3,'TRUE','1/3/2023','Very mild');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (4,38,16,'FALSE','10/17/2023','No nuts');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (2,11,30,'FALSE','4/5/2023','No nuts');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (4,39,34,'FALSE','5/9/2023','Dairy Free');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (2,4,29,'FALSE','1/24/2023','Dairy Free');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (4,38,40,'TRUE','8/24/2023','N/A');

# RESERVATIONS TABLE
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('5/25/2023',3,29,3);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('8/6/2023',4,16,4);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('11/7/2023',15,2,2);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('7/10/2023',6,6,3);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('3/2/2023',15,31,5);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('6/9/2023',10,35,1);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('4/26/2023',3,36,1);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('9/15/2023',14,33,5);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('8/3/2023',7,15,1);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('12/16/2023',2,2,5);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('1/7/2023',13,37,3);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('8/9/2023',2,30,4);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('3/25/2023',11,19,1);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('7/20/2023',5,29,4);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('9/8/2023',9,21,2);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('10/10/2023',12,38,3);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('12/29/2023',5,36,1);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('11/7/2023',10,35,2);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('12/12/2023',15,14,5);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('11/24/2023',15,26,1);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('3/11/2023',3,25,2);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('7/10/2023',11,9,1);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('5/23/2023',5,7,5);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('11/23/2023',15,38,3);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('11/18/2023',9,25,4);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('1/11/2023',15,20,5);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('5/13/2023',11,11,2);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2/23/2023',5,3,3);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('3/5/2023',2,3,4);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('10/11/2023',2,36,1);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('8/26/2023',4,24,5);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('7/4/2023',7,31,4);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('7/16/2023',12,38,1);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('4/26/2023',3,18,4);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('10/17/2023',15,36,4);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('12/28/2023',8,40,5);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('9/2/2023',5,33,4);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('6/26/2023',11,23,5);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('11/15/2023',15,22,5);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2/18/2023',7,13,4);

# ORDER ITEMS TABLE
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (4,32,1);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (3,29,1);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (4,21,2);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (5,11,2);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (7,29,2);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (4,18,2);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (8,36,3);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (2,33,3);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (3,25,2);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (2,14,3);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (1,19,3);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (3,5,2);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (8,12,3);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (7,10,1);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (4,33,1);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (5,12,1);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (1,37,1);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (8,36,2);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (2,3,2);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (6,7,1);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (6,25,1);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (7,2,1);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (4,9,1);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (3,10,2);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (5,35,2);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (2,23,3);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (7,15,2);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (6,38,1);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (6,14,1);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (3,35,1);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (6,17,3);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (4,26,1);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (8,38,2);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (1,9,1);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (8,8,1);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (1,17,1);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (1,27,1);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (6,8,2);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (4,7,1);
INSERT INTO OrderItems(item_id,order_id,item_quantity) VALUES (7,19,2);

# FEEDBACK TABLE
INSERT INTO Feedback(customer_id,comments,rating) VALUES (3,'Employees were rude',4);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (31,'Staff were wonderful',3);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (5,'Employees were rude',1);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (13,'My favorite restaurant',4);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (16,'Employees were rude',5);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (27,'My favorite restaurant',3);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (6,'Online orders were efficient',4);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (25,'Employees were rude',5);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (39,'My favorite restaurant',1);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (29,'Food was bland',3);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (3,'My favorite restaurant',4);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (9,'Great food',1);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (35,'Employees were rude',5);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (32,'Food was bland',1);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (31,'Great food',2);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (17,'Online orders were efficient',5);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (12,'Employees were rude',2);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (18,'Great food',2);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (7,'Online orders were efficient',1);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (1,'Great food',1);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (23,'Employees were rude',2);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (33,'Staff were wonderful',4);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (12,'Employees were rude',2);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (32,'My favorite restaurant',2);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (19,'Employees were rude',2);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (28,'Great food',2);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (12,'Staff were wonderful',3);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (21,'Online orders were efficient',1);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (27,'Great food',4);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (11,'Online orders were efficient',5);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (7,'Online orders were efficient',4);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (15,'Staff were wonderful',1);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (7,'Great food',4);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (37,'Employees were rude',3);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (32,'Staff were wonderful',5);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (15,'Great food',1);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (30,'Employees were rude',5);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (37,'My favorite restaurant',3);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (7,'Staff were wonderful',4);
INSERT INTO Feedback(customer_id,comments,rating) VALUES (17,'Online orders were efficient',2);

# SHIFTS TABLE
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (34,'11:00','2:00',5);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (32,'11:00','2:00',3);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (30,'11:00','2:00',4);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (5,'11:00','2:00',2);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (23,'11:00','2:00',2);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (22,'11:00','2:00',1);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (20,'11:00','2:00',4);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (8,'11:00','2:00',3);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (16,'11:00','2:00',2);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (21,'11:00','2:00',3);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (23,'11:00','2:00',5);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (38,'11:00','2:00',4);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (38,'11:00','2:00',5);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (18,'11:00','2:00',3);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (6,'11:00','2:00',3);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (2,'11:00','2:00',5);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (14,'11:00','2:00',1);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (22,'11:00','2:00',2);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (35,'11:00','2:00',3);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (24,'11:00','2:00',1);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (8,'2:00','10:00',3);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (38,'2:00','10:00',4);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (19,'2:00','10:00',4);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (11,'2:00','10:00',5);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (32,'2:00','10:00',3);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (4,'2:00','10:00',1);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (3,'2:00','10:00',3);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (39,'2:00','10:00',1);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (29,'2:00','10:00',3);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (3,'2:00','10:00',4);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (28,'2:00','10:00',2);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (9,'2:00','10:00',4);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (7,'2:00','10:00',3);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (22,'2:00','10:00',4);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (22,'2:00','10:00',5);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (36,'2:00','10:00',4);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (9,'2:00','10:00',2);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (1,'2:00','10:00',4);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (6,'2:00','10:00',5);
INSERT INTO Shifts(employee_id,shift_start,shift_end,location_id) VALUES (39,'2:00','10:00',3);


# NON-MOCKAROO GENERATED DATA

# INSERT INTO Locations (city, state, zip_code, phone, hours)
# VALUES ('Manhattan', 'New York', 14201, 7322005454, 6);

# INSERT INTO Locations (city, state, zip_code, phone, hours)
# VALUES ('Belmar', 'New Jersey', 07723, 7325450167, 8);

# INSERT INTO Customers(first_name, last_name, phone1, phone2, card_num, cvv, expiration_date, street, city, state, zip_code)
# VALUES ('Uzay', 'Takil', 7325005000, null, 451242147543, '023', '2022-05-22', '123 Jellyfish Ave', 'Holmdel', 'New Jersey', 07733);

# INSERT INTO Customers(first_name, last_name, phone1, phone2, card_num, cvv, expiration_date, street, city, state, zip_code)
# VALUES ('Lionel', 'Messi', 7325005001, 7325005003, 452245144543, '024', '2022-06-22', '92 Fontenot Drive', 'Lexington', 'Kentucky', 54467);

# INSERT INTO Feedback (customer_id, comments, rating)
# VALUES (1, 'Food was terrible', 1);

# INSERT INTO Feedback (customer_id, comments, rating)
# VALUES (2, 'Food was great!', 10);

# INSERT INTO Reservations(reservation_date, party_size, customer_id, location_id)
# VALUES ('2022-05-22', 3, 1, 2);

# INSERT INTO Reservations(reservation_date, party_size, customer_id, location_id)
# VALUES ('2022-07-23', 2, 2, 1);

# INSERT INTO Items(item_name, item_price, ingredients, availability)
# VALUES ('Burger', 11, 'Meat, Bun, Cheese', 1);

# INSERT INTO Items(item_name, item_price, ingredients, availability)
# VALUES ('Fries', 4.50, 'Potatoes', 0);

# INSERT INTO Employees(employee_id, manager, phone1, phone2, first_name, last_name)
# VALUES (100, 100, 7325005000, null, 'John', 'Doe');
#
# INSERT INTO Employees(employee_id, manager, phone1, phone2, first_name, last_name)
# VALUES (506, 100, 9985456786, 7567000167, 'Pedro', 'Conti');

# INSERT INTO Employments(employee_id, location_id, hire_date, fire_date, wage)
# VALUES (100, 1, '2017-07-23', null, 20);

# INSERT INTO Employments(employee_id, location_id, hire_date, fire_date, wage)
# VALUES (506, 1, '2019-07-23', '2019-07-24', 12);

# INSERT INTO Orders (order_id, location_id, customer_id, employee_id, status, order_date, restrictions)
# VALUES (905, 1, 1, 506, 1, '2019-07-23', 'None');

# INSERT INTO Orders (order_id, location_id, customer_id, employee_id, status, order_date, restrictions)
# VALUES (906, 1, 1, 506, 0, '2019-07-23', 'Nut Allergy');

# INSERT INTO OrderItems(item_id, order_id, item_quantity)
# VALUES (1, 905, 2);

# INSERT INTO OrderItems(item_id, order_id, item_quantity)
# VALUES (2, 906, 1);

# INSERT INTO Shifts(shift_start, shift_end, location_id)
# VALUES ('2023-4-07 12:00:00', '2023-4-07 17:00:00', 2);

# INSERT INTO Shifts(shift_start, shift_end, location_id)
# VALUES ('2023-4-07 12:00:00', '2023-4-07 17:00:00', 1);