-- Exercise 2: Error Handling

-- Scenario 1: SafeTransferFunds Procedure
CREATE OR REPLACE PROCEDURE SafeTransferFunds(
    p_from_account_id IN Accounts.AccountID%TYPE,
    p_to_account_id IN Accounts.AccountID%TYPE,
    p_amount IN NUMBER
) IS
    v_from_balance NUMBER;
BEGIN
    SELECT Balance INTO v_from_balance FROM Accounts WHERE AccountID = p_from_account_id FOR UPDATE;
    IF v_from_balance < p_amount THEN
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient funds in the source account.');
    ELSE
        UPDATE Accounts SET Balance = Balance - p_amount WHERE AccountID = p_from_account_id;
        UPDATE Accounts SET Balance = Balance + p_amount WHERE AccountID = p_to_account_id;
        COMMIT;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

-- Scenario 2: UpdateSalary Procedure
CREATE OR REPLACE PROCEDURE UpdateSalary(
    p_employee_id IN Employees.EmployeeID%TYPE,
    p_percentage IN NUMBER
) IS
    v_salary NUMBER;
BEGIN
    SELECT Salary INTO v_salary FROM Employees WHERE EmployeeID = p_employee_id FOR UPDATE;
    UPDATE Employees SET Salary = Salary + (Salary * p_percentage / 100) WHERE EmployeeID = p_employee_id;
    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Employee ID does not exist.');
        ROLLBACK;
END;
/

-- Scenario 3: AddNewCustomer Procedure
CREATE OR REPLACE PROCEDURE AddNewCustomer(
    p_customer_id IN Customers.CustomerID%TYPE,
    p_name IN Customers.Name%TYPE,
    p_dob IN Customers.DOB%TYPE,
    p_balance IN Customers.Balance%TYPE
) IS
BEGIN
    INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
    VALUES (p_customer_id, p_name, p_dob, p_balance, SYSDATE);
    COMMIT;
