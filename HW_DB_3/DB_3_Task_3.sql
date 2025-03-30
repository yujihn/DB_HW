with hotel_categories as (
    -- Категоризация отелей по средней стоимости номера
    select 
        h.id_hotel,
        h.name as hotel_name,
        h.location,
        case 
            when avg(r.price) < 175 then 'Дешевый'
            when avg(r.price) between 175 and 300 then 'Средний'
            else 'Дорогой'
        end as hotel_category
    from 
        hotel h
    join 
        room r on h.id_hotel = r.id_hotel
    group by 
        h.id_hotel, h.name, h.location
),
customer_hotel_preferences as (
    -- Определение предпочтений клиентов
    select 
        c.id_customer,
        c.name,
        -- Определяем предпочитаемый тип отеля по приоритету
        case 
            when BOOL_OR(hc.hotel_category = 'Дорогой') then 'Дорогой'
            when BOOL_OR(hc.hotel_category = 'Средний') then 'Средний'
            else 'Дешевый'
        end as preferred_hotel_type,
        -- Собираем список уникальных отелей
        STRING_AGG(distinct hc.hotel_name, ', ' order by hc.hotel_name) as visited_hotels
    from 
        customer c
    join 
        booking b on c.id_customer = b.id_customer
    join 
        room r on b.id_room = r.id_room
    join 
        hotel_categories hc on r.id_hotel = hc.id_hotel
    group by 
        c.id_customer, c.name
)
select 
    id_customer,
    name,
    preferred_hotel_type,
    visited_hotels
from 
    customer_hotel_preferences
order by 
    case preferred_hotel_type
        when 'Дешевый' then 1
        when 'Средний' then 2
        when 'Дорогой' then 3
    end,
    name;