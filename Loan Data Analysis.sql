create database SQLPROJECT5;
use SQLPROJECT5;
show tables;
rename table `loan details` to Loan_Data;
select * from Loan_Data;


## EDA
select * 
from Loan_Data 
limit 5;

describe Loan_Data;
 
select count(*) as total_data
from Loan_Data;

select count(distinct id) 
from Loan_Data;

select distinct states
from Loan_Data;

select distinct application_type as application_types
from Loan_Data;

select distinct grade as grades
from Loan_Data;

select min(issue_date) as date_from_data_starts, max(issue_date) as date_upto_dataloaded
from Loan_Data;

select distinct laon_status as Loan_Status
from Loan_Data;

select annual_income, count(id) as no_of_customers
from Loan_Data
group by annual_income
order by annual_income;

select concat(round(sum(total_payment)/100000,0)," lakhs") as total_amount
from Loan_Data;



## DATA CLEANING
select count(id) as count
from Loan_Data
where id=null or
	address_state=null or
	application_type=null or
	emp_length=null or
	emp_title=null or
	grade=null or
	home_ownership=null or
	issue_date=null or
	last_credit_pull_date=null or
	last_payment_date=null or
	loan_status=null or
	next_payment_date=null or
	member_id=null or
	purpose=null or
	sub_grade=null or
	term=null or
	verification_status=null or
	annual_income=null or
	dti=null or
	installment=null or
	int_rate=null or
	loan_amount=null or
	total_acc=null or
	total_payment=null;

delete from Loan_Data 
where id is null or
	address_state is null or
	application_type is null or
	emp_length is null or
	emp_title is null or
	grade is null or
	home_ownership is null or
	issue_date is null or
	last_credit_pull_date is null or
	last_payment_date is null or
	loan_status is null or
	next_payment_date is null or
	member_id is null or
	purpose is null or
	sub_grade is null or
	term is null or
	verification_status is null or
	annual_income is null or
	dti is null or
	installment is null or
	int_rate is null or
	loan_amount is null or
	total_acc is null or
	total_payment is null;




## ANALYSIS
#Total Loan Applications
select count(*) as total_applications
from Loan_Data;
select count(*) as recent_month_count
from Loan_Data
where date_format(issue_date,'%y-%m')=(select date_format(max(issue_date),'%y-%m') from Loan_Data);
# Total Funded Amount
select sum(loan_amount) as funded_amount 
from Loan_Data;
# Sum of total_payment (repayments made).
select sum(total_payment) as total_amount_paid
from Loan_Data;
# Average Interest Rate
select avg(int_rate) as avg_interest
from Loan_Data;
# Average Debt-to-Income Ratio (DTI)
select avg(dti) as avg_interest
from Loan_Data;
# Good loans
select sum(case when loan_status="Charged Off" or loan_status="Fully Paid" then 1 else 0 end) as good_loans
from Loan_Data;
select round(sum(case when loan_status="Charged Off" or loan_status="Fully Paid" then 1 else 0 end)/count(*),2)*100 as good_loan_percentage
from Loan_Data;
select sum(case when loan_status="Charged Off" or loan_status="Fully Paid" then loan_amount else 0 end) as good_loans_loanamount
from Loan_Data;
select sum(case when loan_status="Charged Off" or loan_status="Fully Paid" then total_payment else 0 end) as good_loans_paidamount
from Loan_Data;
select * from Loan_Data;
# Bad Loans
select sum(case when loan_status="Charged Off" or loan_status="Fully Paid" then 0 else 1 end) as bad_customers
from Loan_Data;
select round(sum(case when loan_status="Charged Off" or loan_status="Fully Paid" then 0 else 1 end)/count(*),2)*100 as bad_loans_percentage
from Loan_Data;
select sum(case when loan_status="Charged Off" or loan_status="Fully Paid" then 0 else loan_amount end) as bad_loans_loanamount
from Loan_Data;
select sum(case when loan_status="Charged Off" or loan_status="Fully Paid" then 0 else total_payment end) as bad_loans_paidamount
from Loan_Data;
# Details by loan_status
select loan_status, sum(loan_amount) as Total_Loanamount, sum(total_payment) as Total_TotalPayment
from Loan_Data
group by loan_status;
# Monthly Trends by Issue Date (Line Chart)
select monthname(str_to_date(issue_date,'%y-%m-%d')) as datee, sum(total_payment) as TotalPaidAmount
from Loan_Data
group by monthname(str_to_date(issue_date,'%y-%m-%d')),month(str_to_date(issue_date,'%y-%m-%d'))
order by month(str_to_date(issue_date,'%y-%m-%d'));
# Regional Analysis by State (Filled Map)
select address_state, sum(loan_amount) as Total_Loan_Amount, sum(total_payment) as Total_AMount_paid
from Loan_Data
group by address_state;
# Loan Term Analysis (Donut Chart)
select term as duration, sum(loan_amount) as Total_LoanAmount, sum(total_payment) as Total_AmountPaid
from Loan_Data
group by term;
# Employee Length Analysis (Bar Chart)
select emp_length, sum(loan_amount) as total_loanamount, sum(total_payment) as Total_amountpaid, sum(total_payment-loan_amount) as recovery
from Loan_Data
group by emp_length;
# Loan Purpose Breakdown (Bar Chart)
select purpose, sum(loan_amount) as Total_LoanAmount
from Loan_Data
group by purpose;
# Home Ownership Analysis (Tree Map)
select home_ownership, sum(loan_amount) as Total_LoaNAmount, sum(total_payment) as Total_AmountPaid
from Loan_Data
group by home_ownership;
