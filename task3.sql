-- 3.1
select
    sku,
    count(*) as duplicate_count,
    min(product_id) as min_product_id,
    max(product_id) as max_product_id
from products
where sku is not null
group by sku
having count(*) > 1
order by duplicate_count desc;

-- 3.2
delete from products
where product_id not in (
    select min(product_id)
    from products
    group by sku
);
