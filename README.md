#Item Tracker

This is a little project for the lecture "Scaleable Webarchitectures".

##The Application

Your goal is to create a system that is used to track the inventory of a larger corporation. They run many offices in multiple locations and want to know how many pencils, staplers, computers, etc. they have in each of these locations.

The application comes in 4 services:

* A user management system
* An item tracking system
* A system to manage the different locations
* A reporting system


#Usage
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

http://localhost:9292/reports/by-location

This will create a report with all companies and their inventory.
The following users gain access to it:

User  | Password
----- | -------------
wanda | partyhard2000
paul  | thepanther
anne  | flytothemoon


#Reporting System

**Endpoints**

method | url                
------ | -------------------
GET    | reports/by-location


#User Management System

**Endpoints**

method | url                
------ | -------------------
GET    | user


#Item Tracking System

**Endpoints**

method | url                
------ | -------------------
GET    | items
POST   | items
DELETE | item/:id


#Location Management System

**Endpoints**

method | url                
------ | -------------------
GET    | locations
POST   | location
DELETE | location/:id