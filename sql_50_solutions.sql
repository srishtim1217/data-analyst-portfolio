problem 1 : Customers Not Referred by ID = 2
SELECT name
FROM customer
WHERE referee_id != 2 OR referee_id IS NULL;

problem 2 : Big Countries
SELECT name, population, area
FROM world
WHERE area >= 3000000 OR population >= 25000000;

problem 3 : Invalid Tweets (Length > 15)
SELECT tweet_id
FROM tweets
WHERE LENGTH(content) > 15;

Problem 4: Employees Unique ID (Basic Join)
SELECT name, unique_id 
FROM employees e
LEFT JOIN employeeuni u
ON e.id = u.id;

problem 5: Product Sales Details
SELECT product_name, year, price
FROM sales s
LEFT JOIN product p
ON s.product_id = p.product_id;

problem 6 : Customers with No Transactions
SELECT v.customer_id, 
COUNT(v.visit_id) AS count_no_trans
FROM visits v
LEFT JOIN transactions t
ON v.visit_id = t.visit_id 
WHERE t.transaction_id IS NULL
GROUP BY v.customer_id;

Problem 7 : Rising Temperature
SELECT w1.id
FROM weather w1
JOIN weather w2
ON DATEDIFF(w1.recordDate, w2.recordDate) = 1
WHERE w1.temperature > w2.temperature;

-- Problem 8: Recyclable and Low Fat Products
select product_id
from products
where low_fats = 'Y' and recyclable = 'Y';

-- Problem 9: Article Views I
select distinct author_id as ID
from views
where author_id = viewer_id
order by author_id;

Problem 10: Processing Time per Machine
SELECT a.machine_id,
ROUND(AVG(b.timestamp - a.timestamp), 3) AS processing_time
FROM activity a
JOIN activity b
ON a.machine_id = b.machine_id
AND a.process_id = b.process_id
AND a.activity_type = 'start'

Problem 11: Employees with Bonus < 1000 or NULL
SELECT DISTINCT name, bonus
FROM employee e
LEFT JOIN bonus b
ON e.empid = b.empid
WHERE bonus < 1000 OR bonus IS NULL;

Problem 12: Students and Exams Attendance
SELECT t1.student_id, t1.student_name, t2.subject_name,
COUNT(t3.subject_name) AS attended_exams
FROM students t1
CROSS JOIN subjects t2
LEFT JOIN examinations t3
ON t1.student_id = t3.student_id
AND t2.subject_name = t3.subject_name
GROUP BY t1.student_id, t1.student_name, t2.subject_name
ORDER BY t1.student_id;

Problem 13: Managers with ≥ 5 Employees
SELECT e2.name
FROM employee e1
JOIN employee e2
ON e1.managerid = e2.id
GROUP BY e2.name
HAVING COUNT(*) >= 5;

Problem 14: Confirmation Rate
SELECT s.user_id,
ROUND(AVG(
CASE 
WHEN c.action = 'confirmed' THEN 1
ELSE 0
END
), 2) AS confirmation_rate
FROM signups s
LEFT JOIN confirmations c
ON s.user_id = c.user_id
GROUP BY s.user_id;

Problem 15: Non-Boring Movies with Odd ID
SELECT id, movie, description, rating
FROM cinema
WHERE id % 2 = 1
AND description != 'boring'
ORDER BY rating DESC;

Problem 16: Average Selling Price
SELECT p.product_id,
ROUND(SUM(p.price * u.units) / SUM(u.units), 2) AS average_price
FROM prices p
LEFT JOIN UnitsSold u
ON p.product_id = u.product_id
AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id;

Problem 17: Average Experience per Project
SELECT p.project_id,
ROUND(AVG(e.experience_years), 2) AS average_years
FROM project p
LEFT JOIN employee e
ON p.employee_id = e.employee_id
GROUP BY p.project_id;

Problem 18: Contest Participation Percentage
SELECT contest_id,
ROUND(COUNT(DISTINCT user_id) * 100 /
(SELECT COUNT(*) FROM users), 2) AS percentage
FROM register
GROUP BY contest_id
ORDER BY percentage DESC;

Problem 19: Query Quality and Poor Query Percentage
SELECT query_name,
ROUND(AVG(rating / position), 2) AS quality,
ROUND(AVG(rating < 3) * 100, 2) AS poor_query_percentage
FROM queries
GROUP BY query_name;

Problem 20: Monthly Transactions Summary
SELECT DATE_FORMAT(trans_date, '%Y-%m') AS month,
country,
COUNT(state) AS trans_count,
COUNT(CASE WHEN state = 'approved' THEN 1 END) AS approved_count,
SUM(amount) AS trans_total_amount,
SUM(CASE 
WHEN state = 'approved' THEN amount
ELSE 0 
END) AS approved_total_amount
FROM transactions
GROUP BY DATE_FORMAT(trans_date, '%Y-%m'), country;
AND b.activity_type = 'end'
GROUP BY a.machine_id;
