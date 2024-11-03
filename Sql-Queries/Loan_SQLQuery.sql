-- Retrieve all data from the bank_loan_data table
SELECT * FROM bank_loan_data;

-- Count the total number of loan applications in the bank_loan_data table
SELECT COUNT(id) AS Total_Applications FROM bank_loan_data;

-- Count the number of loan applications issued in December
SELECT COUNT(id) AS Total_Applications FROM bank_loan_data
WHERE MONTH(issue_date) = 12;

-- Count the number of loan applications issued in November
SELECT COUNT(id) AS Total_Applications FROM bank_loan_data
WHERE MONTH(issue_date) = 11;

-- Calculate the total funded loan amount for all applications
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data;

-- Calculate the total funded loan amount for applications issued in December
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data
WHERE MONTH(issue_date) = 12;

-- Calculate the total funded loan amount for applications issued in November
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data
WHERE MONTH(issue_date) = 11;

-- Calculate the total amount collected across all loans
SELECT SUM(total_payment) AS Total_Amount_Collected FROM bank_loan_data;

-- Calculate the total amount collected for loans issued in December
SELECT SUM(total_payment) AS Total_Amount_Collected FROM bank_loan_data
WHERE MONTH(issue_date) = 12;

-- Calculate the total amount collected for loans issued in November
SELECT SUM(total_payment) AS Total_Amount_Collected FROM bank_loan_data
WHERE MONTH(issue_date) = 11;

-- Calculate the average interest rate across all loans (multiplied by 100 for percentage format)
SELECT AVG(int_rate)*100 AS Avg_Int_Rate FROM bank_loan_data;

-- Calculate the average interest rate for loans issued in December
SELECT AVG(int_rate)*100 AS MTD_Avg_Int_Rate FROM bank_loan_data
WHERE MONTH(issue_date) = 12;

-- Calculate the average interest rate for loans issued in November
SELECT AVG(int_rate)*100 AS PMTD_Avg_Int_Rate FROM bank_loan_data
WHERE MONTH(issue_date) = 11;

-- Calculate the average debt-to-income (DTI) ratio across all loans (multiplied by 100 for percentage format)
SELECT AVG(dti)*100 AS Avg_DTI FROM bank_loan_data;

-- Calculate the average debt-to-income (DTI) ratio for loans issued in December
SELECT AVG(dti)*100 AS MTD_Avg_DTI FROM bank_loan_data
WHERE MONTH(issue_date) = 12;

-- Calculate the average debt-to-income (DTI) ratio for loans issued in November
SELECT AVG(dti)*100 AS PMTD_Avg_DTI FROM bank_loan_data
WHERE MONTH(issue_date) = 11;

-- Calculate the percentage of "Good" loans (loans that are either fully paid or current)
SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / 
	COUNT(id) AS Good_Loan_Percentage
FROM bank_loan_data;

-- Count the number of "Good" loan applications
SELECT COUNT(id) AS Good_Loan_Applications FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- Calculate the total funded amount for "Good" loans
SELECT SUM(loan_amount) AS Good_Loan_Funded_amount FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- Calculate the total amount received from "Good" loans
SELECT SUM(total_payment) AS Good_Loan_amount_received FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- Calculate the percentage of "Bad" loans (loans that are charged off)
SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
	COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data;

-- Count the number of "Bad" loan applications
SELECT COUNT(id) AS Bad_Loan_Applications FROM bank_loan_data
WHERE loan_status = 'Charged Off';

-- Calculate the total funded amount for "Bad" loans
SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount FROM bank_loan_data
WHERE loan_status = 'Charged Off';

-- Calculate the total amount received from "Bad" loans
SELECT SUM(total_payment) AS Bad_Loan_amount_received FROM bank_loan_data
WHERE loan_status = 'Charged Off';

-- Summarize loan count, amount received, funded amount, average interest rate, and DTI ratio by loan status
SELECT
    loan_status,
    COUNT(id) AS LoanCount,
    SUM(total_payment) AS Total_Amount_Received,
    SUM(loan_amount) AS Total_Funded_Amount,
    AVG(int_rate * 100) AS Interest_Rate,
    AVG(dti * 100) AS DTI
FROM
    bank_loan_data
GROUP BY
    loan_status;

-- Calculate month-to-date (MTD) total amount received and funded amount for each loan status in December
SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status;

-- Summarize loan applications, funded amount, and amount received by month, ordered by month
SELECT 
	MONTH(issue_date) AS Month_Munber, 
	DATENAME(MONTH, issue_date) AS Month_name, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date);

-- Summarize loan applications, funded amount, and amount received by state, ordered by state
SELECT 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state;

-- Summarize loan applications, funded amount, and amount received by loan term, ordered by term
SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY term
ORDER BY term;

-- Summarize loan applications, funded amount, and amount received by employee length, ordered by employee length
SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length;

-- Summarize loan applications, funded amount, and amount received by loan purpose, ordered by purpose
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY purpose
ORDER BY purpose;

-- Summarize loan applications, funded amount, and amount received by home ownership, ordered by home ownership
SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY home_ownership;

-- Summarize loan applications, funded amount, and amount received by purpose for loans with grade 'A,' ordered by purpose
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose;
