##GroceryLister

This is an app I built during my first week of using Sinatra, while honing my HTTP skills with Launch Academy.

I built it to practice generating a dynamic web page in response to a `GET` request, and persisting information from users submitted via a `POST` request.

The app allows users to input a grocery item into the text field, along with the quantity of that item to buy.

The inputed data is persisted via a .csv file: `grocery_list.csv`.

All feature development was driven via RSPEC acceptance tests, located in the `spec` folder.

###Features
* Visiting `GET /` redirects user to `GET /groceries`.
* Visiting `GET /groceries` displays a list of groceries to purchase.
* Visiting `GET /groceries` displays a form for adding a new grocery item.
* The name of each grocery item in an `<li>` element.
* The form to add a new grocery item requires the grocery name to be specified.
* The list of groceries is read from the `grocery_list.csv` file, which stores each item on a new line.
* Submitting an empty form does not modify the `grocery_list.csv` file.
* `quantity` is an optional field to the grocery item form.
* If the form is submitted with only a quantity, then no grocery item is added. The page is re-rendered with the previously submitted quantity pre-filled in the form.
* The grocery items in `GET /groceries` should be links to pages that display the individual grocery name and quantity if it was specified.
* The form submits to `POST /groceries` which saves the new item to the `grocery_list.csv` file.
