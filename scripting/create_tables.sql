CREATE TABLE categories(
    id INTEGER PRIMARY KEY,
    name TEXT,
    stock INTEGER
);

CREATE TABLE menu(
    id INTEGER PRIMARY KEY,
    name TEXT,
    category_id INTEGER REFERENCES categories(id),
    stock INTEGER,
    cost DECIMAL
);

CREATE TABLE employees(
    id INTEGER PRIMARY KEY,
    name TEXT,
    hours_worked INTEGER,
    is_manager BOOLEAN,
    pin INTEGER
);

CREATE TABLE orders(
    id INTEGER PRIMARY KEY,
    placed_at TIMESTAMP WITH TIME ZONE,
    cost DECIMAL,
    employee_id INTEGER REFERENCES employees(id)
);

CREATE TABLE drinks_orders(
    id INTEGER PRIMARY KEY,
    menu_id INTEGER REFERENCES menu(id),
    order_id INTEGER REFERENCES orders(id)
);

CREATE TABLE ingredients(
    id INTEGER PRIMARY KEY,
    name TEXT,
    stock INTEGER,
    cost DECIMAL
);

CREATE TABLE  drinks_ingredients(
    id INTEGER PRIMARY KEY,
    drink_id INTEGER REFERENCES drinks_orders(id),
    ingredient_id INTEGER REFERENCES ingredients(id),
    servings INTEGER
);
