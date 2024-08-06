select e.Employee_NM, h.Job_Title, h.Department, m.Employee_NM as Manager, h.Start_DT, h.End_DT
from employee_history as h
join employee as e
on h.Employee_ID = e.Employee_ID
left join employee as m
on h.Manager = m.Employee_ID
where e.Employee_NM = 'Toni Lembeck';
