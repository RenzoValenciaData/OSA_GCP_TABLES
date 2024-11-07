SELECT 
  CASE
      WHEN billingdate IS NULL THEN dateid
      WHEN DATE_DIFF(dateid, PARSE_DATE('%Y%m%d',CAST(BILLINGDATE AS STRING)), MONTH) >= 1 THEN dateid
      else PARSE_DATE('%Y%m%d',CAST(BILLINGDATE AS STRING))
  END AS FechaFactura
  ,metricandvaluetypeidentifier
  ,SUM(metricvalue) metricvalue
FROM `prd-amer-analyt-dsr-svc-b0.amer_p_dsr_mx_publ.metrics_daily` 
WHERE dateid BETWEEN "2024-11-01" AND '2024-11-30'
  AND metricandvaluetypeidentifier IN ('SI_NET_REVENUE_KG', 'SI_CANCELLATION_KG', 'SI_RETURNS_REJECTIONS_KG', 'SI_CARRY_OVER_KG')
GROUP BY 1,2