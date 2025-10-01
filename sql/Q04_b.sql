EXPLAIN SELECT 
    a.artist_id,
    a.artist_name,
    a.artist_surname,
    AVG(e.artist_performance_rating) AS avg_artist_rating,
    AVG(e.overall_impression_rating) AS avg_overall_rating
FROM artist a
FORCE INDEX (PRIMARY)
JOIN performance_artist pa FORCE INDEX (PRIMARY) ON a.artist_id = pa.artist_id
JOIN evaluation e FORCE INDEX (PRIMARY) ON pa.performance_id = e.performance_id
WHERE a.artist_id = 4;