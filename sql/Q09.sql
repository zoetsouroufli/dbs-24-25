WITH visitor_counts AS (
  SELECT 
    t.id_visitor,
    YEAR(e.event_date) AS year,
    COUNT(*) AS num_attended
  FROM ticket t
  JOIN event e ON t.event_id = e.event_id
  GROUP BY t.id_visitor, YEAR(e.event_date)
  HAVING COUNT(*) > 3
)	

SELECT vc1.id_visitor, vc1.year, vc1.num_attended
FROM visitor_counts vc1
JOIN visitor_counts vc2 
  ON vc1.year = vc2.year
  AND vc1.num_attended = vc2.num_attended
  AND vc1.id_visitor <> vc2.id_visitor
ORDER BY vc1.year, vc1.num_attended;

