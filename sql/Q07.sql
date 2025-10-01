SELECT 
    f.name,
    ROUND(AVG(exp.experience_id), 2) AS avg_experience
FROM personel p
JOIN experience exp ON p.experience_id = exp.experience_id
JOIN role r ON p.role_id = r.role_id
JOIN stage_personel sp ON p.personel_id = sp.personel_id
JOIN stage s ON sp.stage_id = s.stage_id
JOIN event ev ON s.stage_id = ev.stage_id
JOIN festival f ON ev.festival_id = f.festival_id
WHERE r.role= 'Technical'
GROUP BY f.festival_id
ORDER BY avg_experience ASC
LIMIT 1;
