with source as (
    select * from raw.raw_products
),

renamed as (
    select
        product_id,
        product_category_name                           as category_name_portuguese,
        product_name_lenght::int                        as product_name_length,
        product_description_lenght::int                 as product_description_length,
        product_photos_qty::int                         as photos_qty,
        product_weight_g::decimal(10,2)                 as weight_g,
        product_length_cm::decimal(10,2)                as length_cm,
        product_height_cm::decimal(10,2)                as height_cm,
        product_width_cm::decimal(10,2)                 as width_cm
    from source
)

select * from renamed