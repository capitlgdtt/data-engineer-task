-- 1
select
    order_id,
    status,
    updated_at,
    extract(day from now() - updated_at)::int as days_since_update
from orders
where
    status = 'shipped'
  and updated_at < now() - interval '7 days';
