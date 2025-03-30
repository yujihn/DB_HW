with carstats as (                              --create temp table that calculates statistics for each car
    select 
        c.name as car,
        c.class,
        round(avg(r.position), 4) as avg_position, --calculate average position
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
)
select                                         --main query
     cs.car as car_name,
    cs.class as car_class,
    cs.avg_position as average_position,
    cs.races_count as race_count,
    cl.country as car_country
from 
    carstats cs
join 
    classes cl on cs.class = cl.class          --join all necessary tables
join 
    minavgposition m on cs.avg_position = m.min_avg
order by 
    cs.car                                     --sort asc
limit 1;                                       --take first value