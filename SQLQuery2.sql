SELECT TOP 3 p.Productname, p.Userid, Sum(od.num) as PurchaseCount
FROM Product p
JOIN Order_detail od ON p.Productid = od.Productid
--WHERE p.is_hot = 'true'
GROUP BY p.Productname, p.Userid
ORDER BY PurchaseCount DESC;


WITH RankedProducts AS (
    SELECT
        p.Productname,
        p.Userid,
        SUM(od.num) AS PurchaseCount,
        ROW_NUMBER() OVER (PARTITION BY p.Userid ORDER BY SUM(od.num) DESC) AS RowNum
    FROM
        Product p
        JOIN Order_detail od ON p.Productid = od.Productid
    --WHERE p.is_hot = 'true'
    GROUP BY
        p.Productname,
        p.Userid
)
SELECT
    Productname,
    Userid,
    PurchaseCount
FROM
    RankedProducts
WHERE
    RowNum <= 3;
