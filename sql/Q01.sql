SELECT
  YEAR(f.start) AS festival_year,
  pm.method_name AS payment_method,
  SUM(t.cost) AS total_revenue
FROM
  ticket t
  JOIN event e ON t.event_id = e.event_id
  JOIN festival f ON e.festival_id = f.festival_id
  JOIN payment_method pm ON t.id_payment_method = pm.id_payment_method
GROUP BY
  YEAR(f.start), pm.method_name
ORDER BY
  festival_year, payment_method;


