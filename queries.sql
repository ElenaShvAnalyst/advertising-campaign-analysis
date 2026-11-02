Создание структуры таблицы

CREATE TABLE ACP (
    Campaign_ID VARCHAR(20),
    Platform VARCHAR(25),
    Ad_Type VARCHAR(25),
    Impressions INT,
    Clicks INT,
    Conversions INT,
    Spend NUMERIC(10,2),
    Revenue NUMERIC(10,2),
    CTR NUMERIC(6,4),
    ROI NUMERIC(6,2)
);

Запрос А: Платформа с самым низким CPC (Затраты на клик)
SELECT 
    platform, 
    ROUND(SUM(spend) / SUM(clicks), 2) AS cpc
FROM acp
WHERE clicks > 0
GROUP BY platform
ORDER BY cpc
LIMIT 1;

Запрос Б: Тип контента с самым высоким Conversion Rate
SELECT 
    ad_type,
    ROUND((SUM(conversions * 1.0) / SUM(clicks)) * 100, 2) AS conversion_rate
FROM acp
GROUP BY ad_type
ORDER BY conversion_rate DESC
LIMIT 1;

Запрос B: Найти для каждой платформы кампанию с самым высоким CTR.
WITH ranked AS (
    SELECT 
        platform,
        campaign_id,
        RANK() OVER(PARTITION BY platform ORDER BY ctr DESC) AS ranks
    FROM acp
)
SELECT 
    platform,
    campaign_id
FROM ranked
WHERE ranks = 1;

