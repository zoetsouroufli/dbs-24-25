SELECT 
    a.artist_id,
    a.artist_name, 
    a.artist_surname,
    COUNT(DISTINCT c.continent_id) AS num_of_continents
FROM artist a
JOIN performance_artist pa ON a.artist_id = pa.artist_id
JOIN performance p ON pa.performance_id = p.performance_id
JOIN event e ON p.event_id = e.event_id
JOIN festival f ON e.festival_id = f.festival_id
JOIN location l ON f.location_id = l.location_id
JOIN continent c ON l.continent_id = c.continent_id
GROUP BY a.artist_id
HAVING COUNT(DISTINCT c.continent_id) >= 3;
