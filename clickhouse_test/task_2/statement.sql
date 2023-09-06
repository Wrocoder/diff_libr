--CREATE VIEW ViewDepWithDraw AS
--WITH CombinedData AS (
--    SELECT
--        toDate(D.created_at) AS summary_date,
--        D.user_id,
--        sum(D.amount) AS total_deposit,
--        coalesce(sum(W.amount), 0) AS total_withdrawal
--    FROM Deposit D
--    LEFT JOIN Withdrawal W ON toDate(D.created_at) = toDate(W.created_at) AND D.user_id = W.user_id
--    GROUP BY summary_date, D.user_id
--)
--SELECT
--    summary_date,
--    user_id,
--    total_deposit,
--    total_withdrawal,
--    total_deposit - total_withdrawal AS deposit_minus_withdrawal
--FROM CombinedData;


CREATE MATERIALIZED VIEW MaterializedViewDepWithDraw TO ViewDepWithDraw AS
SELECT
    toDate(D.created_at) AS summary_date,
    D.user_id,
    sum(D.amount) AS total_deposit,
    coalesce(sum(W.amount), 0) AS total_withdrawal,
    total_deposit - total_withdrawal AS deposit_minus_withdrawal
FROM Deposit D
LEFT JOIN Withdrawal W ON toDate(D.created_at) = toDate(W.created_at) AND D.user_id = W.user_id
GROUP BY summary_date, D.user_id;


--Обновлять MATERIALIZED VIEW:
--
--1. Вручную - REFRESH MATERIALIZED VIEW ViewDepWithDraw;
--2. Планировщиком - ALTER MATERIALIZED VIEW ViewDepWithDraw
--                    SET ttl = 3600;