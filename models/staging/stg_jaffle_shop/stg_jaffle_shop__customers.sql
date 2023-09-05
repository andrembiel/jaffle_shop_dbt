WITH jaffle_shop_customers_source as (
    
    SELECT * FROM  {{ source('bigquery', 'jaffle_shop_customers_source') }}

),
jaffle_shop_customers_renamed as (
    
    SELECT
         id as customer_id
        ,FIRST_NAME AS customer_first_name
        ,LAST_NAME as customer_last_name
    FROM  jaffle_shop_customers_source
)

SELECT * FROM jaffle_shop_customers_renamed
