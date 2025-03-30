with car_stats as (                              --collect stats for each car
    select 
        c.name as car,
        c.class,
        round(avg(r.position), 4) as avg_position,        --calculate average position
        count(r.race) as races_count            --count race participations
    from 
        cars c
    join                                        --join cars with results
        results r on c.name = r.car
    group by 
        c.name, c.class
),
class_stats as (                                --aggregate stats by class
    select 
        class,
        avg(avg_position) as class_avg_position, --calculate class average
        count(car) as cars_in_class             --count cars in class
    from 
        car_stats
    group by 
        class
    having 
        count(car) >= 2                         --filter classes with 2+ cars
)
select 
    cs.car as car_name,
    cs.class as car_class,
    cs.avg_position as average_position,
    cs.races_count as race_count,
    cl.country as car_country
from 
    car_stats cs
join 
    class_stats cls on cs.class = cls.class     --matche cars with class stats
join 
    classes cl on cs.class = cl.class           --add country info
where 
    cs.avg_position < cls.class_avg_position    --filter above-average performers
order by 
    cs.class asc,                               --sort by class
    cs.avg_position asc;                        --sort by performance