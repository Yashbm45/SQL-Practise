-- Create Database First
create database Problem_set;

-- Use database 
use  Problem_set;

-- Table: departments
CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL
);

INSERT INTO departments (department_id, department_name) VALUES
(1, 'Human Resources'),
(2, 'Engineering'),
(3, 'Marketing'),
(4, 'Sales'),
(5, 'Finance');


-- Table: employees
CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_name VARCHAR(100),
    department_id INT,
    salary DECIMAL(10,2),
    hire_date DATE,
    manager_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

INSERT INTO employees (employee_id, employee_name, department_id, salary, hire_date, manager_id) VALUES
(1, 'Alice Smith', 2, 75000, '2015-03-12', NULL),
(2, 'Bob Johnson', 2, 85000, '2016-07-19', 1),
(3, 'Carol White', 3, 65000, '2017-05-24', NULL),
(4, 'David Brown', 1, 60000, '2018-08-11', 3),
(5, 'Eve Davis', 4, 72000, '2019-01-14', 4),
(6, 'Frank Moore', 5, 55000, '2020-02-10', NULL),
(7, 'Grace Lee', 2, 90000, '2020-09-05', 2),
(8, 'Hank Wilson', 3, 67000, '2021-11-17', 3),
(9, 'Ivy Taylor', 4, 69000, '2021-03-03', 5),
(10, 'Jack Harris', 1, 58000, '2022-06-08', 4),
(11, 'Karen Lewis', 1, 62000, '2020-12-20', 4),
(12, 'Leo Clark', 2, 81000, '2022-01-15', 7),
(13, 'Mona Young', 3, 64000, '2019-04-18', 8),
(14, 'Nina King', 4, 70000, '2018-09-27', 5),
(15, 'Oscar Hall', 5, 59000, '2016-11-30', 6),
(16, 'Paul Allen', 2, 87000, '2020-07-21', 2),
(17, 'Queen Scott', 1, 61000, '2021-05-12', 10),
(18, 'Rick Adams', 5, 53000, '2022-02-17', 6),
(19, 'Sara Baker', 3, 68000, '2021-10-04', 13),
(20, 'Tom Green', 4, 71000, '2020-03-29', 5);

-- Table: customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    registration_date DATE,
    status VARCHAR(20)
);

INSERT INTO customers (customer_id, customer_name, email, city, registration_date, status) VALUES
(1, 'Anna Clark', 'anna@example.com', 'New York', '2020-01-05', 'active'),
(2, 'Ben Turner', 'ben@example.com', 'Chicago', '2019-03-10', 'inactive'),
(3, 'Cindy Lopez', 'cindy@example.com', 'Los Angeles', '2021-06-22', 'active'),
(4, 'Dan Murphy', 'dan@example.com', 'Houston', '2022-07-13', 'active'),
(5, 'Ella Ward', 'ella@example.com', 'Phoenix', '2020-09-29', 'inactive'),
(6, 'Fred Knight', 'fred@example.com', 'Dallas', '2021-02-15', 'active'),
(7, 'Gina Russell', 'gina@example.com', 'Austin', '2019-12-01', 'active'),
(8, 'Henry Foster', 'henry@example.com', 'San Jose', '2020-04-11', 'inactive'),
(9, 'Iris Gomez', 'iris@example.com', 'Seattle', '2021-08-18', 'active'),
(10, 'Jake Simmons', 'jake@example.com', 'Boston', '2022-01-10', 'active'),
(11, 'Kelly Evans', 'kelly@example.com', 'Denver', '2020-10-06', 'inactive'),
(12, 'Liam Howard', 'liam@example.com', 'Miami', '2021-11-30', 'active'),
(13, 'Mia Cox', 'mia@example.com', 'Atlanta', '2022-03-25', 'active'),
(14, 'Nate Ward', 'nate@example.com', 'Detroit', '2020-07-14', 'inactive'),
(15, 'Olivia Bell', 'olivia@example.com', 'Orlando', '2019-08-22', 'active'),
(16, 'Pete Diaz', 'pete@example.com', 'San Diego', '2021-05-12', 'active'),
(17, 'Quinn Cole', 'quinn@example.com', 'Tampa', '2022-04-08', 'inactive'),
(18, 'Rose Hill', 'rose@example.com', 'Portland', '2020-06-18', 'active'),
(19, 'Steve Dean', 'steve@example.com', 'Cleveland', '2018-11-02', 'inactive'),
(20, 'Tina Ray', 'tina@example.com', 'Sacramento', '2021-09-19', 'active');


-- Table: products
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock INT
);

INSERT INTO products (product_id, product_name, category, price, stock) VALUES
(1, 'Laptop', 'Electronics', 799.99, 50),
(2, 'Smartphone', 'Electronics', 499.99, 100),
(3, 'Headphones', 'Electronics', 89.99, 150),
(4, 'T-shirt', 'Clothing', 19.99, 200),
(5, 'Jeans', 'Clothing', 39.99, 120),
(6, 'Blender', 'Home', 29.99, 80),
(7, 'Microwave', 'Home', 79.99, 60),
(8, 'Desk Chair', 'Furniture', 119.99, 30),
(9, 'Sofa', 'Furniture', 499.99, 15),
(10, 'Coffee Maker', 'Home', 49.99, 100),
(11, 'Smartwatch', 'Electronics', 149.99, 70),
(12, 'Water Bottle', 'Sports', 14.99, 300),
(13, 'Yoga Mat', 'Sports', 24.99, 200),
(14, 'Backpack', 'Accessories', 39.99, 150),
(15, 'Sunglasses', 'Accessories', 29.99, 100),
(16, 'Shoes', 'Clothing', 59.99, 120),
(17, 'Jacket', 'Clothing', 89.99, 75),
(18, 'Tablet', 'Electronics', 299.99, 50),
(19, 'Camera', 'Electronics', 599.99, 20),
(20, 'Printer', 'Electronics', 129.99, 60);


-- Table: orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO orders (order_id, customer_id, order_date, total_amount, status) VALUES
(1, 1, '2022-01-15', 899.99, 'shipped'),
(2, 2, '2022-02-25', 79.99, 'pending'),
(3, 3, '2022-03-10', 239.98, 'shipped'),
(4, 4, '2022-04-05', 499.99, 'cancelled'),
(5, 5, '2022-05-15', 49.99, 'shipped'),
(6, 6, '2022-06-10', 69.99, 'shipped'),
(7, 7, '2022-07-20', 199.99, 'pending'),
(8, 8, '2022-08-11', 119.99, 'shipped'),
(9, 9, '2022-09-05', 349.99, 'shipped'),
(10, 10, '2022-10-01', 79.99, 'shipped'),
(11, 11, '2022-11-20', 139.99, 'pending'),
(12, 12, '2022-12-15', 299.99, 'shipped'),
(13, 13, '2023-01-22', 59.99, 'cancelled'),
(14, 14, '2023-02-18', 129.99, 'shipped'),
(15, 15, '2023-03-13', 199.99, 'shipped'),
(16, 16, '2023-04-01', 249.99, 'shipped'),
(17, 17, '2023-05-10', 499.99, 'pending'),
(18, 18, '2023-06-17', 69.99, 'shipped'),
(19, 19, '2023-07-05', 39.99, 'shipped'),
(20, 20, '2023-08-03', 79.99, 'pending');

-- Table: order_items
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO order_items (order_item_id, order_id, product_id, quantity, price) VALUES
(1, 1, 1, 1, 799.99),
(2, 1, 3, 1, 89.99),
(3, 2, 4, 1, 19.99),
(4, 3, 2, 2, 499.98),
(5, 3, 6, 1, 29.99),
(6, 4, 9, 1, 499.99),
(7, 5, 10, 1, 49.99),
(8, 6, 11, 1, 149.99),
(9, 7, 12, 2, 24.99),
(10, 8, 7, 1, 79.99),
(11, 9, 14, 1, 39.99),
(12, 10, 15, 1, 29.99),
(13, 11, 16, 1, 59.99),
(14, 12, 17, 1, 89.99),
(15, 13, 18, 1, 299.99),
(16, 14, 19, 1, 599.99),
(17, 15, 20, 1, 129.99),
(18, 16, 1, 2, 799.99),
(19, 17, 2, 1, 499.99),
(20, 18, 8, 1, 119.99),
(21, 19, 3, 1, 89.99),
(22, 20, 5, 1, 39.99),
(23, 1, 4, 1, 19.99),
(24, 2, 7, 1, 79.99),
(25, 3, 12, 1, 24.99),
(26, 4, 3, 2, 89.99),
(27, 5, 14, 1, 39.99),
(28, 6, 19, 1, 599.99),
(29, 7, 20, 1, 129.99),
(30, 8, 16, 1, 59.99),
(31, 9, 5, 1, 39.99),
(32, 10, 18, 1, 299.99),
(33, 11, 9, 1, 499.99),
(34, 12, 8, 1, 119.99),
(35, 13, 7, 1, 79.99),
(36, 14, 10, 1, 49.99),
(37, 15, 11, 1, 149.99),
(38, 16, 12, 2, 24.99),
(39, 17, 14, 1, 39.99),
(40, 18, 16, 1, 59.99),
(41, 19, 13, 1, 24.99),
(42, 20, 17, 1, 89.99),
(43, 1, 4, 1, 19.99),
(44, 2, 1, 1, 799.99),
(45, 3, 2, 2, 499.98),
(46, 4, 15, 1, 29.99),
(47, 5, 13, 1, 24.99),
(48, 6, 20, 1, 129.99),
(49, 7, 19, 1, 599.99),
(50, 8, 18, 1, 299.99),
(51, 9, 14, 1, 39.99),
(52, 10, 16, 1, 59.99),
(53, 11, 17, 1, 89.99),
(54, 12, 4, 1, 19.99),
(55, 13, 9, 1, 499.99),
(56, 14, 6, 1, 29.99),
(57, 15, 5, 1, 39.99),
(58, 16, 3, 1, 89.99),
(59, 17, 12, 1, 24.99),
(60, 18, 2, 1, 499.99);


-- Table: inventory
CREATE TABLE inventory (
    product_id INT PRIMARY KEY,
    quantity_available INT,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO inventory (product_id, quantity_available, last_updated) VALUES
(1, 50, '2023-08-01 12:00:00'),
(2, 100, '2023-08-01 12:00:00'),
(3, 150, '2023-08-01 12:00:00'),
(4, 200, '2023-08-01 12:00:00'),
(5, 120, '2023-08-01 12:00:00'),
(6, 80, '2023-08-01 12:00:00'),
(7, 60, '2023-08-01 12:00:00'),
(8, 30, '2023-08-01 12:00:00'),
(9, 15, '2023-08-01 12:00:00'),
(10, 100, '2023-08-01 12:00:00'),
(11, 70, '2023-08-01 12:00:00'),
(12, 300, '2023-08-01 12:00:00'),
(13, 200, '2023-08-01 12:00:00'),
(14, 150, '2023-08-01 12:00:00'),
(15, 100, '2023-08-01 12:00:00'),
(16, 120, '2023-08-01 12:00:00'),
(17, 75, '2023-08-01 12:00:00'),
(18, 50, '2023-08-01 12:00:00'),
(19, 20, '2023-08-01 12:00:00'),
(20, 60, '2023-08-01 12:00:00');

-- Table: users
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50),
    password varchar(50),
    role varchar(50),
    email VARCHAR(100),
    created_at DATETIME,
    is_active BOOLEAN default false
);

INSERT INTO users (user_id, username, password, role, email, created_at) VALUES
(1, 'admin', 'password123', 'admin', 'admin@example.com', '2023-01-01 12:00:00'),
(2, 'johndoe', 'john123', 'user', 'john.doe@example.com', '2023-01-05 14:00:00'),
(3, 'janedoe', 'jane123', 'user', 'jane.doe@example.com', '2023-01-10 16:00:00'),
(4, 'bobsmith', 'bob123', 'user', 'bob.smith@example.com', '2023-02-15 10:00:00'),
(5, 'alicejones', 'alice123', 'user', 'alice.jones@example.com', '2023-02-20 11:30:00'),
(6, 'mikebrown', 'mike123', 'user', 'mike.brown@example.com', '2023-03-01 08:00:00'),
(7, 'lucygreen', 'lucy123', 'user', 'lucy.green@example.com', '2023-03-10 18:30:00'),
(8, 'clarkkent', 'superman123', 'user', 'clark.kent@example.com', '2023-03-15 12:00:00'),
(9, 'brucewayne', 'batman123', 'user', 'bruce.wayne@example.com', '2023-03-20 14:45:00'),
(10, 'tonystark', 'ironman123', 'user', 'tony.stark@example.com', '2023-04-01 09:30:00'),
(11, 'steverogers', 'cap123', 'user', 'steve.rogers@example.com', '2023-04-10 12:00:00'),
(12, 'natasharomanoff', 'natasha123', 'user', 'natasha.romanoff@example.com', '2023-04-15 14:00:00'),
(13, 'thorodin', 'thor123', 'user', 'thor.odin@example.com', '2023-04-20 16:00:00'),
(14, 'hulkbuster', 'hulk123', 'user', 'bruce.banner@example.com', '2023-04-25 18:00:00'),
(15, 'blackwidow', 'black123', 'user', 'natasha.romanoff@example.com', '2023-05-01 10:00:00'),
(16, 'wanda', 'scarlet123', 'user', 'wanda.maximoff@example.com', '2023-05-05 12:00:00'),
(17, 'vision', 'vision123', 'user', 'vision@example.com', '2023-05-10 14:00:00'),
(18, 'spiderman', 'peter123', 'user', 'peter.parker@example.com', '2023-05-15 16:00:00'),
(19, 'doctorstrange', 'strange123', 'user', 'stephen.strange@example.com', '2023-05-20 18:00:00'),
(20, 'antman', 'antman123', 'user', 'scott.lang@example.com', '2023-05-25 20:00:00');


-- Table: returns
CREATE TABLE returns (
    return_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    return_date DATE,
    reason TEXT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO returns (return_id, order_id, product_id, return_date, reason) VALUES
(1, 1, 1, '2022-01-16', 'Damaged'),
(2, 2, 4, '2022-02-26', 'Wrong item'),
(3, 3, 6, '2022-03-11', 'Not as described'),
(4, 4, 9, '2022-04-06', 'Damaged'),
(5, 5, 10, '2022-05-16', 'Wrong item'),
(6, 6, 11, '2022-06-11', 'Not as described'),
(7, 7, 12, '2022-07-21', 'Damaged'),
(8, 8, 7, '2022-08-12', 'Wrong item'),
(9, 9, 14, '2022-09-06', 'Not as described'),
(10, 10, 15, '2022-10-02', 'Damaged'),
(11, 11, 16, '2022-11-21', 'Wrong item'),
(12, 12, 17, '2022-12-16', 'Not as described'),
(13, 13, 18, '2023-01-23', 'Damaged'),
(14, 14, 19, '2023-02-19', 'Wrong item'),
(15, 15, 20, '2023-03-14', 'Not as described'),
(16, 16, 1, '2023-04-02', 'Damaged'),
(17, 17, 2, '2023-05-11', 'Wrong item'),
(18, 18, 3, '2023-06-18', 'Not as described'),
(19, 19, 4, '2023-07-06', 'Damaged'),
(20, 20, 5, '2023-08-04', 'Wrong item');


-- Table: audit_logs
CREATE TABLE audit_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    table_name VARCHAR(50),
    operation_type VARCHAR(10),
    record_id INT,
    old_value TEXT,
    new_value TEXT,
    changed_by VARCHAR(100),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO audit_logs (table_name, operation_type, record_id, old_value, new_value, changed_by) VALUES
('products', 'INSERT', 1, NULL, '{"product_id": 1, "product_name": "Laptop", "category": "Electronics", "price": 799.99, "stock": 50}', 'admin'),
('products', 'UPDATE', 1, '{"product_name": "Laptop", "category": "Electronics", "price": 799.99, "stock": 50}', '{"product_name": "Laptop", "category": "Electronics", "price": 749.99, "stock": 45}', 'admin'),
('products', 'DELETE', 1, '{"product_name": "Laptop", "category": "Electronics", "price": 749.99, "stock": 45}', NULL, 'admin'),
('orders', 'INSERT', 1, NULL, '{"order_id": 1, "customer_id": 2, "order_date": "2023-08-01", "total_amount": 299.99, "status": "shipped"}', 'johndoe'),
('orders', 'UPDATE', 1, '{"order_date": "2023-08-01", "total_amount": 299.99, "status": "shipped"}', '{"order_date": "2023-08-02", "total_amount": 319.99, "status": "shipped"}', 'admin'),
('orders', 'DELETE', 1, '{"order_date": "2023-08-02", "total_amount": 319.99, "status": "shipped"}', NULL, 'admin'),
('order_items', 'INSERT', 1, NULL, '{"order_item_id": 1, "order_id": 1, "product_id": 2, "quantity": 1, "price": 499.99}', 'johndoe'),
('order_items', 'UPDATE', 1, '{"order_id": 1, "product_id": 2, "quantity": 1, "price": 499.99}', '{"order_id": 1, "product_id": 3, "quantity": 2, "price": 99.99}', 'admin'),
('order_items', 'DELETE', 1, '{"order_id": 1, "product_id": 3, "quantity": 2, "price": 99.99}', NULL, 'admin'),
('users', 'INSERT', 1, NULL, '{"user_id": 1, "username": "admin", "role": "admin", "email": "admin@example.com"}', 'system'),
('users', 'UPDATE', 1, '{"username": "admin", "role": "admin", "email": "admin@example.com"}', '{"username": "superadmin", "role": "admin", "email": "superadmin@example.com"}', 'system'),
('users', 'DELETE', 1, '{"username": "superadmin", "role": "admin", "email": "superadmin@example.com"}', NULL, 'system'),
('inventory', 'INSERT', 1, NULL, '{"product_id": 1, "quantity_available": 50, "last_updated": "2023-08-01 12:00:00"}', 'admin'),
('inventory', 'UPDATE', 1, '{"quantity_available": 50, "last_updated": "2023-08-01 12:00:00"}', '{"quantity_available": 45, "last_updated": "2023-08-05 12:00:00"}', 'admin'),
('inventory', 'DELETE', 1, '{"quantity_available": 45, "last_updated": "2023-08-05 12:00:00"}', NULL, 'admin'),
('returns', 'INSERT', 1, NULL, '{"return_id": 1, "order_id": 1, "product_id": 1, "return_date": "2023-08-01", "reason": "Defective"}', 'admin'),
('returns', 'UPDATE', 1, '{"return_date": "2023-08-01", "reason": "Defective"}', '{"return_date": "2023-08-02", "reason": "Wrong product"}', 'admin'),
('returns', 'DELETE', 1, '{"return_date": "2023-08-02", "reason": "Wrong product"}', NULL, 'admin'),
('audit_logs', 'INSERT', 1, NULL, '{"log_id": 1, "table_name": "products", "operation_type": "INSERT", "record_id": 1, "old_value": NULL, "new_value": "{\\"product_id\\": 1, \\"product_name\\": \\"Laptop\\", \\"category\\": \\"Electronics\\", \\"price\\": 799.99, \\"stock\\": 50}", "changed_by": "admin"}', 'system');
