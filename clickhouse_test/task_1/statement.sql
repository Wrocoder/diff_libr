SELECT
    id,
    property,
    created_at,
    sign
FROM
(
    SELECT
        id,
        property,
        created_at,
        sign,
        ROW_NUMBER() OVER (PARTITION BY property ORDER BY created_at DESC) AS row_num
    FROM Item
)
WHERE row_num = 1;
