-- Create the new database
DROP DATABASE IF EXISTS bizztrack_new;
CREATE DATABASE bizztrack_new;
USE bizztrack_new;

-- Create tables with proper constraints
CREATE TABLE department (
    dept_id INT NOT NULL AUTO_INCREMENT,
    dept_name VARCHAR(100) NOT NULL,
    dept_head VARCHAR(100) NOT NULL,
    PRIMARY KEY (dept_id)
);

CREATE TABLE employee (
    employee_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    dob DATE NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    hire_date DATE NOT NULL,
    dept_id INT,
    PRIMARY KEY (employee_id),
    FOREIGN KEY (dept_id) REFERENCES department(dept_id) ON DELETE SET NULL
);

CREATE TABLE team (
    team_id INT NOT NULL AUTO_INCREMENT,
    team_name VARCHAR(100) NOT NULL,
    team_leader VARCHAR(100) NOT NULL,
    PRIMARY KEY (team_id)
);

CREATE TABLE project (
    project_id INT NOT NULL AUTO_INCREMENT,
    project_name VARCHAR(100) NOT NULL,
    budget DECIMAL(12, 2) NOT NULL,
    deadline DATE NOT NULL,
    team_id INT,
    PRIMARY KEY (project_id),
    FOREIGN KEY (team_id) REFERENCES team(team_id) ON DELETE SET NULL
);

CREATE TABLE task (
    task_id INT NOT NULL AUTO_INCREMENT,
    task_name VARCHAR(100) NOT NULL,
    deadline DATE NOT NULL,
    priority ENUM('Low', 'Medium', 'High') DEFAULT 'Medium',
    project_id INT NOT NULL,
    PRIMARY KEY (task_id),
    FOREIGN KEY (project_id) REFERENCES project(project_id) ON DELETE CASCADE
);

CREATE TABLE asset (
    asset_id INT NOT NULL AUTO_INCREMENT,
    asset_name VARCHAR(100) NOT NULL,
    type VARCHAR(50) NOT NULL,
    status ENUM('Assigned', 'Available', 'Maintenance') DEFAULT 'Available',
    PRIMARY KEY (asset_id)
);

CREATE TABLE attendance (
    attendance_id INT NOT NULL AUTO_INCREMENT,
    employee_id INT NOT NULL,
    date DATE NOT NULL,
    status ENUM('Present', 'Absent', 'Leave') DEFAULT 'Present',
    PRIMARY KEY (attendance_id),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id) ON DELETE CASCADE
);

CREATE TABLE benefit (
    benefit_id INT NOT NULL AUTO_INCREMENT,
    benefit_name VARCHAR(100) NOT NULL,
    type VARCHAR(50) NOT NULL,
    PRIMARY KEY (benefit_id)
);

CREATE TABLE client (
    client_id INT NOT NULL AUTO_INCREMENT,
    client_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    company VARCHAR(100) NOT NULL,
    PRIMARY KEY (client_id)
);

CREATE TABLE leave (
    leave_id INT NOT NULL AUTO_INCREMENT,
    employee_id INT NOT NULL,
    leave_type ENUM('Sick', 'Casual', 'Maternity', 'Paternity') DEFAULT 'Casual',
    days_approved INT NOT NULL,
    PRIMARY KEY (leave_id),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id) ON DELETE CASCADE
);

CREATE TABLE location (
    location_id INT NOT NULL AUTO_INCREMENT,
    location_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    PRIMARY KEY (location_id)
);

CREATE TABLE payroll (
    payroll_id INT NOT NULL AUTO_INCREMENT,
    employee_id INT NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    tax_deduction DECIMAL(10, 2) NOT NULL,
    bonus DECIMAL(10, 2) DEFAULT 0.00,
    PRIMARY KEY (payroll_id),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id) ON DELETE CASCADE
);

CREATE TABLE role (
    role_id INT NOT NULL AUTO_INCREMENT,
    role_name VARCHAR(100) NOT NULL,
    salary_range VARCHAR(50) NOT NULL,
    PRIMARY KEY (role_id)
);

CREATE TABLE training (
    training_id INT NOT NULL AUTO_INCREMENT,
    topic VARCHAR(100) NOT NULL,
    duration INT NOT NULL,
    PRIMARY KEY (training_id)
);

-- Insert sample data
-- Department (5 entries)
INSERT INTO department (dept_name, dept_head) VALUES
('Engineering', 'John Smith'),
('Marketing', 'Jane Doe'),
('Sales', 'Mike Johnson'),
('HR', 'Emily Brown'),
('Finance', 'Sarah Davis');

-- Employee (20 entries)
INSERT INTO employee (name, email, phone, dob, salary, hire_date, dept_id) VALUES
('Alice Johnson', 'alice.johnson@example.com', '1234567890', '1990-05-15', 60000.00, '2020-01-10', 1),
('Bob Smith', 'bob.smith@example.com', '2345678901', '1985-08-22', 65000.00, '2019-03-15', 1),
('Charlie Brown', 'charlie.brown@example.com', '3456789012', '1992-11-30', 55000.00, '2021-06-01', 2),
('David Wilson', 'david.wilson@example.com', '4567890123', '1988-02-14', 70000.00, '2018-09-10', 2),
('Eve Davis', 'eve.davis@example.com', '5678901234', '1995-07-25', 50000.00, '2022-01-20', 3),
('Frank Harris', 'frank.harris@example.com', '6789012345', '1990-03-10', 62000.00, '2020-05-05', 3),
('Grace Lee', 'grace.lee@example.com', '7890123456', '1987-12-12', 68000.00, '2019-07-15', 4),
('Henry Clark', 'henry.clark@example.com', '8901234567', '1993-04-18', 53000.00, '2021-08-20', 4),
('Isabella Lewis', 'isabella.lewis@example.com', '9012345678', '1991-09-05', 71000.00, '2018-11-01', 5),
('James Walker', 'james.walker@example.com', '0123456789', '1986-06-30', 64000.00, '2020-02-25', 5),
('Kelly Young', 'kelly.young@example.com', '1234509876', '1994-01-22', 57000.00, '2021-03-10', 1),
('Liam Turner', 'liam.turner@example.com', '2345610987', '1989-10-15', 69000.00, '2019-04-05', 2),
('Mia Allen', 'mia.allen@example.com', '3456721098', '1996-08-08', 51000.00, '2022-05-15', 3),
('Noah King', 'noah.king@example.com', '4567832109', '1990-12-25', 66000.00, '2020-06-20', 4),
('Olivia Scott', 'olivia.scott@example.com', '5678943210', '1988-03-17', 72000.00, '2018-07-10', 5),
('Peter Green', 'peter.green@example.com', '6789054321', '1992-05-29', 58000.00, '2021-09-01', 1),
('Quinn Adams', 'quinn.adams@example.com', '7890165432', '1987-07-14', 67000.00, '2019-08-25', 2),
('Rachel Baker', 'rachel.baker@example.com', '8901276543', '1995-02-20', 52000.00, '2022-03-05', 3),
('Sam Carter', 'sam.carter@example.com', '9012387654', '1991-11-11', 73000.00, '2018-12-15', 4),
('Tina Evans', 'tina.evans@example.com', '0123498765', '1989-09-09', 59000.00, '2021-02-20', 5);

-- Team (5 entries)
INSERT INTO team (team_name, team_leader) VALUES
('Dev Team A', 'Alice Johnson'),
('Marketing Crew', 'Charlie Brown'),
('Sales Squad', 'Eve Davis'),
('HR Unit', 'Grace Lee'),
('Finance Group', 'Isabella Lewis');

-- Project (10 entries)
INSERT INTO project (project_name, budget, deadline, team_id) VALUES
('App Development', 50000.00, '2025-12-01', 1),
('Ad Campaign', 30000.00, '2025-08-15', 2),
('Sales Strategy', 40000.00, '2025-10-30', 3),
('Employee Training', 20000.00, '2025-07-01', 4),
('Budget Analysis', 35000.00, '2025-09-20', 5),
('Website Redesign', 45000.00, '2025-11-15', 1),
('Social Media Boost', 25000.00, '2025-06-30', 2),
('Market Expansion', 60000.00, '2025-12-31', 3),
('Compliance Audit', 15000.00, '2025-05-15', 4),
('Financial Report', 30000.00, '2025-08-01', 5);

-- Task (20 entries)
INSERT INTO task (task_name, deadline, priority, project_id) VALUES
('Design UI', '2025-11-01', 'High', 1),
('Write Backend', '2025-11-15', 'High', 1),
('Create Ad Copy', '2025-07-15', 'Medium', 2),
('Design Graphics', '2025-07-30', 'Medium', 2),
('Plan Outreach', '2025-09-30', 'High', 3),
('Train Team', '2025-10-15', 'Medium', 3),
('Develop Modules', '2025-06-15', 'High', 4),
('Schedule Sessions', '2025-06-01', 'Low', 4),
('Analyze Expenses', '2025-08-20', 'Medium', 5),
('Forecast Revenue', '2025-09-01', 'Medium', 5),
('Update Homepage', '2025-10-15', 'High', 6),
('Optimize SEO', '2025-10-30', 'Medium', 6),
('Run Campaign', '2025-06-15', 'High', 7),
('Track Metrics', '2025-06-25', 'Low', 7),
('Research Markets', '2025-11-30', 'High', 8),
('Draft Proposal', '2025-12-15', 'Medium', 8),
('Review Policies', '2025-04-30', 'High', 9),
('Submit Report', '2025-05-10', 'Medium', 9),
('Compile Data', '2025-07-15', 'Medium', 10),
('Present Findings', '2025-07-30', 'Low', 10);

-- Asset (10 entries)
INSERT INTO asset (asset_name, type, status) VALUES
('Laptop A', 'Electronics', 'Assigned'),
('Laptop B', 'Electronics', 'Available'),
('Projector X', 'Equipment', 'Maintenance'),
('Desk 101', 'Furniture', 'Available'),
('Chair 102', 'Furniture', 'Assigned'),
('Monitor 1', 'Electronics', 'Assigned'),
('Printer Y', 'Equipment', 'Available'),
('