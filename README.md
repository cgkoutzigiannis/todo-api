# README

Below you will find screenshots using [httpie](https://httpie.io/) for each endpoint in our API.

## Signup
http POST http://localhost:3000/signup Content-Type:application/json username=usrnm password:psswrd
![Signup](/images/signup.png)

## Login
http POST http://localhost:3000/auth/login Content-Type:application/json username=chris password=12345
![Login](/images/auth_login.png)

## Add a new todo list
http POST http://localhost:3000/todos title="Todo List" description="My Todo List" -A bearer -a eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyfQ.SYqaEbJe79I6WUqEmVLURl8PgHi4g66r5w_lkyehtxU
![Add a new todo list](/images/add_todo.png)

## Get a todo list
http GET http://localhost:3000/todos -A bearer -a eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyfQ.SYqaEbJe79I6WUqEmVLURl8PgHi4g66r5w_lkyehtxU
![Get a todo list](/images/get_todo.png)

## Get a specific todo list
http GET http://localhost:3000/todos/1 -A bearer -a eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyfQ.SYqaEbJe79I6WUqEmVLURl8PgHi4g66r5w_lkyehtxU
![Get a specifc todo list](/images/get_specific_todo.png)

## Delete a specific todo and it's items:
http DELETE http://localhost:3000/todos/1 -A bearer -a eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyfQ.SYqaEbJe79I6WUqEmVLURl8PgHi4g66r5w_lkyehtxU
![Get a todo list and it's item.](/images/delete_todo.png)

## Get a specific item
http GET http://localhost:3000/todos/2/items item_id=1 -A bearer -a eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.YvpeoTwNNC78GlPrVKCGbqvtjFDl_kTBcGjbY_gaQxA
![Get a todo list item](/images/get_item.png)

## Update a specific item
http PUT http://localhost:3000/todos/2/items -A bearer -a eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.YvpeoTwNNC78GlPrVKCGbqvtjFDl_kTBcGjbY_gaQxA < ~/test.json
![Update a todo list item](/images/update_item.png)
The data we used for this command were:
![Update JSON data](/images/update_data.png)

## Delete a specific item
http DELETE http://localhost:3000/todos/2/items item_id=1 -A bearer -a eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.YvpeoTwNNC78GlPrVKCGbqvtjFDl_kTBcGjbY_gaQxA
![Delete a todo list](/images/delete_todo.png)
