CREATE TABLE employees (
    employeeNumber INT PRIMARY KEY AUTO_INCREMENT,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    department VARCHAR(50),
    salary DECIMAL(10,2),
    hireDate DATE
);

INSERT INTO employees (firstName, lastName, email, department, salary, hireDate) VALUES
('John', 'Doe', 'john.doe@company.com', 'IT', 65000.00, '2020-01-15'),
('Jane', 'Smith', 'jane.smith@company.com', 'HR', 58000.00, '2019-03-10'),
('Bob', 'Johnson', 'bob.johnson@company.com', 'Finance', 72000.00, '2018-07-22'),
('Alice', 'Williams', 'alice.williams@company.com', 'IT', 68000.00, '2021-05-08'),
('Charlie', 'Brown', 'charlie.brown@company.com', 'Marketing', 55000.00, '2022-02-14');

-- Exercise 1
INSERT INTO employees (firstName, lastName, email, department, salary, hireDate) 
VALUES ('Test', 'User', NULL, 'IT', 50000.00, '2023-01-01');

-- Exercise 2
UPDATE employees SET employeeNumber = employeeNumber - 20;
UPDATE employees SET employeeNumber = employeeNumber + 20;

-- Exercise 3
ALTER TABLE employees 
ADD COLUMN age INT,
ADD CONSTRAINT chk_age CHECK (age >= 16 AND age <= 70);

-- Exercise 5
ALTER TABLE employees 
ADD COLUMN lastUpdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
ADD COLUMN lastUpdateUser VARCHAR(50);

DELIMITER $$
CREATE TRIGGER tr_employees_insert
    BEFORE INSERT ON employees
    FOR EACH ROW
BEGIN
    SET NEW.lastUpdate = NOW();
    SET NEW.lastUpdateUser = USER();
END$$

CREATE TRIGGER tr_employees_update
    BEFORE UPDATE ON employees
    FOR EACH ROW
BEGIN
    SET NEW.lastUpdate = NOW();
    SET NEW.lastUpdateUser = USER();
END$$
DELIMITER ;