from __future__ import annotations
from typing import TYPE_CHECKING
if TYPE_CHECKING:
    from _typeshed import DataclassInstance
import csv
import random
from dataclasses import dataclass, asdict
from datetime import datetime, timedelta
from itertools import count, islice

def format_dict(di: DataclassInstance) -> dict[str, str]:
    d = asdict(di)
    format_mapping = {
        datetime: datetime.isoformat,
        float: lambda f: f"{f:.2f}",
    }

    r = {}
    for k, v in d.items():
        f = format_mapping.get(type(v), str)
        r[str(k)] = f(v)

    return r


@dataclass
class Employee:
    id: int
    name: str
    hours_worked: int
    is_manager: bool
    pin: int

@dataclass
class Order:
    id: int
    placed_at: datetime
    cost: float
    employee_id: int 

@dataclass
class Category:
    id: int
    name: str

@dataclass
class MenuItem:
    id: int
    name: str
    category_id: int
    stock: int
    cost: float

@dataclass
class DrinkOrder:
    id: int
    menu_id: int
    order_id: int

@dataclass
class DrinkIngredient:
    id: int
    drink_id: int
    ingredient_id: int
    servings: int

@dataclass
class Ingredient:
    id: int
    name: str
    stock: int
    cost: float 

START_DT = datetime.now() - timedelta(days=500)
END_DT = datetime.now()

def generate_random_datetime(start: datetime, end: datetime) -> datetime:
    total_seconds = (end - start).total_seconds()
    random_seconds = random.uniform(0, total_seconds)

    return start + timedelta(seconds=random_seconds)

def read_categories() -> list[Category]:
    with open("categories.csv") as f:
        reader = csv.DictReader(f)
        return [
            Category(
                id=int(row["id"]),
                name=str(row["name"]),
            )
            for row in reader
        ]

def read_employees() -> list[Employee]:
    with open("employees.csv") as f:
        reader = csv.DictReader(f)
        return [
            Employee(
                id=int(row["id"]),
                name=str(row["name"]),
                hours_worked=int(row["hours_worked"]),
                is_manager=row["is_manager"] == "TRUE",
                pin=int(row["pin"]),
            )
            for row in reader
        ] 

def read_menu() -> list[MenuItem]:
    with open("menu.csv") as f:
        reader = csv.DictReader(f)
        return [
            MenuItem(
                id=int(row["id"]),
                name=str(row["name"]),
                category_id=int(row["category_id"]),
                stock=int(row["stock"]),
                cost=float(row["cost"]),
            )
            for row in reader
        ]

def read_ingredients() -> list[Ingredient]:
    with open("ingredients.csv") as f:
        reader = csv.DictReader(f)
        return [
            Ingredient(
                id=int(row["id"]),
                name=str(row["name"]),
                stock=int(row["stock"]),
                cost=float(row["cost"]),
            )
            for row in reader
        ]

def generate_orders(
    *, 
    employees: list[Employee], 
    menu: list[MenuItem], 
    ingredients: list[Ingredient]
) -> tuple[list[Order], list[DrinkOrder], list[DrinkIngredient]]:
    orders = []
    drink_orders = []
    drink_ingredients = []

    order_id_tracker = count(0, 1)
    drink_id_tracker = count(0, 1)
    drink_ingredient_id_tracker = count(0, 1)

    sales_total = 0

    while sales_total < 1_250_000:
        order_id = next(order_id_tracker)
        # pick between 1 and 5 inclusive drinks for this order
        num_drinks = random.randint(1, 5)
        order_total = 0
        for drink_order_id in islice(drink_id_tracker, num_drinks):
            menu_item = random.choice(menu)
            drink_order = DrinkOrder(id=drink_order_id, menu_id=menu_item.id, order_id=order_id)

            order_total += menu_item.cost
            drink_orders.append(drink_order)

            # pick between 1 and 5 (inclusive) ingredients for this drink 
            num_ingredients = random.randint(1, 5)

            for drink_ingredient_id in islice(drink_ingredient_id_tracker, num_ingredients):
                ingredient = random.choice(ingredients)
                drink_ingredient = DrinkIngredient(
                    id=drink_ingredient_id, 
                    drink_id=drink_order_id,
                    ingredient_id=ingredient.id,
                    servings=random.randint(1, 3),
                )

                order_total += ingredient.cost
                drink_ingredients.append(drink_ingredient)

        sales_total += order_total

        order = Order(
            id=order_id, 
            placed_at=generate_random_datetime(START_DT, END_DT),
            cost=order_total,
            employee_id=random.choice(employees).id,
        )


        orders.append(order)

    print(f"Generated {next(order_id_tracker)} orders for a total of {sales_total:,.2f}")
    
    return orders, drink_orders, drink_ingredients


def main():
    employees = read_employees()
    menu = read_menu()
    ingredients = read_ingredients()
    orders, drink_orders, drink_ingredients = generate_orders(
        employees=employees, 
        menu=menu, 
        ingredients=ingredients
    )

    with open("orders.csv", "w", newline='') as f:
        writer = csv.DictWriter(f, ["id", "placed_at", "cost", "employee_id"])
        writer.writeheader()
        writer.writerows(map(format_dict, orders))
    print("Successfully wrote orders.csv")

    with open("drink_orders.csv", "w", newline='') as f:
        writer = csv.DictWriter(f, ["id", "menu_id", "order_id"])
        writer.writeheader()
        writer.writerows(map(format_dict, drink_orders))
    print("Successfully wrote drink_orders.csv")

    with open("drink_ingredients.csv", "w", newline='') as f:
        writer = csv.DictWriter(f, ["id", "drink_id", "ingredient_id", "servings"])
        writer.writeheader()
        writer.writerows(map(format_dict, drink_ingredients))
    print("Successfully wrote drink_ingredients.csv")


if __name__ == "__main__":
    main()
