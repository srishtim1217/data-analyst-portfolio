-- Problem 1: Recyclable and Low Fat Products
select product_id
from products
where low_fats = 'Y' and recyclable = 'Y';

-- Problem 2: Article Views I
select distinct author_id as ID
from views
where author_id = viewer_id
order by author_id;

-- Problem 3: Customer Who Visited but Did Not Make Transactions
select v.customer_id,
       Count(v.visit_id) as count_no_trans
from visits v
left join transactions t
  on v.visit_id = t.visit_id
where t.transaction_id is null
group by v.customer_id;
