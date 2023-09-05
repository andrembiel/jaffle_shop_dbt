{{
    config(
        materialized='view'
    )
}}

WITH orders__payment_success as (
    SELECT 
        customer_id
        ,order_placed_at
    FROM {{ ref('orders__payment_success') }}
),

customers__first_order_date as (

 SELECT 
        customer_id
        ,MIN(order_placed_at) as first_order_date
    FROM orders__payment_success
    GROUP BY 1 
)

SELECT * FROM customers__first_order_date