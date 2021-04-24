# Postgrest Menu API


## Prerequest
```
postgresql

postgrest

```


## How to run
1) create tables inside menu.sql and roles

``` bash
postgrest service.conf
```

---

## CRUD (no token)

```
Base url:
localhost:3000/
```

### GETAll (view)
```localhost:3000/full_menus```

---

## CRUD (token)

### GETALL (menu)
```localhost:3000/menu```

### GET (menu)
```localhost:3000/menu?menu_id=eq.{id}```

### POST (menu)
```
localhost:3000/menu
body: {menu_id: int, name: varchar}
```

### PUT (menu)
```
localhost:3000/menu?menu_id=eq.{id}
body: {menu_id: int, name: varchar}
```

### DELETE (menu)
```localhost:3000/menu?menu_id=eq.{id}```

---

### GETALL (Dish)
```localhost:3000/Dish```

### GET (Dish)
```localhost:3000/Dish?dish_id=eq.{id}```

### POST (menu)
```
localhost:3000/Dish
body: {dish_id: int, name: varchar, price: Decimal, type: varchar}
```

### PUT (Dish)
```
localhost:3000/Dish?dish_id=eq.{id}
body: {dish_id: int, name: varchar, price: Decimal, type: varchar}
```

### DELETE (Dish)
```localhost:3000/Dish?dish_id=eq.{id}```

---

## tabels

tables can only be accessed by authorized users

### Menu

| Name          | Type     |  
| ------------- | ---      |
| menu_id       | INTEGER  |
| name          | VARCHAR  |

### menu_dishes

| Name          | Type     |  
| ------------- | ---      |
| menu_id       | INTEGER  |
| dish_id       | INTEGER  |

### Dish

| Name          | Type     |  
| ------------- | ---      |
| dish_id       | INTEGER  |
| name          | VARCHAR  |
| price         | DECIMAL  |
| type          | VARCHAR  |  

## views

Every user can access the view

| Name          | Type     |  
| ------------- | ---      |
| name          | VARCHAR  |
| Appetizer     | VARCHAR  |
| Soup          | VARCHAR  |
| Main dish     | VARCHAR  |  
| dessert       | VARCHAR  |  
