-- WITH artist_genre AS (
--     SELECT ag.artist_id, mg.music_genre
--     FROM artist_genre ag
--     JOIN music_genre mg ON ag.music_genre_id = mg.music_genre_id
-- ),

WITH artist_pairs AS (
	SELECT 
        a1.artist_id,
        LEAST(a1.music_genre_id, a2.music_genre_id) AS genre1,
        GREATEST(a1.music_genre_id, a2.music_genre_id) AS genre2
    FROM artist_genre a1
    JOIN artist_genre a2 ON a1.artist_id = a2.artist_id AND a1.music_genre_id < a2.music_genre_id
),

artists_in_festival AS (
    SELECT DISTINCT pa.artist_id
    FROM performance_artist pa
    JOIN performance p ON pa.performance_id = p.performance_id
    JOIN event e ON p.event_id = e.event_id
    JOIN festival f ON e.festival_id = f.festival_id
)

SELECT 
    genre1,
    genre2,
    COUNT(DISTINCT ap.artist_id) AS num_artists
FROM artist_pairs ap
JOIN artists_in_festival af ON ap.artist_id = af.artist_id
GROUP BY genre1, genre2
ORDER BY num_artists DESC
LIMIT 3;