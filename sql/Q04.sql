SELECT 
    a.artist_id,
	a.artist_name,
    a.artist_surname,
    AVG(e.artist_performance_rating) AS avg_artist_rating,
    AVG(e.overall_impression_rating) AS avg_overall_rating
FROM artist a
JOIN performance_artist pa ON a.artist_id = pa.artist_id
JOIN evaluation e ON pa.performance_id = e.performance_id
where a.artist_id=4;
