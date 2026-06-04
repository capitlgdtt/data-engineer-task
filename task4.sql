-- 4
select
    txn_id,
    concat_ws(', ',
        case when amount is null or amount <= 0 then 'amount must be positive' end,
        case when currency is null or currency not in ('USD', 'EUR', 'RUB', 'CNY') then 'invalid currency' end,
        case when txn_type is null or txn_type not in ('debit', 'credit', 'refund') then 'invalid txn_type' end,
        case when txn_date is null or txn_date > current_date then 'future txn_date' end
    ) as violated_rules
from transactions
where
    amount is null or amount <= 0
   or currency is null or currency not in ('USD', 'EUR', 'RUB', 'CNY')
   or txn_type is null or txn_type not in ('debit', 'credit', 'refund')
   or txn_date is null or txn_date > current_date;
