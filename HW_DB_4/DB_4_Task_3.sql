with recursive ManagerHierarchy as (
    select 
        e.EmployeeID,
        e.Name,
        e.ManagerID,
        e.DepartmentID,
        e.RoleID
    from Employees e
    where exists (
        select 1 from Employees 
        where ManagerID = e.EmployeeID
    )
    AND e.RoleID in (select RoleID from Roles where RoleName like '%Менеджер%')
),
Subordinatecount as (
    select
        m.EmployeeID,
        count(s.EmployeeID) as TotalSubordinates
    from ManagerHierarchy m
    join Employees s on s.ManagerID = m.EmployeeID
    group by m.EmployeeID
    having count(s.EmployeeID) > 0
)
select 
    m.EmployeeID,
    m.Name as EmployeeName,
    m.ManagerID,
    d.DepartmentName,
    r.RoleName,
    (select string_agg(p.ProjectName, ', ') 
     from Projects p 
     where p.DepartmentID = m.DepartmentID) as ProjectNames,
    (select string_agg(t.TaskName, ', ') 
     from Tasks t 
     where t.assignedTo = m.EmployeeID) as TaskNames,
    sc.TotalSubordinates
from 
    ManagerHierarchy m
join Departments d on m.DepartmentID = d.DepartmentID
join Roles r on m.RoleID = r.RoleID
join Subordinatecount sc on m.EmployeeID = sc.EmployeeID
order by 
    m.Name;