WITH customer_stats AS (
    SELECT 
        c.id_customer,
        c.name,
        COUNT(DISTINCT b.id_booking) AS booking_count,
        COUNT(DISTINCT r.id_hotel) AS hotel_count,
        SUM(r.price) AS total_amount
    FROM 
        customer c
    JOIN booking b ON c.id_customer = b.id_customer
    JOIN room r ON b.id_room = r.id_room
    GROUP BY 
        c.id_customer, c.name
)
SELECT 
    cs.id_customer,
    cs.name,
    cs.booking_count,
    cs.total_amount::numeric(10,2) AS total_spent,
    cs.hotel_count AS unique_hotels
FROM 
    customer_stats cs
WHERE 
    cs.booking_count > 2
    AND cs.hotel_count > 1
    AND cs.total_amount > 500
ORDER BY 
    cs.total_amount ASC;