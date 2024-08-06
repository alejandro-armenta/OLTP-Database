select h.Department, count(e.Employee_NM) as employee_count
from employee_history as h
join employee as e
on h.Employee_ID = e.Employee_ID
group by h.Department;