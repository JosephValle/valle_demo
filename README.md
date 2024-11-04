# valle_demo

My Demo Project

## About the architecture

I used BLoC for state management, and separated the project into layers logical (state), 
user interface (UI), network (for APIs), and data (Objects). 

Please note the separation of concerns in the project structure.

## About the interface

I used a paginated ListView to display the list of items, and a detail 
screen to display the details of the selected item. Pressing the refresh button will flush the DB

## About the logic

I used a repository for the BLoC that talks to the API clients for Github and the DB. It tries
to get the data from the DB first, and if it fails/doesn't have the data, it fetches the 
data from the API.


Please let me know if you have any questions or need any clarifications.
