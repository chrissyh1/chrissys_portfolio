sql_ladder_challenge_pt4
SELECT 
    date, 
    volume, 
    SUM(volume) OVER (ORDER BY date) AS cumulative_volume
FROM yum;
SELECT 
    EXTRACT(YEAR FROM date) AS year, 
    EXTRACT(MONTH FROM date) AS month,
    SUM(volume) OVER (ORDER BY EXTRACT(YEAR FROM date), EXTRACT(MONTH FROM date)) AS cumulative_volume
FROM yum
GROUP BY year, month;
SELECT 
    DAY(date) AS day_of_month,
    ROW_NUMBER() OVER (ORDER BY date) AS row_number,
    MIN(low) OVER (ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_low,
    MAX(high) OVER (ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_high,
    SUM(volume) OVER (ORDER BY date) AS cumulative_total_volume
FROM yum
WHERE EXTRACT(YEAR FROM date) = 2017 AND EXTRACT(MONTH FROM date) = 3;
SELECT 
    date,
    close,
    AVG(close) OVER (
        ORDER BY date 
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS moving_avg_7d
FROM yum;

SELECT 
    date,
    MIN(low) OVER (
        ORDER BY date 
        ROWS BETWEEN 4 PRECEDING AND CURRENT ROW
    ) AS moving_low_5d,
    MAX(high) OVER (
        ORDER BY date 
        ROWS BETWEEN 4 PRECEDING AND CURRENT ROW
    ) AS moving_high_5d
FROM yum
WHERE EXTRACT(YEAR FROM date) = 2017 AND EXTRACT(MONTH FROM date) = 3;
WITH rolling_data AS (
    SELECT 
        date, 
        close, 
        MAX(high) OVER (
            ORDER BY date 
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS h7,
        MIN(low) OVER (
            ORDER BY date 
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS l7
    FROM yum
)
SELECT 
    date, 
    (h7 - close) / (h7 - l7) AS williams_r
FROM rolling_data;
WITH percent_k_cte AS (
    SELECT 
        date, 
        close,
        (close - MIN(low) OVER (
            ORDER BY date 
            ROWS BETWEEN 13 PRECEDING AND CURRENT ROW
        )) / 
        (MAX(high) OVER (
            ORDER BY date 
            ROWS BETWEEN 13 PRECEDING AND CURRENT ROW
        ) - MIN(low) OVER (
            ORDER BY date 
            ROWS BETWEEN 13 PRECEDING AND CURRENT ROW
        )) AS percent_k
    FROM yum
),
percent_d_cte AS (
    SELECT 
        date, 
        percent_k, 
        AVG(percent_k) OVER (
            ORDER BY date 
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) AS percent_d
    FROM percent_k_cte
)
SELECT 
    date, 
    percent_k, 
    percent_d 
FROM percent_d_cte;
WITH monthly_avg AS (
    SELECT 
        EXTRACT(YEAR FROM date) AS year,
        EXTRACT(MONTH FROM date) AS month,
        AVG(close) AS avg_close
    FROM yum
    GROUP BY year, month
)
SELECT 
    year,
    month,
    avg_close,
    avg_close - LAG(avg_close) OVER (ORDER BY year, month) AS diff_from_prev_month
FROM monthly_avg;
