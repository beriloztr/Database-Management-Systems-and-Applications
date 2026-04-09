
CREATE OR REPLACE VIEW find_total AS
    SELECT c.CID, c.CUSTNAME, c.CUSTSURNAME, SUM(QUANTITY) "#of Items Bought"
    FROM CUST c,RECEIPT r, RECEIPT_DETAILS rd
    WHERE c.CID = r.CID and r.RID = rd.RID
    GROUP BY c.CID, c.CUSTNAME, c.CUSTSURNAME
    order by c.CID;
    
CREATE OR REPLACE VIEW product_report AS
    SELECT p.PID, p.PNAME, sum(quantıty) "#ofSold"
    FROM PRODUCT p, RECEIPT_DETAILS rd
    Where p.PID = rd.PID
    GROUP BY p.PID, p.PNAME
    order by p.PID, p.PNAME asc; 
    
CREATE OR REPLACE FUNCTION find_total_sales (sale_year IN NUMBER)
RETURN NUMBER
AS
total_sale number := 0;
BEGIN 
SELECT SUM(TOTAL) INTO total_sale
FROM RECEIPT
WHERE EXTRACT(YEAR FROM RDATE) = sale_year;
RETURN total_sale;
END;
/

SET SERVEROUTPUT ON;
ACCEPT s_year PROMPT 'Enter the year to find the total sales: ';
BEGIN
dbms_output.put_line('Sales in ' || find_total_sales(&s_year));
END;
/


CREATE OR REPLACE FUNCTION total_shopping
RETURN number
AS
    CURSOR cur IS
        SELECT CUSTNAME, CUSTSURNAME, SUM(TOTAL) total
        FROM CUST c, RECEIPT r
        WHERE c.CID = r.CID
        GROUP BY CUSTNAME, CUSTSURNAME;
c_row cur%ROWTYPE;
ccount number:= 0;
coupon number:= 0;
BEGIN
OPEN cur;
LOOP
FETCH cur INTO c_row;
EXIT WHEN cur%NOTFOUND;
CASE 
WHEN c_row.total >= 300 THEN
coupon := c_row.total*0.20;
ccount := ccount + 1;
WHEN c_row.total <300 and c_row.total >= 200 THEN
coupon := c_row.total*0.10;
ccount := ccount + 1;
WHEN c_row.total <200 and c_row.total >= 100 THEN
coupon := c_row.total*0.05;
ccount := ccount + 1;
ELSE
coupon := 0;
END CASE;
dbms_output.put_line(c_row.CUSTNAME || c_row.CUSTSURNAME ||'Your total shopping amount is:' || c_row.total);


IF COUPON = 0 THEN
dbms_output.put_line('Your total shopping amount is < 100, sorry');
ELSE 
dbms_output.put_line('YOU WON'|| c_row.total || 'TL MARKET COUPON!');
END IF;

END LOOP;
CLOSE cur;
RETURN ccount;
END;
/



SET SERVEROUTPUT ON;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Total number of coupons: '||market_coupon());
END;
/



