WITH genre_year_counts AS (
  SELECT 
    mg.music_genre,
    YEAR(p.performance_date) AS year,
    COUNT(*) AS num_appearances
  FROM music_genre mg
  JOIN artist_genre ag ON mg.music_genre_id = ag.music_genre_id
  JOIN artist a ON ag.artist_id = a.artist_id
  JOIN performance_artist pa ON a.artist_id = pa.artist_id
  JOIN performance p ON pa.performance_id = p.performance_id
  GROUP BY mg.music_genre, YEAR(p.performance_date)
),
genre_consecutive_years AS (
  SELECT 
    g1.music_genre,
    g1.year AS year1,
    g2.year AS year2,
    g1.num_appearances
  FROM genre_year_counts g1
  JOIN genre_year_counts g2
    ON g1.music_genre = g2.music_genre
   AND (g2.year = g1.year + 1)
   AND g1.num_appearances = g2.num_appearances
   AND g1.num_appearances >= 3
)
SELECT DISTINCT 
  music_genre,
  year1,
  year2,
  num_appearances
FROM genre_consecutive_years
ORDER BY music_genre, year1;
