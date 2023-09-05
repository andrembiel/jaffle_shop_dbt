WITH stg_jaffle_shop__orders as (
    
    SELECT * FROM {{ ref('stg_jaffle_shop__orders') }}
),

stg_jaffle_shop__customers as (
    
    SELECT * FROM {{ ref('stg_jaffle_shop__customers') }}
),

int_successeful_payments__grouped_by_order_id as (
    
    SELECT * FROM {{ ref('int_successeful_payments__grouped_by_order_id') }}

), 

orders__payment_success as (

SELECT 
    orders.order_id
    ,orders.customer_id
    ,order_placed_at
    ,order_status
    ,amount as total_amount
    ,payment_finalised_at
    ,customer_first_name
    ,customer_last_name

FROM  stg_jaffle_shop__orders as orders
LEFT JOIN stg_jaffle_shop__customers as customers
    ON orders.customer_id = customers.customer_id
LEFT JOIN int_successeful_payments__grouped_by_order_id as payments 
    ON orders.order_id = payments.order_id

)

SELECT * FROM orders__payment_success