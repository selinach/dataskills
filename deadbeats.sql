SELECT NAME, sum(NUM_KIDS)
FROM Orders
WHERE CITY='Chicago'
group by NAME,STREET
Order by sum(NUM_KIDS) desc
