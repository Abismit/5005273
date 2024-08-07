-- Exercise 1: Control Structures

-- Scenario 1: Apply a discount to loan interest rates for customers above 60 years old
DECLARE
    CURSOR customer_cursor IS
        SELECT CustomerID, EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM DOB) AS Age
        FROM Customers;
    v_customer_id Customers.CustomerID%TYPE;
    v_age NUMBER;
BEGIN
    OPEN customer_cursor;
    LOOP
        FETCH customer_cursor INTO v_customer_id, v_age;
        EXIT WHEN customer_cursor%NOTFOUND;
        IF v_age > 60 THEN
            UPDATE Loans
            SET InterestRate = InterestRate - 1
            WHERE CustomerID = v_customer_id;
        END IF;
    END LOOP;
    CLOSE customer_cursor;
END;
/

-- Scenario 2: Set IsVIP to TRUE for customers with a balance over $10,000
DECLARE
    CURSOR customer_cursor IS
        SELECT CustomerID, Balance
        FROM Customers;
    v_customer_id Customers.CustomerID%TYPE;
    v_balance NUMBER;
BEGIN
    OPEN customer_cursor;
    LOOP
        FETCH customer_cursor INTO v_customer_id, v_balance;
        EXIT WHEN customer_cursor%NOTFOUND;
        IF v_balance > 10000 THEN
            UPDATE Customers
            SET IsVIP = 'TRUE'
            WHERE CustomerID = v_customer_id;
        END IF;
    END LOOP;
    CLOSE customer_cursor;
END;
/

-- Scenario 3: Send reminders to customers whose loans are due within the next 30 days
DECLARE
    CURSOR loan_cursor IS
        SELECT LoanID, CustomerID, EndDate
        FROM Loans
        WHERE EndDate BETWEEN SYSDATE AND SYSDATE + 30;
    v_loan_id Loans.LoanID%TYPE;
    v_customer_id Loans.CustomerID%TYPE;
    v_end_date DATE;
BEGIN
    OPEN loan_cursor;
    LOOP
        FETCH loan_cursor INTO v_loan_id, v_customer_id, v_end_date;
        EXIT WHEN loan_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Reminder: Loan ' || v_loan_id || ' for Customer ' || v_customer_id || ' is due on ' || v_end_date);
    END LOOP;
    CLOSE loan_cursor;
END;
/
