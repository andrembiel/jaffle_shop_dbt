WITH jaffle_shop_orders_source as (
    
    SELECT * FROM  {{ source('bigquery', 'jaffle_shop_orders_source') }}

),
jaffle_shop_orders_renamed as (
    
    SELECT
         id as order_id
        ,USER_ID as customer_id
        ,ORDER_DATE as order_placed_at
        ,STATUS as order_status
    FROM  jaffle_shop_orders_source
)

SELECT * FROM jaffle_shop_orders_renamed