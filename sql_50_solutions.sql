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

Problem 21: Products Sold in February (≥100 units)
SELECT p.product_name, SUM(o.unit) AS unit
FROM products p
LEFT JOIN orders o
ON p.product_id = o.product_id
WHERE MONTH(o.order_date) = 2
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100;

Problem 22: Daily Sold Products List
SELECT sell_date,
COUNT(DISTINCT product) AS num_sold,
GROUP_CONCAT(DISTINCT product ORDER BY product) AS products
FROM activities
GROUP BY sell_date;

Problem 23: Second Highest Salary
SELECT (
    SELECT DISTINCT salary
    FROM employee
    ORDER BY salary DESC
    LIMIT 1 OFFSET 1
) AS SecondHighestSalary;

Problem 24: Delete Duplicate Emails
DELETE p1
FROM person p1
JOIN person p2
ON p1.email = p2.email
AND p1.id > p2.id;

Problem 25: Patients with Diabetes (DIAB1)
SELECT patient_id, patient_name, conditions
FROM Patients
WHERE conditions LIKE '%DIAB1%';

Problem 26: Capitalize User Names
SELECT user_id,
CONCAT(
    UPPER(LEFT(name,1)),
    LOWER(SUBSTRING(name,2))
) AS name
FROM users;

Problem 27: Top 3 Salaries per Department
SELECT Department, Employee, Salary 
FROM(
    SELECT 
    d.name AS department,
    e.name AS employee,
    e.salary,
    DENSE_RANK() OVER (
        PARTITION BY d.name 
        ORDER BY salary DESC
    ) AS ranks
    FROM employee e
    LEFT JOIN department d
    ON e.departmentID = d.ID
) t
WHERE ranks <= 3;

Problem 28: Insurance TIV Calculation
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM (
    SELECT *,
    COUNT(*) OVER (PARTITION BY tiv_2015) AS a,
    COUNT(*) OVER (PARTITION BY lat, lon) AS b
    FROM insurance
) t
WHERE a > 1 
AND b = 1;

Problem 29: Most Active User (Requests)
SELECT id, COUNT(*) AS num
FROM (
    SELECT requester_id AS id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id FROM RequestAccepted
) t
GROUP BY id
ORDER BY num DESC
LIMIT 1;

Problem 30: 7-Day Moving Average (Restaurant Growth)
SELECT visited_on,
SUM(amount) OVER (
    ORDER BY visited_on
    ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
) AS amount,
ROUND(
    AVG(amount) OVER (
        ORDER BY visited_on
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ), 2
) AS average_amount
FROM (
    SELECT visited_on, SUM(amount) AS amount
    FROM customer
    GROUP BY visited_on
) t
ORDER BY visited_on
LIMIT 6, 100;

Problem 31: Count Subjects per Teacher
SELECT teacher_id, COUNT(DISTINCT subject_id) AS cnt
FROM teacher
GROUP BY teacher_id;

Problem 32: First Year Sales
SELECT s.product_id, s.year AS first_year, s.quantity, s.price
FROM sales s
JOIN (
    SELECT product_id, MIN(year) AS first_year
    FROM sales
    GROUP BY product_id
) t
ON s.product_id = t.product_id
AND s.year = t.first_year;

Problem 33: Classes with ≥ 5 Students
SELECT class
FROM courses
GROUP BY class
HAVING COUNT(student) >= 5;

Problem 34: Followers Count per User
SELECT user_id, COUNT(follower_id) AS followers_count
FROM followers
GROUP BY user_id
ORDER BY user_id;

Problem 35: Largest Unique Number
SELECT MAX(num) AS num
FROM (
    SELECT num
    FROM MyNumbers
    GROUP BY num
    HAVING COUNT(num) = 1
) t;

Problem 36: Customers Who Bought All Products
SELECT c.customer_id
FROM Customer c
LEFT JOIN product p
ON c.product_key = p.product_key
GROUP BY c.customer_id
HAVING COUNT(DISTINCT p.product_key) = (
    SELECT COUNT(*) FROM product
);

Problem 37: Employees Reporting Stats
SELECT t1.employee_id, t1.name,
COUNT(t2.reports_to) AS reports_count,
ROUND(AVG(t2.age), 0) AS average_age
FROM Employees t1
JOIN Employees t2
ON t1.employee_id = t2.reports_to
GROUP BY t1.employee_id, t1.name
ORDER BY t1.employee_id;

Problem 38: Primary Department for Each Employee
SELECT employee_id, department_id
FROM Employee
WHERE primary_flag = 'Y'

UNION ALL

SELECT employee_id, department_id
FROM Employee
GROUP BY employee_id, department_id
HAVING COUNT(employee_id) = 1;

Problem 39: Triangle Validation
SELECT x, y, z,
CASE 
WHEN x + y > z AND y + z > x AND x + z > y
THEN 'Yes' 
ELSE 'No'
END AS triangle
FROM triangle;

Problem 40: User with Highest Rating & Top Movie (Feb 2020)
(SELECT u.name AS results
FROM users u
LEFT JOIN movierating mr
ON u.user_id = mr.user_id
WHERE mr.rating = (
    SELECT MAX(mr.rating) FROM movierating
)
GROUP BY u.name
ORDER BY MAX(mr.rating) DESC, u.name 
LIMIT 1)

UNION ALL

(SELECT m.title AS results
FROM movies m
JOIN movierating mr
ON m.movie_id = mr.movie_id
WHERE YEAR(created_at) = 2020
AND MONTH(created_at) = 2
GROUP BY m.title 
ORDER BY AVG(mr.rating) DESC, m.title ASC
LIMIT 1);

Problem 41: Swap Seats
SELECT
CASE 
WHEN id % 2 = 1 AND id <> (SELECT MAX(id) FROM seat) THEN id + 1
WHEN id % 2 = 0 THEN id - 1
ELSE id 
END AS id, student
FROM seat
ORDER BY id;

Problem 42: Employees with Missing Manager
SELECT employee_id
FROM employees
WHERE salary < 30000 
AND manager_id NOT IN (
    SELECT employee_id FROM employees
)
ORDER BY employee_id;

Problem 43: Salary Categories Count
SELECT 
"Low Salary" AS category,
COUNT(CASE WHEN income < 20000 THEN 1 END) AS accounts_count
FROM accounts 

UNION ALL

SELECT 
"Average Salary" AS category,
COUNT(CASE WHEN income BETWEEN 20000 AND 50000 THEN 1 END) AS accounts_count
FROM accounts 

UNION ALL

SELECT 
"High Salary" AS category,
COUNT(CASE WHEN income > 50000 THEN 1 END) AS accounts_count
FROM accounts;

Problem 44: Last Person Within Weight Limit
SELECT person_name
FROM(
    SELECT person_name, turn,
    SUM(weight) OVER (ORDER BY turn) AS total_weight
    FROM Queue
) t
WHERE total_weight <= 1000
ORDER BY turn DESC 
LIMIT 1;

Problem 45: Daily Active Users
SELECT activity_date AS day,
COUNT(DISTINCT user_id) AS active_users
FROM activity
WHERE activity_date BETWEEN '2019-06-28' AND '2019-07-27'
GROUP BY activity_date;

Problem 46: Consecutive Numbers
SELECT DISTINCT num AS ConsecutiveNums
FROM(
    SELECT 
    num,
    LAG(num,1) OVER (ORDER BY id) AS prev1,
    LAG(num,2) OVER (ORDER BY id) AS prev2
    FROM logs
) t
WHERE num = prev1 AND num = prev2;

Problem 47: Valid Emails (Regex)
SELECT user_id, name, mail
FROM users
WHERE mail REGEXP '^[A-Za-z][A-Za-z0-9_.-]*@leetcode\\.com$'
GROUP BY user_id;

Problem 48: Immediate Delivery Percentage
SELECT ROUND(
    AVG(customer_pref_delivery_date = order_date) * 100, 2
) AS immediate_percentage
FROM(
    SELECT *,
    ROW_NUMBER() OVER (
        PARTITION BY customer_id 
        ORDER BY order_date
    ) AS rn
    FROM delivery
) t
WHERE rn = 1;

Problem 49: Fraction of Players with Consecutive Logins
SELECT ROUND(
    COUNT(DISTINCT player_id) / 
    (SELECT COUNT(DISTINCT player_id) FROM activity), 2
) AS fraction
FROM(
    SELECT player_id, event_date,
    LEAD(event_date) OVER (
        PARTITION BY player_id 
        ORDER BY event_date
    ) AS next_date
    FROM activity
) t
WHERE DATEDIFF(next_date, event_date) = 1;

Problem 50: Product Price at Given Date
SELECT p.product_id,
COALESCE(t.new_price, 10) AS price
FROM (
    SELECT DISTINCT product_id FROM products
) p
LEFT JOIN (
    SELECT *,
    ROW_NUMBER() OVER (
        PARTITION BY product_id 
        ORDER BY change_date DESC
    ) AS rn
    FROM products 
    WHERE change_date <= '2019-08-16'
) t
ON p.product_id = t.product_id 
AND t.rn = 1;
