WITH stripe_payments_source as (
  
    SELECT * FROM {{ source('bigquery', 'stripe_payments_source') }}
),

stripe_payments_refact as (
   
    SELECT  
        ID  as payment_id
        ,ORDERID as order_id
        ,CASE  WHEN STATUS = 'fail' then False else True  END as is_payment_success
        ,(AMOUNT/100) AS amount
        ,CREATED AS payment_finalised_at

    FROM stripe_payments_source
)

SELECT * FROM stripe_payments_refact