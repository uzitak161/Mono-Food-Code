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
    phone1 VARCHAR(12) UNIQUE,
    phone2 VARCHAR(12) UNIQUE,
    card_num VARCHAR(16) UNIQUE,
    cvv TEXT,
    expiration_date DATE,
    street VARCHAR(50),
    city VARCHAR(20),
    state VARCHAR(20),
    zip_code NUMERIC(5,0)
);

# Create Locations Table
CREATE TABLE Locations(
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    city VARCHAR(20),
    state VARCHAR(15),
    zip_code NUMERIC(5,0),
    phone VARCHAR(12) UNIQUE,
    opening TIME,
    closing TIME
);


# Create Employees Table
CREATE TABLE Employees(
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    manager INT,
    phone1 VARCHAR(12) UNIQUE,
    phone2 VARCHAR(12) UNIQUE,
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
    wage NUMERIC(4,2),
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
    availability BOOLEAN
);

# Create Orders Table
CREATE TABLE Orders(
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    location_id INT,
    customer_id INT,
    employee_id INT,
    status BOOLEAN,
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
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Merrill','Scranny','508-881-9511','302-856-0629','349765378189441',4930,'2023-01-31','085 Carpenter Plaza','Worcester','MA',1654);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Matty','Lippitt','339-742-9986','317-334-4894','337941230476060',1537,'2022-12-14','40390 Brown Alley','Woburn','MA',1813);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Clarette','Kuzemka','617-323-8221','803-151-0055','374288363530196',601,'2022-05-15','8698 Hoard Way','Boston','MA',2208);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Wang','Jan','339-775-6774','616-707-2855','372509004904264',8879,'2023-03-07','52 Messerschmidt Plaza','Woburn','MA',1813);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Evangelin','Cavanagh','617-315-7794','208-950-6495','738984765647890',6232,'2023-02-22','2 Ridgeway Center','Boston','MA',2203);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Florie','Doe','508-583-5441','513-995-6836','987567839201850',8036,'2022-11-14','8 Garrison Parkway','Worcester','MA',1654);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Francisca','Guiton','617-598-2637','203-790-6086','984757849302134',4423,'2022-09-09','9379 Huxley Circle','Boston','MA',2114);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Jorge','Bickle','857-724-8766','571-277-5817','647589304987657',3732,'2023-01-15','10675 Green Ridge Park','Boston','MA',2163);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Justino','Sproul','781-297-5420','941-685-6899','847589038574812',6487,'2022-10-17','9213 Holy Cross Way','Waltham','MA',2453);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Chadwick','Hook','617-788-9296','941-942-8821','647839029384756',2092,'2022-05-11','619 Rutledge Drive','Lynn','MA',1905);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Keslie','Threadgould','508-674-8334','603-100-9149','748392019847567',7196,'2022-06-16','99381 Thompson Plaza','Brockton','MA',2405);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Lela','Honeywood','617-617-4390','262-664-3996','574890293847589',6972,'2022-12-21','0365 Armistice Point','Boston','MA',2124);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Tremaine','Mears','318-436-6892','571-757-7727','748590391234457',3406,'2022-11-28','20426 Shasta Way','Boston','MA',2104);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Tuck','Hambling','617-448-4735','603-744-9049','758903398576489',4195,'2022-06-01','63276 Mcguire Terrace','Lynn','MA',1905);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Ollie','Vaines','413-627-4290','432-649-5764','874778909812346',3184,'2022-09-08','755 Anzinger Alley','Springfield','MA',1152);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Costa','Boas','617-628-8271','205-351-8743','676554347890987',516,'2022-06-13','3039 Crescent Oaks Place','Newton','MA',2458);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Norry','Geary','617-729-5525','317-171-6218','758909876567489',5519,'2022-04-26','4 Toban Way','Boston','MA',2203);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Vere','Keyhoe','413-985-4741','504-335-9183','546737898809123',8868,'2022-06-06','0463 Crest Line Avenue','Springfield','MA',1129);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Anderson','Beverley','508-129-6066','706-665-8418','657488909987123',7271,'2022-12-25','959 Vernon Way','Worcester','MA',1610);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Gael','Erett','617-285-8685','940-758-6419','657878812345679',7255,'2022-06-29','870 Waywood Junction','Boston','MA',2298);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Wallis','Cree','508-782-6602','405-251-9670','484408767780098',7727,'2022-07-02','6 Stoughton Pass','New Bedford','MA',2745);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Kinny','Robrow','413-602-4782','504-117-9172','501012123345676',6491,'2023-02-18','29 Larry Lane','Springfield','MA',1105);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Edsel','Eagland','617-807-1131','269-939-6088','374623765789098',2046,'2023-01-21','36 Paget Circle','Lynn','MA',1905);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Pippa','Trevena','413-402-4501','202-798-0529','401795435678987',8426,'2022-07-12','46 Hoepker Lane','Springfield','MA',1129);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Terese','Flanner','781-237-9636','501-610-2492','504837728193946',3656,'2022-06-19','44955 Amoth Junction','Lynn','MA',1905);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Ernesto','Tomaskunas','413-109-3800','402-833-7613','491376271839263',1856,'2022-05-15','842 Warrior Point','Springfield','MA',1129);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Parsifal','Beceril','508-737-1381','210-942-2949','484437162538390',9451,'2022-08-29','0 Alpine Road','Newton','MA',2162);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Trevar','Gerrit','508-236-2463','814-931-5605','372302768590988',2237,'2023-03-15','97389 Lotheville Way','Worcester','MA',1605);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Hortense','Fruin','617-556-0986','718-329-6988','491726465789877',7407,'2022-09-17','33 Morningstar Drive','Boston','MA',2216);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Nikolas','Aves','413-851-8440','203-679-9800','561062343567665',4525,'2023-01-18','169 Talmadge Center','Springfield','MA',1114);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Tabatha','Coverley','617-863-6350','321-884-7060','500236787789098',1697,'2022-10-27','47180 Commercial Street','Boston','MA',2298);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Daile','Clopton','318-278-6227','623-171-8471','372301656578923',3129,'2022-07-03','40446 Forest Dale Avenue','Boston','MA',2104);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Bernete','Waldocke','617-723-6749','915-439-6858','374623123456678',6258,'2023-01-09','50 Stuart Trail','Boston','MA',2208);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Marjy','Brokenshaw','617-649-8685','212-897-0406','560225757678909',2823,'2023-01-30','40 Vernon Alley','Boston','MA',2109);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Dotti','Tredget','617-120-4655','334-136-7482','510015985678909',6851,'2023-04-13','11 Carberry Terrace','Cambridge','MA',2142);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Alidia','Lowsely','978-525-9043','432-943-7792','638125456789876',6862,'2022-11-18','19363 3rd Pass','Watertown','MA',2472);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Cece','Rebbeck','774-315-6338','540-841-1147','449586578987651',5103,'2022-09-23','57 Havey Avenue','Worcester','MA',1610);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Mella','Mussington','318-467-0905','574-172-9908','491303757823450',1989,'2022-04-17','9957 Utah Park','Boston','MA',2104);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Sharai','Halgarth','617-984-7933','754-113-0878','637901123456780',7125,'2022-05-14','564 Everett Parkway','Boston','MA',2124);
INSERT INTO Customers(first_name,last_name,phone1,phone2,card_num,cvv,expiration_date,street,city,state,zip_code) VALUES ('Sheryl','Cobon','508-319-6971','260-568-2831','373296345678987',288,'2022-12-22','72171 Village Green Place','Brockton','MA',2405);

# LOCATIONS TABLE
INSERT INTO Locations(city,state,zip_code,phone,opening,closing) VALUES ('Boston','MA',02120,'617-973-7699','4:00','10:00');
INSERT INTO Locations(city,state,zip_code,phone,opening,closing) VALUES ('Cambridge','MA',02114,'617-731-9892','5:00','10:00');
INSERT INTO Locations(city,state,zip_code,phone,opening,closing) VALUES ('Holmdel','NJ',22816,'617-430-4335','4:00','10:30');
INSERT INTO Locations(city,state,zip_code,phone,opening,closing) VALUES ('San Diego','CA',91129,'413-361-5631','5:00','11:00');
INSERT INTO Locations(city,state,zip_code,phone,opening,closing) VALUES ('Manhattan','NY',11625,'413-788-9759','1:00','11:00');

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
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (4,2,'2023-01-05','2023-06-24',16.47);
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (21,4,'2023-05-10','2023-06-20',22.12);
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (11,3,'2023-01-11','2023-06-21',16.68);
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (27,2,'2023-03-01','2023-07-17',16.29);
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (25,2,'2023-03-12','2023-06-09',20.79);
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (27,4,'2023-05-19','2023-06-03',16.9);
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (34,3,'2023-04-23','2023-06-16',15.15);
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (29,5,'2023-02-16','2023-07-03',16.61);
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (14,4,'2023-03-26','2023-06-04',24.2);
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (26,2,'2023-03-23','2023-06-01',21.59);
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (5,5,'2023-05-14','2023-07-12',23.06);
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (8,3,'2023-03-05','2023-07-12',24.22);
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (33,5,'2023-04-05','2023-06-20',16.48);
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (32,2,'2023-04-12','2023-06-26',21.24);
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (21,5,'2023-05-17','2023-07-18',16.92);
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (19,1,'2023-04-12','2023-07-18',20.64);
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (34,5,'2023-01-23','2023-07-21',22.85);
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (40,4,'2023-02-28','2023-07-18',19.99);
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (37,3,'2023-04-16','2023-07-27',15.06);
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (35,4,'2023-05-30','2023-06-14',24.4);
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (3,3,'2023-04-11','2023-07-24',19.81);
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (30,5,'2023-03-16','2023-06-30',21.14);
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (40,2,'2023-04-09','2023-07-08',21.39);
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (7,5,'2023-03-08','2023-06-26',17.31);
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (32,4,'2023-04-08','2023-06-18',15.53);
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (7,3,'2023-03-05','2023-06-27',18.88);
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (11,5,'2023-05-15','2023-07-30',15.03);
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (21,2,'2023-03-06','2023-07-25',22.0);
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (19,5,'2023-01-06','2023-06-15',17.91);
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (16,4,'2023-04-16','2023-07-11',20.78);
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (29,3,'2023-01-09','2023-06-13',24.81);
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (1,3,'2023-02-23','2023-06-25',21.77);
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (34,4,'2023-03-06','2023-07-20',15.14);
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (35,3,'2023-01-29','2023-06-23',15.84);
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (14,3,'2023-04-30','2023-07-19',15.1);
INSERT INTO Employments(employee_id,location_id,hire_date,fire_date,wage) VALUES (37,2,'2023-04-16','2023-06-27',22.38);


# ITEMS TABLE
INSERT INTO Items(item_name,item_price,ingredients,availability) VALUES ('Dino Chicken Nuggets',9.05,'Chicken, dinosaur remains',1);
INSERT INTO Items(item_name,item_price,ingredients,availability) VALUES ('Beef Tartar',35.67,'Beef',1);
INSERT INTO Items(item_name,item_price,ingredients,availability) VALUES ('Grilled Cheese',6.47,'Bread, cheese',1);
INSERT INTO Items(item_name,item_price,ingredients,availability) VALUES ('Caesar Salad',16.0,'Iceburg lettuce, ranch dressing, croutons',1);
INSERT INTO Items(item_name,item_price,ingredients,availability) VALUES ('Chicken Quesadilla',14.08,'Tortilla, three cheese blend, roasted chicken',1);
INSERT INTO Items(item_name,item_price,ingredients,availability) VALUES ('French Fries',18.21,'Potatoe',1);
INSERT INTO Items(item_name,item_price,ingredients,availability) VALUES ('Spagetti',7.69,'Pasta, sauce, meatballs',1);
INSERT INTO Items(item_name,item_price,ingredients,availability) VALUES ('Cheese Pizza',14.35,'Dough, cheese, sauce',1);
INSERT INTO Items(item_name,item_price,ingredients,availability) VALUES ('Tomato Soup',14.67,'Tomato, soup',0);
INSERT INTO Items(item_name,item_price,ingredients,availability) VALUES ('Hamburger',9.05,'Brioche bun, angus beef, lettuce, tomato, onion',1);

# ORDERS TABLE
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (2,29,18,0,'2023-09-25','Dairy Free');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (1,26,35,0,'2023-08-03','No Eggs');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (1,27,37,1,'2023-07-04','Spicy');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (3,16,15,0,'2023-12-30','Very mild');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (4,34,39,0,'2023-10-18','No Eggs');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (5,25,1,0,'2023-08-31','Gluten Free');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (4,32,11,1,'2023-09-22','Spicy');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (1,5,13,0,'2023-11-10','Very mild');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (3,29,30,0,'2023-02-14','Gluten Free');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (4,13,11,0,'2023-01-11','Dairy Free');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (2,30,23,1,'2023-01-04','Dairy Free');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (5,32,38,1,'2023-11-09','Spicy');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (3,3,33,1,'2023-01-22','Spicy');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (1,14,15,1,'2023-03-10','Gluten Free');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (1,33,15,1,'2023-11-30','No nuts');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (4,18,5,0,'2023-02-13','No Eggs');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (5,25,13,0,'2023-05-21','Very mild');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (2,24,18,0,'2023-03-09','N/A');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (5,22,25,1,'2023-12-20','Dairy Free');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (1,27,3,1,'2023-05-21','Dairy Free');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (2,12,6,1,'2023-12-22','N/A');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (1,2,9,1,'2023-02-13','Gluten Free');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (2,35,39,0,'2023-12-20','No nuts');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (3,6,4,1,'2023-10-26','Spicy');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (3,38,11,1,'2023-07-03','N/A');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (1,13,4,0,'2023-06-19','N/A');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (3,36,2,1,'2023-10-17','N/A');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (4,31,25,0,'2023-02-21','Spicy');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (1,32,17,0,'2023-10-02','Very mild');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (3,36,3,1,'2023-03-01','N/A');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (4,19,28,0,'2023-06-16','Very mild');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (1,6,34,0,'2023-08-03','No nuts');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (1,11,4,1,'2023-06-10','Spicy');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (4,3,3,0,'2023-04-08','No nuts');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (2,21,3,1,'2023-01-03','Very mild');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (4,38,16,0,'2023-10-17','No nuts');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (2,11,30,0,'2023-04-05','No nuts');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (4,39,34,0,'2023-05-09','Dairy Free');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (2,4,29,0,'2023-01-24','Dairy Free');
INSERT INTO Orders(location_id,customer_id,employee_id,status,order_date,restrictions) VALUES (4,38,40,1,'2023-08-24','N/A');

# RESERVATIONS TABLE
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-05-25 00-05-00',3,29,3);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-08-06 00-08-00',4,16,4);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-11-07 00-11-00',15,2,2);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-07-10 00-07-00',6,6,3);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-03-02 00-03-00',15,31,5);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-06-09 00-06-00',10,35,1);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-04-26 00-04-00',3,36,1);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-09-15 00-09-00',14,33,5);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-08-03 00-08-00',7,15,1);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-12-16 00-12-00',2,2,5);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-01-07 00-01-00',13,37,3);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-08-09 00-08-00',2,30,4);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-03-25 00-03-00',11,19,1);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-07-20 00-07-00',5,29,4);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-09-08 00-09-00',9,21,2);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-10-10 00-10-00',12,38,3);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-12-29 00-12-00',5,36,1);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-11-07 00-11-00',10,35,2);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-12-12 00-12-00',15,14,5);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-11-24 00-11-00',15,26,1);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-03-11 00-03-00',3,25,2);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-07-10 00-07-00',11,9,1);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-05-23 00-05-00',5,7,5);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-11-23 00-11-00',15,38,3);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-11-18 00-11-00',9,25,4);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-01-11 00-01-00',15,20,5);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-05-13 00-05-00',11,11,2);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-02-23 00-02-00',5,3,3);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-03-05 00-03-00',2,3,4);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-10-11 00-10-00',2,36,1);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-08-26 00-08-00',4,24,5);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-07-04 00-07-00',7,31,4);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-07-16 00-07-00',12,38,1);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-04-26 00-04-00',3,18,4);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-10-17 00-10-00',15,36,4);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-12-28 00-12-00',8,40,5);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-09-02 00-09-00',5,33,4);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-06-26 00-06-00',11,23,5);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-11-15 00-11-00',15,22,5);
INSERT INTO Reservations(reservation_date,party_size,customer_id,location_id) VALUES ('2023-02-18 00-02-00',7,13,4);

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