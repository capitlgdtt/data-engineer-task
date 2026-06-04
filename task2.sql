-- 2
select
    col_name,
    total_rows,
    non_null_count,
    round(non_null_count * 100.0 / total_rows, 2) as fill_percentage
from (
         select
             count(*) as total_rows,
             count(customer_id)  as cnt_customer_id,
             count(full_name)    as cnt_full_name,
             count(email)        as cnt_email,
             count(phone)        as cnt_phone,
             count(birth_date)   as cnt_birth_date,
             count(country)      as cnt_country,
             count(segment)      as cnt_segment
         from customers
     ) agg
         cross join lateral (
    values
        ('customer_id', cnt_customer_id),
        ('full_name',   cnt_full_name),
        ('email',       cnt_email),
        ('phone',       cnt_phone),
        ('birth_date',  cnt_birth_date),
        ('country',     cnt_country),
        ('segment',     cnt_segment)
    ) as cols(col_name, non_null_count)
order by fill_percentage asc;
