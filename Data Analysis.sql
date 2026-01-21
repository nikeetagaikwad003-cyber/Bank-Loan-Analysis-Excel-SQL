Create database bank_loan_analysis
use bank_loan_analysis

create table customers (
  customer_id varchar(10) primary key,
  full_name varchar(100),
  age int,
  gender varchar(10),
  marital_status varchar(20),
  employment_type varchar(20),
  annual_income int,
  city varchar(50)
)
insert into customers VALUES
('C001', 'Rahul Sharma', 32, 'Male', 'Married', 'Salaried', 850000, 'Mumbai'),
('C002', 'Anita Verma', 28, 'Female', 'Single', 'Salaried', 620000, 'Pune'),
('C003', 'Suresh Patil', 45, 'Male', 'Married', 'Business', 1200000, 'Nagpur'),
('C004', 'Pooja Singh', 36, 'Female', 'Married', 'Salaried', 780000, 'Delhi'),
('C005', 'Amit Kulkarni', 50, 'Male', 'Married', 'Business', 1500000, 'Bangalore'),
('C006', 'Neha Joshi', 26, 'Female', 'Single', 'Salaried', 480000, 'Nashik')



create table loan_applications (
  loan_id varchar(10)  primary key,
  customer_id varchar(10),
  loan_type varchar(30),
  loan_amount int,
  loan_tenure_years int,
  interest_rate decimal(4,2),
  application_date date,
  loan_status varchar(20),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
)

insert into loan_applications values

('L001', 'C001', 'Home Loan', 2500000, 20, 8.50, '2023-03-15', 'Approved'),
('L002', 'C002', 'Personal Loan', 300000, 5, 13.00, '2023-06-10', 'Approved'),
('L003', 'C003', 'Business Loan', 1500000, 10, 11.50, '2023-01-25', 'Rejected'),
('L004', 'C004', 'Car Loan', 600000, 7, 9.50, '2023-09-05', 'Approved'),
('L005', 'C005', 'Business Loan', 3000000, 15, 12.00, '2023-02-12', 'Approved'),
('L006', 'C006', 'Personal Loan', 200000, 4, 14.00, '2023-11-20', 'Pending')



create table loan_payments (
  payment_id varchar(10) PRIMARY KEY,
  loan_id varchar(10),
  payment_date DATE,
  emi_amount INT,
  payment_status varchar(20),
  Foreign key (loan_id) References loan_applications(loan_id)
)
insert into loan_payments values
('P001', 'L001', '2024-01-05', 21500, 'Paid'),
('P002', 'L001', '2024-02-05', 21500, 'Paid'),
('P003', 'L002', '2024-01-10', 6900, 'Paid'),
('P004', 'L002', '2024-02-10', 6900, 'Missed'),
('P005', 'L004', '2024-01-12', 9800, 'Paid'),
('P006', 'L005', '2024-01-18', 32000, 'Paid')


create table credit_score (
  customer_id varchar(10),
  credit_score INT,
  risk_category varchar(20),
  Foreign key (customer_id) References customers(customer_id)
)

insert into credit_score values
('C001', 780, 'Low'),
('C002', 710, 'Medium'),
('C003', 640, 'High'),
('C004', 750, 'Low'),
('C005', 720, 'Medium'),
('C006', 680, 'Medium')

SELECT * FROM customers
SELECT * FROM loan_applications
SELECT * FROM loan_payments
SELECT * FROM credit_score

--Loan status
select loan_status, count(*) as total_loans
From loan_applications
group by loan_status

--Total Loan Amount by Loan Type
select loan_type, sum(loan_amount) as total_amount
From loan_applications
where loan_status = 'Approved'
group by loan_type

--High Risk Customers
select c.full_name, cs.credit_score, cs.risk_category
from customers c join credit_score cs on c.customer_id = cs.customer_id
where cs.risk_category = 'High'

--Customers Who Missed EMI
select distinct l.loan_id, c.full_name
from loan_payments p
JOIN loan_applications l on p.loan_id = l.loan_id
JOIN customers c on l.customer_id = c.customer_id
where p.payment_status = 'Missed'

--Income vs Loan Amount
select c.full_name, c.annual_income, l.loan_amount
from customers c
JOIN loan_applications l ON c.customer_id = l.customer_id



