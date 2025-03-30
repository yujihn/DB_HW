with car_stats as (                              			--collect stats for each car
    select 
        c.name as car,
        c.class,
        round(avg(r.position), 4) as avg_position,			--calculate average position
        count(r.race) as races_count            			--count race participations
    from 
        cars c
    join                                       				--join cars with results
        results r on c.name = r.car
    group by 
        c.name, c.class
),
class_stats as (                                			--aggregate stats by class
    select 
        class,
        count(case when avg_position > 3.0 then 1 end) as low_performance_count,
        count(distinct r.race) as total_races    			--count total races per class
    from 
        car_stats cs
    join
        results r on cs.car = r.car
    group by 
        class
    having 
        count(case when avg_position > 3.0 then 1 end) > 0  --classes with at least one low performer
)
select 
    cs.car as car_name,
    cs.class as car_class,
    cs.avg_position as average_position,
    cs.races_count as race_count,
    cl.country as car_country,
    cls.total_races as class_total_races,
    cls.low_performance_count                  				--number of low performers in class
from 
    car_stats cs
join 
    class_stats cls on cs.class = cls.class    				--matches cars with class stats
join 
    classes cl on cs.class = cl.class          				--add country info
where 
    cs.avg_position > 3.0                      				--only low performers
order by 
    cls.low_performance_count desc,             			--sort by count of low performers
    cs.avg_position desc;                       			--then by worst performance first