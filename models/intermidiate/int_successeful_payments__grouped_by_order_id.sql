WITH  stg_stripe_payments as (
    
    SELECT * FROM {{ ref('stg_stripe_payments__payments') }}
),

int_successeful_payments__grouped_by_order_id as (

    SELECT 
        order_id
        ,payment_finalised_at
        ,SUM(amount) as amount
    FROM stg_stripe_payments
    WHERE is_payment_success != False
    GROUP BY 1,2
)

SELECT * FROM int_successeful_payments__grouped_by_order_id