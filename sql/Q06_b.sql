EXPLAIN SELECT 
    ev.event_id,
    ev.event_name,
    ev.event_date,
    AVG(e.artist_performance_rating) AS avg_artist_rating,
    AVG(e.overall_impression_rating) AS avg_overall_rating
FROM evaluation e FORCE INDEX (PRIMARY)
JOIN performance p FORCE INDEX (PRIMARY) ON e.performance_id = p.performance_id
JOIN event ev FORCE INDEX (PRIMARY) ON p.event_id = ev.event_id
WHERE e.id_visitor = 16
GROUP BY ev.event_id, ev.event_name, ev.event_date;
