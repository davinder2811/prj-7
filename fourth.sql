use cdac1;


-- Create Salesman table
CREATE TABLE Salesman (
    salesman_id INT PRIMARY KEY,
    name VARCHAR(255),
    city VARCHAR(255),
    commission FLOAT
);

-- Insert data into Salesman table
INSERT INTO Salesman (salesman_id, name, city, commission)
VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'LausonHen', 'San Jose', 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);

-- Create Customer table
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    cust_name VARCHAR(255),
    city VARCHAR(255),
    grade INT,
    salesman_id INT,
    FOREIGN KEY (salesman_id) REFERENCES Salesman(salesman_id)
);

-- Insert data into Customer table
INSERT INTO Customer (customer_id, cust_name, city, grade, salesman_id)
VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', 100, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002),
(3003, 'Jozy Altidor', 'Moncow', 200, 5007);

-- Create Orders table
CREATE TABLE Orders (
    ord_no INT PRIMARY KEY,
    purch_amt FLOAT,
    ord_date DATE,
    customer_id INT,
    salesman_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (salesman_id) REFERENCES Salesman(salesman_id)
);

-- Insert data into Orders table
INSERT INTO Orders (ord_no, purch_amt, ord_date, customer_id, salesman_id)
VALUES
(70001, 150.5, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002),
(70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760, '2012-09-10', 3002, 5001),
(70010, 1983.43, '2012-10-10', 3004, 5006),
(70003, 2480.4, '2012-10-10', 3009, 5003),
(70012, 250.45, '2012-06-27', 3008, 5002),
(70011, 75.29, '2012-08-17', 3003, 5007),
(70013, 3045.6, '2012-04-25', 3002, 5001);

use information_schema;
show tables;
desc key_column_usage;
select * from key_column_usage where table_name='STUDENT';


create table student(sno int,sname varchar(40) not null,course varchar(50),marks int,fees int);
desc student;
insert into student values(100,'Meena','PGDAC',500,76000);
select * from student;
alter table student modify course varchar(50) not null;
insert into student values(200,'Veena','PGDGI',600,76000);
alter table student add constraint s_uk unique(sno);
insert into student values(300,'Reeta','PGDGI',700,80000);
create table student1(sno int,sname varchar(40) not null,course varchar(50),marks int,fees int,constraint unistu unique(sno));
desc student1;
alter table student add constraint s_pk primary key(sno);
insert into student values(400,'Reeta','PGDGI',800,76000);
desc employees;
desc departments;
create table m(m int primary key);
insert into m values(500),(600),(700);
select * from m;
insert into m values(900);
alter table student add constraint s_fk foreign key(marks) references m(m);
desc student;
select * from student;
update student set marks=900 where sno=400;
desc m;
use information_schema;
show tables;
select * from key_column_usage where table_name='STUDENT';
show databases;

desc table_constraints;
desc views;




desc salesman;
desc customer;
desc orders;

select * from information_schema.table_constraints where constraint_type = 'Foreign Key' and table_name ='orders';


alter table customer drop foreign key cust_name;


alter table salesman add column id int primary key auto_increment;


alter table student drop constraint fk_salesman;

alter table salesman add constraint o_pk primary key(salesman_id);

alter table orders add constraint o_pk primary key(ord_no);

alter table orders add constraint fk_orders_customer foreign key(customer_id)references customer(customer_id);

alter table customer add constraint fk_customer_salesman foreign key(salesman_id)references salesman(salesman_id);



alter table orders add constraint o_pk primary key(customer_id);


alter table orders drop foreign key fk_salesman_id;


alter table orders alter column purch_amt set default 600;



create  view NewYorkSalespeople AS select * from salesman where city = 'New York';
select * from NewYorkSalespeople;


create view HighCommissionSalespeople AS select * from salesman where commission > 0.13;
select * from HighCommissionSalespeople;

create view CustomerGradeCount AS select grade, COUNT(*) AS customer_count from Customer group by grade;
select * from CustomerGradeCount;

create view OrderStatisticsByDate AS select ord_date, COUNT(DISTINCT customer_id) AS unique_customers, AVG(purch_amt) AS average_purchase_amount, SUM(purch_amt) AS total_purchase_amount FROM Orders GROUP BY ord_date;
select * from OrderStatisticsByDate;

CREATE INDEX custcity ON customer(city);

select * from customer;




CREATE INDEX custcity_country ON customer(city);



CREATE TABLE students (students_id INT AUTO_INCREMENT PRIMARY KEY,first_name VARCHAR(255),last_name VARCHAR(255),age INT);
desc students;

SELECT salesman_id "ID",name, 'Salesman'  FROM Salesman WHERE city = 'London'
UNION
SELECT customer_id "ID",cust_name, 'Customer' FROM Customer WHERE city = 'London';


SELECT salesman_id, customer_id  FROM customer UNION (SELECT salesman_id, customer_id  FROM orders);


select salary from employees order by salary desc limit 1 offset 3;





DELIMITER //
CREATE PROCEDURE GetSalesmanDetails()
BEGIN
    DECLARE v_salesman_id INT;
    DECLARE v_name VARCHAR(255);
    DECLARE v_city VARCHAR(255);
    DECLARE v_commission DECIMAL(10, 2);

    -- Assign the salesman ID you want to search for
    SET v_salesman_id = 5007;

    -- Retrieve data based on the given salesman ID
    SELECT salesman_id, name, city, commission
    INTO v_salesman_id, v_name, v_city, v_commission
    FROM Salesman
    WHERE salesman_id = v_salesman_id;

    -- Display the results
    SELECT 'Salesman ID:', v_salesman_id;
    SELECT 'Name:', v_name;
    SELECT 'City:', v_city;
    SELECT 'Commission:', v_commission;
END //
DELIMITER ;

CALL GetSalesmanDetails();


DELIMITER //
CREATE PROCEDURE GetEmployeesWithLastNameKing()
BEGIN
    DECLARE v_employee_id INT;
    DECLARE v_manager_id INT;
    DECLARE v_job_id VARCHAR(50);

    -- Retrieve data based on last_name 'King'
    SELECT employee_id, manager_id, job_id
    INTO v_employee_id, v_manager_id, v_job_id
    FROM employees
    WHERE last_name = 'King';

    -- Display the results
    SELECT 'Employee ID:', v_employee_id;
    SELECT 'Manager ID:', v_manager_id;
    SELECT 'Job ID:', v_job_id;
END //
DELIMITER ;

CALL GetEmployeesWithLastNameKing();

DELIMITER //
CREATE PROCEDURE GetDepartmentsWithLocation1800()
BEGIN
    DECLARE v_department_id INT;
    DECLARE v_department_name VARCHAR(50);

    -- Retrieve data based on location_id 1800
    SELECT department_id, department_name
    INTO v_department_id, v_department_name
    FROM departments
    WHERE location_id = 1800;

    -- Display the results
    SELECT 'Department ID:', v_department_id;
    SELECT 'Department Name:', v_department_name;
END //
DELIMITER ;

CALL GetDepartmentsWithLocation1800();


DELIMITER //
CREATE PROCEDURE UpdateSalary(IN lastName VARCHAR(255), IN employeeSalary DECIMAL(10, 2))
BEGIN
    DECLARE newSalary DECIMAL(10, 2);
    
    IF lastName = 'Hunold' THEN
        IF employeeSalary <= 5000 THEN
            SET newSalary = employeeSalary * 1.15;
        ELSEIF employeeSalary > 5000 AND employeeSalary <= 10000 THEN
            SET newSalary = employeeSalary * 1.10;
        ELSEIF employeeSalary > 10000 AND employeeSalary <= 20000 THEN
            SET newSalary = employeeSalary * 1.05;
        ELSE
            SET newSalary = employeeSalary;
        END IF;
        
        UPDATE employees
        SET salary = newSalary
        WHERE last_name = lastName;
        
        SELECT ( lastName, newSalary) AS Message;
    ELSE
        SELECT 'Employee not found.' AS Message;
    END IF;
END//
DELIMITER ;


call updatesalary('Hunold', 4500);



DELIMITER //

CREATE PROCEDURE CalculateSquare (IN inputNumber INT)
BEGIN
    DECLARE square INT;
    SET square = inputNumber * inputNumber;
    SELECT CONCAT('Square of ', inputNumber, ' is: ', square) AS Result;
END //

DELIMITER ;

CALL CalculateSquare(5);



DELIMITER //

CREATE PROCEDURE GetEmployeesByJobIDs()
BEGIN
    -- Declare variables
    DECLARE employee_name VARCHAR(255);
    DECLARE job_id INT;
    DECLARE department_name VARCHAR(255);
    
    -- Cursor to fetch data
    DECLARE employee_cursor CURSOR FOR
        SELECT e.employee_name, e.job_id, d.department_name
        FROM employees e
        JOIN departments d ON e.department_id = d.department_id
        WHERE e.job_id IN (6, 7, 8);
    
    -- Output columns
    SELECT 'Employee Name', 'Job ID', 'Department Name';
    
    -- Open the cursor
    OPEN employee_cursor;
    
    -- Loop through the results and display the data
    read_loop: LOOP
        -- Fetch data into variables
        FETCH employee_cursor INTO employee_name, job_id, department_name;
        
        -- If no more rows to fetch, exit the loop
        IF FETCH_STATUS = 0 THEN
            LEAVE read_loop;
        END IF;
        
        -- Display the data
        SELECT employee_name, job_id, department_name;
    END LOOP;
    
    -- Close the cursor
    CLOSE employee_cursor;
END //

DELIMITER ;


call GetEmployeesByJobIDs();