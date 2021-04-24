/*------------------------------------------------------------------------------
                          CREATE SCHEMA, TABLES
------------------------------------------------------------------------------*/
CREATE SCHEMA restaurant;

CREATE TABLE IF NOT EXISTS restaurant.menu(
  menu_id serial primary key,
  name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS restaurant.dish (
  dish_id serial primary key,
  name VARCHAR(25) NOT NULL,
  price DECIMAL,
  type VARCHAR(25) CHECK(type in ('Appetizer', 'Soup', 'Main Dish', 'dessert'))
);

CREATE TABLE IF NOT EXISTS restaurant.menu_dishes(
  menu_id INT NOT NULL,
  dish_id INT,

  PRIMARY KEY (menu_id, dish_id),
  FOREIGN KEY (dish_id) REFERENCES restaurant.dish (dish_id),
  FOREIGN KEY (menu_id) REFERENCES restaurant.menu (menu_id) ON DELETE CASCADE
);


/*------------------------------------------------------------------------------
                                CREATE VIEWS
------------------------------------------------------------------------------*/

CREATE OR REPLACE VIEW restaurant.full_menus as
  SELECT M.name,
  (
    SELECT D.name
    FROM restaurant.menu M
      INNER JOIN restaurant.menu_dishes USING(menu_id)
      INNER JOIN restaurant.dish D USING(dish_id)
    WHERE D.type = 'Appetizer'
  ) AS Appetizer,
  (
    SELECT D.name
    FROM restaurant.menu M
      INNER JOIN restaurant.menu_dishes USING(menu_id)
      INNER JOIN restaurant.dish D USING(dish_id)
    WHERE D.type = 'Soup'
  ) AS Soup,
  (
    SELECT D.name
    FROM restaurant.menu M
      INNER JOIN restaurant.menu_dishes USING(menu_id)
      INNER JOIN restaurant.dish D USING(dish_id)
    WHERE D.type = 'Main Dish'
  ) AS Main_Dish,
  (
    SELECT D.name
    FROM restaurant.menu M
      INNER JOIN restaurant.menu_dishes USING(menu_id)
      INNER JOIN restaurant.dish D USING(dish_id)
    WHERE D.type = 'dessert'
  ) AS dessert,
  (
    SELECT SUM(D.price)
    FROM restaurant.menu M
      INNER JOIN restaurant.menu_dishes USING(menu_id)
      INNER JOIN restaurant.dish D USING(dish_id)
  ) AS total_price
  FROM restaurant.menu M

SELECT * FROM restaurant.full_menus;


/*------------------------------------------------------------------------------
                                    CREATE ROLES
------------------------------------------------------------------------------*/
create role trusted_user nologin;
grant usage on schema restaurant to trusted_user;
grant all on restaurant.menu to trusted_user;
grant all on restaurant.dish to trusted_user;
grant all on restaurant.menu_dishes to trusted_user;
grant all on restaurant.full_menus to trusted_user;
grant usage, select on sequence restaurant.menu_menu_id_seq to trusted_user;
grant usage, select on sequence restaurant.dish_dish_id_seq to trusted_user;


CREATE ROLE web_anon nologin;
grant usage on schema restaurant to web_anon;
grant select on restaurant.full_menus to web_anon;

create role authenticator noinherit login password 'mysecretpassword';
grant trusted_user to authenticator;
grant web_anon to authenticator;


/*------------------------------------------------------------------------------
                                    INSERT
------------------------------------------------------------------------------*/
INSERT INTO restaurant.menu(name) VALUES ('menu1');

INSERT INTO restaurant.dish(name, price, type) VALUES ('food1', 8.50, 'Appetizer');
INSERT INTO restaurant.dish(name, price, type) VALUES ('food2', 2, 'Soup');
INSERT INTO restaurant.dish(name, price, type) VALUES ('food3', 12.50, 'Main Dish');
INSERT INTO restaurant.dish(name, price, type) VALUES ('food4', 5, 'dessert');


INSERT INTO restaurant.menu_dishes(menu_id, dish_id) values(1, 1);
INSERT INTO restaurant.menu_dishes(menu_id, dish_id) values(1, 2);
INSERT INTO restaurant.menu_dishes(menu_id, dish_id) values(1, 3);
INSERT INTO restaurant.menu_dishes(menu_id, dish_id) values(1, 4);



/*------------------------------------------------------------------------------
                                    DROPS
------------------------------------------------------------------------------*/
DROP VIEW restaurant.Full_Menus;
DROP TABLE restaurant.menu_dishes;
DROP TABLE restaurant.menu;
DROP TABLE restaurant.dish;
DROP schema restaurant;

DROP ROLE trusted_user;
DROP ROLE web_anon;
DROP ROLE authenticator;
