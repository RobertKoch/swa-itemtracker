#Item Tracker

This is a little project for the lecture "Scaleable Webarchitectures".

##The Application

Your goal is to create a system that is used to track the inventory of a larger corporation. They run many offices in multiple locations and want to know how many pencils, staplers, computers, etc. they have in each of these locations.

The application comes in 4 services:

* A user management system
* An item tracking system
* A system to manage the different locations
* A reporting system


##Usage
At first you have to start all systems.
Go in each folder of the repository and start them with the rackup command.

Each system is running on a different port:

System    | Port
--------- | ----
users     | 9191
reports   | 9292
locations | 9393
items     | 9494

To use the Reporting Tool only open the following URL in your browser:

``http://localhost:9292/reports/by-location``

This will create a report with all companies and their inventory.
The following users gain access to it:

User  | Password
----- | -------------
wanda | partyhard2000
paul  | thepanther
anne  | flytothemoon


##Reporting System

There is only one Endpoint to create the report.
All locations and items are requested for the other apps and a report will be created.
Each request must be authenticated with a valid user name / password combination (see User Management System for all existing users).

**Endpoints**

method | url                 | HTTP status code
------ | ------------------- | ----------------------
GET    | reports/by-location | success: 200, fail: 403


##User Management System

This app only handle authentications.
It returns a status code ``200`` if authentication succeeds, otherwise ``403`` will be returned.
For authentication HTTP Basic is used.

**Endpoints**

method | url                 | HTTP status code
------ | ------------------- | ---------------------
GET    | user                | success: 200, fail: 403


##Item Tracking System

This app is managing all items from all locations. You can list, add or delete Items.
Each request must be authenticated with a valid user name / password combination (see User Management System for all existing users).

**Endpoints**

method | url       | HTTP status code         
------ | --------- | -----------------
GET    | items     | success: 201, fail: 403
POST   | items     | success: 200, fail: 403
DELETE | item/:id  | success: 200, fail: 403, 404


##Location Management System

This app is managing all locations. You can list, add or delete locations.
Each request must be authenticated with a valid user name / password combination (see User Management System for all existing users).

**Endpoints**

method | url           | HTTP status code         
------ | ------------- | -----------------
GET    | locations     | success: 201, fail: 403
POST   | location      | success: 200, fail: 403
DELETE | location/:id  | success: 200, fail: 403, 404