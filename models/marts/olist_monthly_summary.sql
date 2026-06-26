with orders as (
    select * from {{ ref('fct_orders') }}
),

items as (
    select * from {{ ref('fct_order_items') }}
)

select
    date_trunc('month', o.ordered_at)           as order_month,
    count(distinct o.order_id)                  as total_orders,
    count(distinct o.customer_unique_id)        as unique_customers,
    round(sum(i.total_item_value), 2)           as total_revenue,
    round(avg(i.total_item_value), 2)           as avg_order_value,
    round(avg(o.actual_delivery_days), 1)       as avg_delivery_days,
    round(avg(o.avg_review_score), 2)           as avg_review_score,
    count(case when o.order_status = 'delivered' then 1 end) as delivered_orders,
    count(case when o.order_status = 'cancelled' then 1 end) as cancelled_orders
from orders o
left join items i
    on o.order_id = i.order_id
where o.ordered_at is not null
group by date_trunc('month', o.ordered_at)
order by order_month