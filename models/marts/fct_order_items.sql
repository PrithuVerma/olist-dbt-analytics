with order_items as (
    select * from {{ ref('stg_order_items') }}
),

products as (
    select * from {{ ref('dim_products') }}
),

sellers as (
    select * from {{ ref('dim_sellers') }}
)

select
    oi.order_id,
    oi.order_item_id,
    oi.product_id,
    p.category_name_english,
    oi.seller_id,
    s.city                          as seller_city,
    s.state                         as seller_state,
    oi.price,
    oi.freight_value,
    oi.price + oi.freight_value     as total_item_value,
    oi.shipping_limit_at
from order_items oi
left join products p
    on oi.product_id = p.product_id
left join sellers s
    on oi.seller_id = s.seller_id