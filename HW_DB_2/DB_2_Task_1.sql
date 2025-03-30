with CarRaceStats as ( 							--create temp table CarRaceStats
    select 
        c.name as car,							--take these fields
        c.class,
        ROUND(AVG(r.position), 4) as avg_position,
        count(r.race) as races_count			--count results.race=races_count
    from 
        cars c
    join 
        results r on c.name = r.car				--join cars and results
    group by 
        c.name, c.class
),
MinAvgPositionPerClass as (						--create temp table MinAvgPositionPerClass
    select 
        class,
        MIN(avg_position) as min_avg_position	--finding the minimum average positions
    from 
        CarRaceStats							--from created table
    group by 
        class
)
select 											--main querry
    crs.class,
    crs.car,
    crs.avg_position,
    crs.races_count,
    cl.type as car_type,
    cl.country
from 
    CarRaceStats crs
join 											--join all necessary tables
    classes cl on crs.class = cl.class
join
    MinAvgPositionPerClass mpc on crs.class = mpc.class and crs.avg_position = mpc.min_avg_position
order by 										--sorting results
    crs.avg_position;