with recursive EmployeeHierarchy as (
    select EmployeeID, Name, ManagerID, DepartmentID, RoleID
    from Employees
    where EmployeeID = 1
    union all
    select e.EmployeeID, e.Name, e.ManagerID, e.DepartmentID, e.RoleID
    from Employees e
    join EmployeeHierarchy eh on e.ManagerID = eh.EmployeeID
),
EmployeeProjects as (
    select 
        e.EmployeeID,
        STRinG_AGG(DISTinCT p.ProjectName, ', ' order by p.ProjectName) as ProjectNames
    from EmployeeHierarchy e
    left join Projects p on e.DepartmentID = p.DepartmentID
    group by e.EmployeeID
),
EmployeeTasks as (
    select 
        t.assignedTo as EmployeeID,
        STRinG_AGG(t.TaskName, ', ' order by t.TaskName) as TaskNames,
        count(t.TaskID) as Taskcount
    from Tasks t
    where t.assignedTo in (select EmployeeID from EmployeeHierarchy)
    group by t.assignedTo
),
DirectSubordinates as (
    select 
        ManagerID as EmployeeID,
        count(*) as Subordinatecount
    from Employees
    where ManagerID in (select EmployeeID from EmployeeHierarchy)
    group by ManagerID
)
select 
    eh.EmployeeID,
    eh.Name as EmployeeName,
    eh.ManagerID,
    d.DepartmentName,
    r.RoleName,
    ep.ProjectNames,
    et.TaskNames,
    coalesce(et.Taskcount, 0) as TotalTasks,
    coalesce(ds.Subordinatecount, 0) as TotalSubordinates
from 
    EmployeeHierarchy eh
left join Departments d on eh.DepartmentID = d.DepartmentID
left join Roles r on eh.RoleID = r.RoleID
left join EmployeeProjects ep on eh.EmployeeID = ep.EmployeeID
left join EmployeeTasks et on eh.EmployeeID = et.EmployeeID
left join DirectSubordinates ds on eh.EmployeeID = ds.EmployeeID
order by 
    eh.Name;