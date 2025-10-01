SELECT 
  v.first_name AS visitor_first_name,
  v.last_name AS visitor_last_name,
  a.artist_name,
  a.artist_surname,
  AVG(e.artist_performance_rating + e.overall_impression_rating) AS avg_score
FROM evaluation e
JOIN performance_artist pa ON e.performance_id = pa.performance_id
JOIN artist a ON pa.artist_id = a.artist_id
JOIN visitor v ON e.id_visitor = v.id_visitor
GROUP BY e.id_visitor, pa.artist_id
ORDER BY avg_score DESC
LIMIT 5;
