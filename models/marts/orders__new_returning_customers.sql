WITH orders__payment_success as (

    SELECT * FROM {{ ref('orders__payment_success') }}
),

customers__first_order_date as (
   
    SELECT * FROM {{ ref('customers__first_order_date') }}
),

orders__new_returning_customers as (

    SELECT
        order_id
        ,customer_id
        ,order_placed_at
        ,order_status
        ,total_amount
        ,payment_finalised_at
        ,customer_first_name
        ,customer_last_name
        ,ROW_NUMBER() OVER (ORDER BY order_id) AS transaction_seq
        ,ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_id) AS customer_sales_seq
        ,CASE WHEN cst_frst.first_order_date = orders.order_placed_at THEN 'new' ELSE 'return' END AS new_vs_return
        ,SUM(total_amount) over (PARTITION BY customer_id ORDER BY order_id) as customer_lifetime_value
    , first_order_date
    FROM orders__payment_success as orders
    INNER JOIN  customers__first_order_date as cst_frst USING(customer_id)
)

SELECT * FROM orders__new_returning_customers