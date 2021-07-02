# README
# Rocket_Elevators_API_1
> Week 7 project for Rocket Elevators. Subsidiary of Codeboxx Technologies
## Table of Contents
* [General](#general)
* [Technologies](#technologies)
* [Setup](#setup)
* [Code Examples](#Code-Examples)

## General
The purpose of this repo is to demonstrate 7 APIs integrated with our Rocket-Elevators-Digital-Presence project.

## Technologies
* Google Maps API
* Twilio API
* Slack API
* Dropbox API
* Sendgrid API
* IBM Watson API
* ZenDesk API

## Setup
Once installed, seed the database with 'rake db:seed' then start your mySQL server with 'mySQL.server start' then you're ready to launch the rails server to view the site 'rails s'.

To access the /admin page you must be logged in as an employee, here are some credentials for you:

	Email: nicolas.genest@codeboxx.biz
	Password: password
	
Once you're signed in, you can look at all our code examples.

## Code Examples
This repo includes 7 test scenarios, one for each API.

### Google Maps
Once signed in, on the admin page next to the Dashboard tab is a tab titled Geolocations. Click this to view a Google map with markers of each our customers buildings. Including some key details about the building, such as amount of elevators, client name, and building address.

### Twilio
Under the dashboard tab in the /admin page you can see a list of all of Rocket Elevators assets, including elevators. If you click on elevators, you're presented with a list of elevators, click the edit button, then change the status of the elevator to 'Intervention', and hit save at the bottom of the page. If your name is Patrick or Mathieu you will be greeted with a text saying "Rocket Elevators Alert! Elevator serial_number has a status of Intervention." along with some identifying information about the elevator in question. 

### Slack
While testing Twilio by changing the elevator status you will inadvertently be testing the slack bot as well. The slack messages will appear from Mathieu Dion BOT in the rocket-elevator slack workspace.

### Sendgrid
At the bottom of the Rocket Elevators homepage lives a Contact Us form. If you fill it out with your email, you will receive a follow up email from Rocket Elevators saying "Thanks for contacting us! We will be in touch soon." Check your spam filter if you don't see the email. If using @hotmail addresses, dont. Message will not be received. 

### Dropbox
Also in the Contact Us form is Dropbox API functionality. Once the contact us form has been created, from the admin/customer page, create a customer with the same email address.

### IBM Watson
On the dashboard of the admin page there should be an audio file which will futuristically tell you how many elevators, buildings, and customers we have. Followed by some stats about those elevators.

### Zendesk
ZenDesk hates Rocket Elevators.
