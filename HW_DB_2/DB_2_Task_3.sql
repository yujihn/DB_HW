with carstats as (                              --create temp table that calculates statistics for each car
    select 
        c.name as car,
        c.class,
        round(avg(r.position)) as avg_position, --calculate average position
        count(r.race) as races_count
    from 
        cars c
    join                                        --join cars and results
        results r on c.name = r.car
    group by 
        c.name, c.class
),
minavgposition as (                            --create temp table that calculates min avg value
    select 
        min(avg_position) as min_avg
    from 
        carstats
),
class_races as (                               --calculate total races per class
    select 
        c.class,
        count(distinct r.race) as total_races
    from 
        cars c
    join 
        results r on c.name = r.car
    group by 
        c.class
)
select                                         --main query
    cs.car as car_name,
    cs.class as car_class,
    cs.avg_position as average_position,
    cs.races_count as race_count,
    cl.country as car_country,
    cr.total_races as total_races
from 
    carstats cs
join 
    classes cl on cs.class = cl.class          --join all necessary tables
join 
    minavgposition m on cs.avg_position = m.min_avg
join 
    class_races cr on cs.class = cr.class      --join with total races per class
order by 
    cs.car;                                     --sort asc