select e.Employee_NM, h.Job_Title, h.Department
from employee_history as h
join employee as e
on h.Employee_ID = e.Employee_ID;