/* Question 1
Show the first and last name of each customer and whether or not the customer was referred by another customer.  If they were referred, display "Referred," and if not, display "Not Referred." */

SELECT INITCAP(CONCAT(CONCAT(firstname,' '),
lastname)) "Customer Name",NVL2(REFERRED,'Referred', 
'Not Referred')
FROM customers;

/* Question 2
Determine the amount of profit for order number 1008.*/
SELECT title, TO_CHAR(QUANTITY*(PAIDEACH-COST), '$999.99') "Profit"
FROM orders o JOIN orderitems oi USING (order#) 
JOIN books b USING (isbn)WHERE order#=1008;

/* Question 3
Display each customer number along with the number of orders the customer has made. Display the results in order by customer number.  Include customers with no orders. */
SELECT O.Order#,COUNT(C.Order#)
as "Number Of Orders"
FROM Customers Cleft JOIN Orders OON O.Customer# = C.Customer#
Group by C.Customer#;

/* Question 4
Show the names of the customers living in Florida who have placed an order totaling more than $50.*/

SELECT DISTINCT firstname, lastnameFROM customers, books, orders, orderitems
WHERE customers.customer# = orders.customer# 
AND orders.order# = orderitems.order# 
AND orderitems.ISBN = books.ISBN AND (state = 'FL')
GROUP BY orders.order#, firstname, lastname
HAVING SUM(retail*quantity) > 50;

/* Question 5
Shows the title(s) of the book most frequently purchased by the customers in the database.*/

SELECT title
FROM books JOIN orderitems USING(isbn)
WHERE isbn IN
(SELECT isbn FROM orderitems GROUP BY isbn
HAVING SUM(quantity)=(SELECT MAX(COUNT(*))FROM orderitems GROUP BY isbn));

/* Question 6
List the last name, first name, address, city, state, and zip for customers whose last names start with M.*/


SELECT LASTNAME,FIRSTNAME,ADDRESS,CITY,STATE,ZIP
FROM customers 
WHERE LASTNAME LIKE '%M';

/* Question 7
Display the titles of books in the family life and children categories */

SELECT TITLE 
FROM BOOKS 
WHERE CATEGORY IN ('FAMILY LIFE','CHILDREN');

/* Question 8
List the order number and order date of each order that has NOT shipped.*/

SELECT ORDER# ,ORDERDATE
FROM ORDERS 
WHERE shipdate IS NULL
ORDER BY ORDERDATE;

/* Question 9
Display the names of the customers who purchased the book with the highest retail price in the database. Capitalize the first and last names.*/

SELECT INITCAP(firstname)AS "First Name",
INITCAP(lastname)AS "Last Name"
FROM customers
JOIN orders USING (customer#)
JOIN orderitems USING (order#)
JOIN books USING (isbn)
WHERE books.retail = (SELECT MAX(books.retail)FROM books);

/* Question 10
Display the first name and last name of each author along with the number of books he or she has written. Capitalize the first and last names.*/

SELECT INITCAP(FNAME)"First Name",INITCAP(LNAME)"Last Name", COUNT(BOOKAUTHOR.ISBN) AS "Number of books written"
FROM AUTHOR,BOOKAUTHOR,BOOKS WHERE
AUTHOR.AUTHORID=BOOKAUTHOR.AUTHORID AND
BOOKAUTHOR.ISBN=BOOKS.ISBN
GROUP BY AUTHOR.AUTHORID,LNAME,FNAME;


