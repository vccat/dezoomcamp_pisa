{{ 
    config(materialized='table') 
}}

WITH tmp_2022 AS (
  SELECT
    '2022' AS year,
    countryCode,
    ICTAccess,
    -- Weighted average across all PVs
    (
      (SUM(pv1_science * calc_weight)/SUM(calc_weight)) + 
      (SUM(pv2_science * calc_weight)/SUM(calc_weight)) +
      (SUM(pv3_science * calc_weight)/SUM(calc_weight)) +
      (SUM(pv4_science * calc_weight)/SUM(calc_weight)) +
      (SUM(pv5_science * calc_weight)/SUM(calc_weight)) +
      (SUM(pv6_science * calc_weight)/SUM(calc_weight)) +
      (SUM(pv7_science * calc_weight)/SUM(calc_weight)) +
      (SUM(pv8_science * calc_weight)/SUM(calc_weight)) +
      (SUM(pv9_science * calc_weight)/SUM(calc_weight)) +
      (SUM(pv10_science * calc_weight)/SUM(calc_weight))
    ) / 10 AS avg_science_score,
    COUNT(*) AS num_students
  FROM {{ ref('stg_2022_student') }}
  WHERE ICTAccess is not null
  GROUP BY countryCode, ICTAccess
),

tmp_2018 AS (
  SELECT
    '2018' AS year,
    countryCode,
    ICTAccess,
    -- Weighted average across all PVs
    (
      (SUM(pv1_science * calc_weight)/SUM(calc_weight)) + 
      (SUM(pv2_science * calc_weight)/SUM(calc_weight)) +
      (SUM(pv3_science * calc_weight)/SUM(calc_weight)) +
      (SUM(pv4_science * calc_weight)/SUM(calc_weight)) +
      (SUM(pv5_science * calc_weight)/SUM(calc_weight)) +
      (SUM(pv6_science * calc_weight)/SUM(calc_weight)) +
      (SUM(pv7_science * calc_weight)/SUM(calc_weight)) +
      (SUM(pv8_science * calc_weight)/SUM(calc_weight)) +
      (SUM(pv9_science * calc_weight)/SUM(calc_weight)) +
      (SUM(pv10_science * calc_weight)/SUM(calc_weight))
    ) / 10 AS avg_science_score,
    COUNT(*) AS num_students
  FROM {{ ref('stg_2018_student') }}
  WHERE ICTAccess is not null
  GROUP BY countryCode, ICTAccess
),

tmp_2015 AS (
  SELECT
    '2015' AS year,
    countryCode,
    ICTAccess,
    -- Weighted average across all PVs
    (
      (SUM(pv1_science * calc_weight)/SUM(calc_weight)) + 
      (SUM(pv2_science * calc_weight)/SUM(calc_weight)) +
      (SUM(pv3_science * calc_weight)/SUM(calc_weight)) +
      (SUM(pv4_science * calc_weight)/SUM(calc_weight)) +
      (SUM(pv5_science * calc_weight)/SUM(calc_weight)) +
      (SUM(pv6_science * calc_weight)/SUM(calc_weight)) +
      (SUM(pv7_science * calc_weight)/SUM(calc_weight)) +
      (SUM(pv8_science * calc_weight)/SUM(calc_weight)) +
      (SUM(pv9_science * calc_weight)/SUM(calc_weight)) +
      (SUM(pv10_science * calc_weight)/SUM(calc_weight))
    ) / 10 AS avg_science_score,
    COUNT(*) AS num_students
  FROM {{ ref('stg_2015_student') }}
  WHERE ICTAccess is not null
  GROUP BY countryCode, ICTAccess
)

SELECT * FROM tmp_2022
UNION ALL
SELECT * FROM tmp_2018
UNION ALL
SELECT * FROM tmp_2015

