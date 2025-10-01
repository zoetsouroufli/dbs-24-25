SELECT
  a.artist_id,
  a.artist_name,
  a.artist_surname,
  TIMESTAMPDIFF(YEAR, a.artist_birthdate, CURDATE()) AS age,
  COUNT(DISTINCT f.festival_id) AS festivals_participated
FROM
  artist a
  JOIN performance_artist pa ON a.artist_id = pa.artist_id
  JOIN performance p ON pa.performance_id = p.performance_id
  JOIN event e ON p.event_id = e.event_id
  JOIN festival f ON e.festival_id = f.festival_id
WHERE
  TIMESTAMPDIFF(YEAR, a.artist_birthdate, CURDATE()) < 30
GROUP BY
  a.artist_id, a.artist_name, a.artist_surname, a.artist_birthdate
HAVING
  festivals_participated = (
    SELECT MAX(festival_count) FROM (
      SELECT
        a2.artist_id,
        COUNT(DISTINCT f2.festival_id) AS festival_count
      FROM
        artist a2
        JOIN performance_artist pa2 ON a2.artist_id = pa2.artist_id
        JOIN performance p2 ON pa2.performance_id = p2.performance_id
        JOIN event e2 ON p2.event_id = e2.event_id
        JOIN festival f2 ON e2.festival_id = f2.festival_id
      WHERE
        TIMESTAMPDIFF(YEAR, a2.artist_birthdate, CURDATE()) < 30
      GROUP BY a2.artist_id
    ) AS counts
  )
ORDER BY a.artist_name;
