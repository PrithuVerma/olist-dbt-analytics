with products as (
    select * from {{ ref('stg_products') }}
),

translations as (
    select * from {{ ref('stg_category_translation') }}
)

select
    p.product_id,
    p.category_name_portuguese,
    coalesce(t.category_name_english, 'uncategorized') as category_name_english,
    p.product_name_length,
    p.product_description_length,
    p.photos_qty,
    p.weight_g,
    p.length_cm,
    p.height_cm,
    p.width_cm
from products p
left join translations t
    on p.category_name_portuguese = t.category_name_portuguese
