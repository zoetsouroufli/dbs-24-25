SELECT 
    a.artist_id,
    a.artist_name, 
    a.artist_surname,
    f.festival_id,
    COUNT(*) AS warmup_count
FROM performance p
JOIN performance_kind pk ON p.performance_kind_id = pk.performance_kind_id
JOIN performance_artist pa ON p.performance_id = pa.performance_id
JOIN artist a ON pa.artist_id = a.artist_id
JOIN event e ON p.event_id = e.event_id
JOIN festival f ON e.festival_id = f.festival_id
WHERE pk.performance_kind_id = 1
GROUP BY a.artist_id, f.festival_id
HAVING COUNT(*) > 2;
