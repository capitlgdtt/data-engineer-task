# data-engineer-task

# Тестовое задание: Младший инженер качества данных

## Задача 1

Есть таблица orders с заказами интернет-магазина. Иногда данные о доставке поступают с задержкой или вовсе не обновляются.

```sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    status VARCHAR(50), -- 'pending', 'shipped', 'delivered', 'cancelled'
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    shipped_at TIMESTAMP,
    delivered_at TIMESTAMP
);
```

Напишите SQL-запрос, который находит заказы со статусом 'shipped', у которых дата последнего обновления (updated_at) не менялась более 7 дней. Выведите order_id, status, updated_at и количество дней с момента последнего обновления.

## Задача 2

В CRM-системе хранится таблица customers.

```sql
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    full_name VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(50),
    birth_date DATE,
    country VARCHAR(100),
    segment VARCHAR(50) -- 'retail', 'corporate', 'vip'
);
```

Напишите единый SQL-запрос, который для каждого столбца таблицы customers вычисляет: общее число строк, количество непустых значений и процент заполненности. Отсортируйте по проценту заполненности по возрастанию.

## Задача 3

В результате многократного импорта из внешних систем в таблице products появились дубликаты.

```sql
CREATE TABLE products (
    product_id INT,
    sku VARCHAR(100),
    product_name VARCHAR(255),
    category VARCHAR(100),
    price DECIMAL(10,2),
    created_at TIMESTAMP
);
```

1. Напишите запрос, который находит все группы дубликатов по полю sku и выводит: sku, количество дублей, минимальный и максимальный product_id в группе.
2. Напишите запрос, который удаляет дубликаты, оставляя только запись с наименьшим product_id в каждой группе.

## Задача 4

Таблица transactions содержит финансовые транзакции.

```sql
CREATE TABLE transactions (
    txn_id INT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(12,2),
    currency VARCHAR(10),
    txn_date DATE,
    txn_type VARCHAR(50), -- 'debit', 'credit', 'refund'
    status VARCHAR(50) -- 'pending', 'completed', 'failed'
);
```

Напишите один SQL-запрос, который проверяет несколько правил валидации одновременно и возвращает txn_id и список нарушенных правил для каждой некорректной записи. Правила:

- amount не должен быть отрицательным или нулевым
- currency должна быть одной из: 'USD', 'EUR', 'RUB', 'CNY'
- txn_type должен быть одним из: 'debit', 'credit', 'refund'
- txn_date не должна быть в будущем (позже текущей даты)

## Задача 5

Компания ведёт данные в двух системах: orders (система заказов) и inventory (склад). Данные должны быть согласованы между собой.

```sql
-- Система заказов
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    product_id INT,
    quantity INT,
    status VARCHAR(50), -- 'completed', 'cancelled', 'pending'
    order_date DATE
);

-- Складская система (остатки по дням)
CREATE TABLE inventory_snapshots (
    snapshot_id INT PRIMARY KEY,
    product_id INT,
    snapshot_date DATE,
    stock_qty INT
);
```

Задание:

1. Напишите запрос, который находит товары (product_id), у которых суммарное списанное количество по завершённым заказам (status = 'completed') за конкретную дату превышает остаток на складе на ту же дату.
2. Напишите запрос, который для каждого product_id показывает: дату, остаток на складе, суммарные продажи за день и разницу (stock_qty - daily_sales). Отфильтруйте только строки, где разница отрицательная.
