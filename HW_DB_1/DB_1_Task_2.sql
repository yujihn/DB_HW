with 										-- create temporary result set for cars matching criteria
car_results as (
    select 
        v.maker,
        c.model,
        c.horsepower,
        c.engine_capacity,
        'Car' as vehicle_type				-- fixed vehicle type label
    from car c
    join vehicle v on c.model = v.model		-- join with vehicle table on model
    where c.horsepower > 150
      and c.engine_capacity < 3
      and c.price < 35000
),
motorcycle_results as (						-- create temporary result set for motorcycles matching criteria
    select 
        v.maker,
        m.model,
        m.horsepower,
        m.engine_capacity,
        'Motorcycle' as vehicle_type		-- fixed vehicle type label
    from motorcycle m
    join vehicle v on m.model = v.model		-- join with vehicle table on model
    where m.horsepower > 150
      and m.engine_capacity < 1.5
      and m.price < 20000
),
bicycle_results as (						-- create temporary result set for bicycles matching criteria
    select 
        v.maker,
        b.model,
        NULL::integer as horsepower,		-- NULL::integer and NULL::numeric - Explicit type casting for NULL values
        NULL::numeric as engine_capacity,
        'Bicycle' as vehicle_type			-- fixed vehicle type label
    from bicycle b
    join vehicle v on b.model = v.model		-- join with vehicle table on model
    where b.gear_count > 18
      and b.price < 4000
),
combined_results as (						-- combine all results into single dataset
    select * from car_results
    union all
    select * from motorcycle_results
    union all
    select * from bicycle_results
)
select 										-- final query with sorting
    maker,
    model,
    horsepower,
    engine_capacity,
    vehicle_type
from combined_results
order by 
    case when horsepower is NULL then 1 else 0 end,		-- sort NULLs last
    horsepower desc NULLS last;							-- sort by power descending, NULLs at end