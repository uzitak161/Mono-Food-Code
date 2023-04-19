# Mono-Food

## Description:

Mono-Food is a restaurant management application, for chain restaurants that have multiple locations. The goal of Mono-Food is to create an application that tracks various activities in a restaurant. By using this application, restaurant managers will be able to monitor customers’ previous orders, track employee performance and salaries, and oversee the restaurant’s overall progress. More specifically, this application will record the meals ordered by each customer, which employee served/helped them, and how each menu item is performing. This application will provide restaurants with an easy and efficient way to streamline their operations and boost their profitability. This currently supports the following functionalities.

### For Customers:

1. Online Orders
2. Online Reservations
3. Customer Order History
4. Customer Info for automatic billing


### For Managers:

1. Revenue statistics for locations and employees
2. Menu management (adding/removing/editing menu items)
3. Managing Employee Salaries
4. Managing Employee Work Locations

# Running Mono-Food

This repo contains a boilerplate setup for spinning up 3 Docker containers: 
1. A MySQL 8 container for obvious reasons
1. A Python Flask container to implement a REST API
1. A Local AppSmith Server

## How to setup and start the containers
**Important** - you need Docker Desktop installed

1. Clone this repository.  
1. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL. 
1. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the a non-root user named webapp. 
1. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.  
1. Build the images with `docker compose build`
1. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 

# Mono-Food Tests

Tests are developed and run via the ThunderClient library. To run or add tests...

1. Download the Thunder Client Extension on VSCode
2. Go to Extension settings for Thunder Client 
3. Check the Save to Workspace option in the extension settings

All the tests are meant to be run in order as they appear in the thunder client collections. In the current version of Mono-Food you should run the Customers Collection first followed by the Managers Collection.

# Editing/Viewing the Mono-Food UI

The Mono-Food UI is fully developed through appsmith. Our frontend portion of our application can be found in our appsmith repository https://github.com/uzitak161/Mono-Food 

1. Once all of your docker containers are running and are done initializing, visit localhost:8080 to visit the appsmith page. 
2. Choose the Mono-Food project (must have access to Appsmith repo from owner)
3. View/Edit/Deploy the UI as you see fit (see the Appsmith tutoorial for guidance )


# Technical Overview:


## Database Design

All of our data is created and managed via a MySql database called resterauntdb. Our database was designed with the following ER diagram. 


![Final Global ERD](https://user-images.githubusercontent.com/77938678/233180416-5dbfa346-05c6-4bad-88a7-b390ab35be6f.jpg)


Here is the resulting Relational MySql Database shown in DataGrip.

<img width="936" alt="Screen Shot 2023-04-19 at 3 33 47 PM" src="https://user-images.githubusercontent.com/77938678/233180969-1d5f4462-517a-4fa3-9b7e-d5876c5fd479.png">


## API Design

Our API is divided into 2 blueprints, each managing interactions of a different user type. The Customers' routes contain all calls necessary to display, update and delete data that is within their privilege. Managers essentially have additional capabilities and permissions. We can ensure that no user that is logged in as a customer has access to routes within the manager blueprint, and we plan to do the same with the employee's blueprint once we begin development. All of our routes is developed using Python and Flask.

## Link to Video

*insert here*
