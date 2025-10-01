SELECT
  p.personel_id,
  p.name,
  p.last_name
FROM
  personel p
  JOIN role r ON p.role_id = r.role_id
WHERE
  r.role = 'Support'
  AND p.personel_id NOT IN (
    SELECT DISTINCT sp.personel_id
    FROM
      stage_personel sp
      JOIN event e ON sp.stage_id = e.stage_id
    WHERE
      e.event_date = '2019-07-27'
  );
