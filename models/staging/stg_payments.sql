with source as (
    select * from raw.raw_payments
),

renamed as (
    select
        order_id,
        payment_sequential                  as payment_sequence,
        payment_type,
        payment_installments::int           as installments,
        payment_value::decimal(10,2)        as payment_value
    from source
)

select * from renamed
