-- 5.1
select
    o.product_id,
    o.order_date,
    sum(o.quantity) as total_sales,
    i.stock_qty
from orders o
         join inventory_snapshots i
              on o.product_id = i.product_id
                  and o.order_date = i.snapshot_date
where o.status = 'completed'
group by o.product_id, o.order_date, i.stock_qty
having sum(o.quantity) > i.stock_qty;

--5.2
select
    product_id,
    snapshot_date as date,
    stock_qty,
    coalesce(daily_sales, 0) as daily_sales,
    stock_qty - coalesce(daily_sales, 0) as difference
from (
         select
             i.product_id,
             i.snapshot_date,
             i.stock_qty,
             (
                 select coalesce(sum(o.quantity), 0)
                 from orders o
                 where o.product_id = i.product_id
                   and o.order_date = i.snapshot_date
                   and o.status = 'completed'
             ) as daily_sales
         from inventory_snapshots i
     ) sub
where stock_qty - coalesce(daily_sales, 0) < 0
order by product_id, date;
