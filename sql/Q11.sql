WITH number_performances_artists AS (
  SELECT 
    a.artist_id,
    a.artist_name,
    a.artist_surname,
    COUNT(*) AS total_performances
  FROM artist a
  JOIN performance_artist pa ON a.artist_id = pa.artist_id
  JOIN performance p ON pa.performance_id = p.performance_id
  JOIN event e ON p.event_id = e.event_id
  JOIN festival f ON e.festival_id = f.festival_id
  GROUP BY a.artist_id, a.artist_name, a.artist_surname
)

SELECT 
  artist_id,
  artist_name,
  artist_surname,
  total_performances,
  'Most Performances' AS status
FROM number_performances_artists np
WHERE total_performances = (SELECT MAX(total_performances) FROM number_performances_artists)

UNION ALL

SELECT 
  np.artist_id,
  np.artist_name,
  np.artist_surname,
  np.total_performances,
  'Performed at least 5 times less than the maximum' AS status
FROM number_performances_artists np
WHERE total_performances <= (SELECT MAX(total_performances) FROM number_performances_artists) - 5


ORDER BY total_performances DESC;