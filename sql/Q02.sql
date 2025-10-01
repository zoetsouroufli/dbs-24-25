SELECT 
    a.artist_id,
    a.artist_name,
    a.artist_surname,
    mg.music_genre,
    CASE 
        WHEN EXISTS (
            SELECT 1
            FROM performance_artist pa
            JOIN performance p ON pa.performance_id = p.performance_id
            JOIN event e ON p.event_id = e.event_id
            JOIN festival f ON e.festival_id = f.festival_id
            WHERE pa.artist_id = a.artist_id AND YEAR(f.start) = 2024
        )
        THEN 'Yes'
        ELSE 'No'
    END AS participated_in_2024
FROM artist a
JOIN artist_genre ag ON a.artist_id = ag.artist_id
JOIN music_genre mg ON ag.music_genre_id = mg.music_genre_id
WHERE mg.music_genre = 'Rock';