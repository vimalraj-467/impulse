# Impulse
Manage e-commerce flash sales

# Tech Stack:
1. Ruby
2. Sinatra
3. MongoDB - Transaction DB
4. RabbitMQ - Process Events
5. SideKiq - Scheduler
6. Telegram API integration for notifications
7. Redis - Atomic locking of inventory for handling flash sales

# Sample APIs

@url = {{flash_sale_url}}/api/v1

### Health
GET {{url}}/health
Content-Type: application/json

### Create User
POST {{url}}/users
Content-Type: application/json

{
"nickname": "vimal",
"external_id": "wizkid07"
}

### Fetch User
GET {{url}}/users/wizkid07


### Create Flash Sale and scheduled sidekiq job
POST {{url}}/flash-sales
Content-Type: application/json

{
"name": "Nike",
"description": "Brand new nike sneakers at 50% off!",
"image": "https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=1287",
"inventory_quantity": 100,
"schedule_at": 1762341510719,
"schedule_till": 1762342056118,
"active": true,
"user_id": "690887bca8d36f0830e11e87"
}

### Fetch Sale
GET {{url}}/flash-sales/690998d0930deeafaae02d15


### Fetch Upcoming Sales
GET {{url}}/flash-sales/upcoming

### Update Sale
PATCH {{url}}/flash-sales/690998d0930deeafaae02d15

{
"description": "Old Nike",
"name": "Nike",
"inventory_quantity": 90

}

### Full Text Search using elastic search
GET {{url}}/flash-sales/search?query=abibas


### Create flash sale order using redis for atomic operations to over-selling
POST {{url}}/orders
Content-Type: application/json

{
"user_id": "690887bca8d36f0830e11e87",
"sale_id": "690b325c46d1e8c06acfd002"
}
