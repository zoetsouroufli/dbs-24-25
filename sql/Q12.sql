WITH RECURSIVE seq AS (
  SELECT 0 AS n
  UNION ALL
  SELECT n + 1 FROM seq WHERE n + 1 <= 30
),
festival_days AS (
  SELECT
    f.festival_id,
    f.name AS festival_name,
    DATE_ADD(f.start, INTERVAL s.n DAY) AS festival_date
  FROM festival f
  JOIN seq s ON s.n <= DATEDIFF(f.end, f.start)
),
active_stages AS (
  SELECT
    fd.festival_name,
    fd.festival_date,
    s.stage_id,
    s.stage_name,
    s.capacity
  FROM festival_days fd
  JOIN event e ON e.festival_id = fd.festival_id AND e.event_date = fd.festival_date
  JOIN stage s ON s.stage_id = e.stage_id
)

SELECT
  festival_name,
  festival_date,
  SUM(CEIL(capacity * 0.05)) AS total_security_needed,
  SUM(CEIL(capacity * 0.02)) AS total_support_needed,
  SUM(1) AS total_technical_needed
FROM active_stages
GROUP BY festival_name, festival_date
ORDER BY festival_name, festival_date;
