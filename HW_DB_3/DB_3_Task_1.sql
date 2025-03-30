with CustomerBookings as (
    select 
        c.ID_customer,
        c.name,
        c.email,
        c.phone,
        count(distinct b.ID_booking) as total_bookings,
        count(distinct h.ID_hotel) as distinct_hotels,
        STRING_AGG(distinct h.name, ', ' order by h.name) as hotels_list,
        avg(b.check_out_date - b.check_in_date) as avg_stay_duration
    from 
        Customer c
    join 
        Booking b on c.ID_customer = b.ID_customer
    join 
        Room r on b.ID_room = r.ID_room
    join 
        Hotel h on r.ID_hotel = h.ID_hotel
    group by 
        c.ID_customer, c.name, c.email, c.phone
    having 
        count(distinct h.ID_hotel) > 1
)
select 
    name,
    email,
    phone,
    total_bookings,
    hotels_list,
    round(avg_stay_duration::numeric, 4) as avg_stay_duration
from 
    CustomerBookings
where 
    total_bookings > 2
order by 
    total_bookings DESC;