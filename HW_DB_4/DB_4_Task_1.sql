with recursive EmployeeHierarchy as (
    select EmployeeID, Name, ManagerID, DepartmentID, RoleID
    from Employees
    where EmployeeID = 1
    union all
    select e.EmployeeID, e.Name, e.ManagerID, e.DepartmentID, e.RoleID
    from Employees e
    join EmployeeHierarchy eh on e.ManagerID = eh.EmployeeID
)
select 
    eh.EmployeeID,
    eh.Name as EmployeeName,
    eh.ManagerID,
    d.DepartmentName,
    r.RoleName,
    STRING_AGG(distinct p.ProjectName, ', ' order by p.ProjectName) as ProjectNames,
    STRING_AGG(distinct t.TaskName, ', ' order by t.TaskName) as TaskNames
from 
    EmployeeHierarchy eh
left join Departments d on eh.DepartmentID = d.DepartmentID
left join Roles r on eh.RoleID = r.RoleID
left join Projects p on eh.DepartmentID = p.DepartmentID
left join Tasks t on eh.EmployeeID = t.assignedTo
where eh.EmployeeID != 1  -- Exclude Ivan Ivanov himself as per the expected output
group by 
    eh.EmployeeID, eh.Name, eh.ManagerID, d.DepartmentName, r.RoleName
order by 
    eh.Name;