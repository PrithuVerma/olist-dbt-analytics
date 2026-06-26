with orders as (
    select * from {{ ref('stg_orders') }}
),

customers as (
    select * from {{ ref('stg_customers') }}
),

payments as (
    select
        order_id,
        sum(payment_value)                  as total_payment_value,
        count(distinct payment_type)        as payment_methods_used,
        max(installments)                   as max_installments
    from {{ ref('stg_payments') }}
    group by order_id
),

reviews as (
    select
        order_id,
        round(avg(review_score), 2)         as avg_review_score
    from {{ ref('stg_reviews') }}
    group by order_id
)

select
    o.order_id,
    o.customer_id,
    c.customer_unique_id,
    c.city                                  as customer_city,
    c.state                                 as customer_state,
    o.order_status,
    o.ordered_at,
    o.approved_at,
    o.shipped_at,
    o.delivered_at,
    o.estimated_delivery_at,
    datediff('day', o.ordered_at, o.delivered_at)           as actual_delivery_days,
    datediff('day', o.ordered_at, o.estimated_delivery_at)  as estimated_delivery_days,
    datediff('day', o.delivered_at, o.estimated_delivery_at) as delivery_delay_days,
    coalesce(p.total_payment_value, 0)     as total_payment_value,
    p.payment_methods_used,
    p.max_installments,
    r.avg_review_score
from orders o
left join customers c
    on o.customer_id = c.customer_id
left join payments p
    on o.order_id = p.order_id
left join reviews r
    on o.order_id = r.order_id