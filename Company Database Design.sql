#drop table employee;
create table employee(
    emp_id int primary key,
    first_name varchar(40),
    last_name varchar(40),
    birth_date DATE,
    sex varchar(1),
    salary int,
    super_id int,
    branch_id int
);

create table branch(
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(40),
    mgr_id INT,
    mgr_start_date DATE,
    FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) 
    ON DELETE SET NULL
);

DELETE FROM employee
WHERE emp_id = 102;

SELECT * FROM branch;
SELECT * FROM employee;

ALTER TABLE employee
ADD FOREIGN KEY(branch_id) REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(super_id) REFERENCES employee(emp_id)
ON DELETE SET NULL;

CREATE TABLE client(
    client_id INT PRIMARY KEY,
    client_name VARCHAR(40),
    branch_id INT,
    FOREIGN KEY(branch_id) REFERENCES branch(branch_id)
    ON DELETE SET NULL
);

CREATE TABLE works_with(
    emp_id INT,
    client_id INT,
    total_sales INT,
    PRIMARY KEY(emp_id, client_id),
    FOREIGN KEY(emp_id) REFERENCES employee(emp_id)
    ON DELETE CASCADE,
    FOREIGN KEY(client_id) REFERENCES client(client_id)
    ON DELETE CASCADE
);

CREATE TABLE branch_supplier(
    branch_id INT,
    supplier_name VARCHAR(40),
    supply_type VARCHAR(40),
    PRIMARY KEY(branch_id, supplier_name),
    FOREIGN KEY(branch_id) REFERENCES branch(branch_id)
    ON DELETE CASCADE
);

DELETE FROM branch
WHERE branch_id = 2;

SELECT * FROM branch_supplier;

#corporate
INSERT INTO employee VALUES(
    100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL
);

INSERT INTO branch VALUES(
    1, 'Corporate', 100, '2006-02-09'
);

UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

INSERT INTO employee VALUES(
    101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1
);

SET FOREIGN_KEY_CHECKS = 0;
drop table branch_supplier;
drop table works_with;
drop table client;
drop table employee;
drop table branch;
SET FOREIGN_KEY_CHECKS = 1;
 
#Scranton
INSERT INTO employee VALUES(
    102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL
);

INSERT INTO branch VALUES(
    2, 'Scranton', 102, '1992-04-06'
);

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(
    103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2
);
INSERT INTO employee VALUES(
    104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2
);
INSERT INTO employee VALUES(
    105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2
);

#stanford
INSERT INTO employee VALUES(
    106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL
);

INSERT INTO branch VALUES(
    3, 'Stanford', 106, '1998-02-13'
);

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(
    107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3
);
INSERT INTO employee VALUES(
    108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3
);

INSERT INTO client VALUES(
    400, "Dunmore Highschool", 2
);
INSERT INTO client VALUES(
    401, "Lackawana Country", 2
);
INSERT INTO client VALUES(
    402, "FedEx", 3
);
INSERT INTO client VALUES(
    403, "John Daly Law, LLC", 3
);
INSERT INTO client VALUES(
    404, "Scranton Whitepages", 2
);
INSERT INTO client VALUES(
    405, "Times Newspaper", 3
);
INSERT INTO client VALUES(
    406, "FedEx", 2
);

INSERT INTO works_with VALUES(
    105, 400, 55000
);
INSERT INTO works_with VALUES(
    102, 401, 267000
);
INSERT INTO works_with VALUES(
    108, 402, 22500
);
INSERT INTO works_with VALUES(
    107, 403, 5000
);
INSERT INTO works_with VALUES(
    108, 403, 12000
);
INSERT INTO works_with VALUES(
    105, 404, 33000
);
INSERT INTO works_with VALUES(
    107, 405, 26000
);
INSERT INTO works_with VALUES(
    102, 406, 15000
);
INSERT INTO works_with VALUES(
    105, 406, 130000
);

INSERT INTO branch_supplier VALUES(
    2, 'Hammer Mill', 'Paper'
);
INSERT INTO branch_supplier VALUES(
    2, 'Uni-ball', 'Writing Utensils'
);
INSERT INTO branch_supplier VALUES(
    3, 'Patriot Paper', 'Paper'
);INSERT INTO branch_supplier VALUES(
    2, 'J.T.Forms & Labels', 'Custom Forms'
);INSERT INTO branch_supplier VALUES(
    3, 'Uni-ball', 'Writing Utensils'
);INSERT INTO branch_supplier VALUES(
    3, 'Hammer Mill', 'Paper'
);INSERT INTO branch_supplier VALUES(
    3, 'Stanford Labels', 'Custom Forms'
);

SELECT * FROM employee;
SELECT * FROM branch;
SELECT * FROM branch_supplier;
SELECT * FROM client;
SELECT * FROM works_with;
SELECT * FROM employee
ORDER BY salary DESC;
SELECT * FROM employee
ORDER BY sex, first_name, last_name;
SELECT * FROM employee
LIMIT 5;
SELECT first_name AS forename, 
last_name AS surname FROM employee;
SELECT DISTINCT sex FROM employee; 

SELECT COUNT(emp_id) FROM employee;
SELECT COUNT(emp_id) FROM employee
WHERE sex = 'F' AND birth_date > '1970-01-01';
SELECT AVG(salary) FROM employee;
SELECT AVG(salary) FROM employee
WHERE sex = 'M';
SELECT SUM(salary) FROM employee;
SELECT COUNT(sex), sex FROM employee
GROUP BY sex;
SELECT SUM(total_sales), emp_id FROM works_with
GROUP BY(emp_id);

SELECT * FROM client
WHERE client_name LIKE '%LLC';
SELECT * FROM branch_supplier
WHERE supplier_name LIKE '%Label%';
SELECT * FROM employee
WHERE birth_date LIKE '%10%';
SELECT * FROM client
WHERE client_name LIKE '%school%';

SELECT first_name AS company_names FROM employee
UNION
SELECT branch_name FROM branch
UNION 
SELECT client_name FROM client;

SELECT client_name, client.branch_id FROM client
UNION
SELECT supplier_name, branch_supplier.branch_id FROM branch_supplier;
SELECT salary FROM employee
UNION
SELECT total_sales FROM works_with;

INSERT INTO branch VALUES(4, 'Buffalo', NULL, NULL);
SELECT employee.first_name, branch.branch_name FROM employee
JOIN branch
ON employee.emp_id = branch.mgr_id;
SELECT employee.first_name, branch.branch_name FROM employee
LEFT JOIN branch
ON employee.emp_id = branch.mgr_id;
SELECT employee.first_name, branch.branch_name FROM employee
RIGHT JOIN branch
ON employee.emp_id = branch.mgr_id;

SELECT employee.first_name, employee.last_name, works_with.total_sales FROM employee
JOIN works_with
ON employee.emp_id = works_with.emp_id
WHERE employee.emp_id IN (
SELECT works_with.emp_id 
FROM works_with
WHERE works_with.total_sales > 30000
);

SELECT client.client_name FROM client
WHERE client.branch_id = (
SELECT branch.branch_id FROM branch
WHERE branch.mgr_id = 102 
LIMIT 1);

CREATE TABLE trigger_test (
message VARCHAR(100));

DELIMITER $$
CREATE
TRIGGER my_trigger BEFORE INSERT
ON employee
FOR EACH ROW BEGIN 
INSERT INTO trigger_test VALUES('added new employee');
END$$
DELIMITER ;

INSERT INTO employee VALUES(
109, 'Oscar', 'Martinez', '1968-02-19', 'M', 69000, 106, 3
);
INSERT INTO employee VALUES(
110, 'Kevin', 'Malone', '1978-02-19', 'M', 69000, 106, 3
);
INSERT INTO employee VALUES(
111, 'Pam', 'Beesly', '1988-02-19', 'F', 69000, 106, 3
);

SELECT * FROM trigger_test;

DELIMITER $$
CREATE
TRIGGER my_trigger1 BEFORE INSERT
ON employee
FOR EACH ROW BEGIN 
INSERT INTO trigger_test VALUES(NEW.first_name);
END$$
DELIMITER ;

sudo find / -name mysql
/usr/local/mysql-8.2.0-macos13-x86_64/bin/mysql -u root -p

DELIMITER $$
CREATE 
TRIGGER my_triggle2 BEFORE INSERT
ON employee
FOR EACH ROW BEGIN 
IF NEW.sex = 'M' THEN 
INSERT INTO trigger_test VALUES('added male employee');
ELSEIF NEW.sex = 'F' THEN 
INSERT INTO trigger_test VALUES('added female employee');
ELSE
INSERT INTO trigger_test VALUES('added other employee');
END IF;
END$$
DELIMITER ;

DROP TRIGGER my_trigger; #terminal

CREATE TABLE salesman(
    salesman_id INT PRIMARY KEY,
    name VARCHAR(40),
    city VARCHAR(40),
    commission DECIMAL(3,2)
);

DESCRIBE salesman;

DROP TABLE salesman;

INSERT INTO salesman VALUES(
    5001, 'James Hoog', 'New York', 0.15
);
INSERT INTO salesman VALUES(
    5002, 'Nail Knite', 'Paris', 0.13
);
INSERT INTO salesman VALUES(
    5005, 'Pit Alex', 'London', 0.11
);
INSERT INTO salesman VALUES(
    5006, 'Mc Lyon', 'Paris', 0.14
);
INSERT INTO salesman VALUES(
    5007, 'Paul Adam', 'Rome', 0.13
);
INSERT INTO salesman VALUES(
    5003, 'Lauson Hen', 'San Jose', 0.12
);

SELECT * FROM salesman;


