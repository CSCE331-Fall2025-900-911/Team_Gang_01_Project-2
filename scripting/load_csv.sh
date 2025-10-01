set -e

if [ -z "$1" ]; then
    echo "ERROR: Database connection URL not passed in"
    exit 1
fi

psql "$1" -c "\COPY employees FROM employees.csv WITH CSV HEADER;"
psql "$1" -c "\COPY categories FROM categories.csv WITH CSV HEADER;"
psql "$1" -c "\COPY ingredients FROM ingredients.csv WITH CSV HEADER;"
psql "$1" -c "\COPY menu FROM menu.csv WITH CSV HEADER;"
psql "$1" -c "\COPY orders FROM orders.csv WITH CSV HEADER;"
psql "$1" -c "\COPY drinks_orders FROM drink_orders.csv WITH CSV HEADER;"
psql "$1" -c "\COPY drinks_ingredients FROM drink_ingredients.csv WITH CSV HEADER;"

echo "Successfully seeded database"
