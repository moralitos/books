Book Shop
=========

Sample web application simulating a few functions for an online a book shop. 

### CSV Book Catalog Import
 - Use this link to import a CSV file with the following columns: isbn, title, author, publisher, date_published, unit_cost, category (book, magazine or audiobook)

### Export of Template Book Catalog
 - Use this link to export a template CSV file with a few sample entries. 
 - If the database is empty you can use this template and import it.

### Search
 - Title, Author, Publisher, Category
 - Supports type ahead

### Display Listing
 - Lists the books in a table 
 - Use Arrow keys to move between rows
 - Press Return key to drill into the row highlighted

### Display Individual
 - Book displayed with all fields.

### Running the application
 - Clone this repository
 - Run the following from the command line
 
 ```
   cd <app_directory>
   bundle install
   rake db:create
   rake db:migrate
   rails s
```

 - The last command starts the web server on the default rails port (3000)
 - Get to the application at http://localhost:3000




