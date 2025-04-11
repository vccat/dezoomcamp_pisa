{{ 
    config(materialized='table') 
}}

WITH school_data as (
  select
    s.countryCode,
    sch.schoolType,
    -- Average PVs per school type
    (SUM(pv1_math * s.calc_weight)/SUM(s.calc_weight) + 
        SUM(pv2_math * s.calc_weight)/SUM(s.calc_weight) +
        SUM(pv3_math * s.calc_weight)/SUM(s.calc_weight) +
        SUM(pv4_math * s.calc_weight)/SUM(s.calc_weight) +
        SUM(pv5_math * s.calc_weight)/SUM(s.calc_weight) +
        SUM(pv6_math * s.calc_weight)/SUM(s.calc_weight) +
        SUM(pv7_math * s.calc_weight)/SUM(s.calc_weight) +
        SUM(pv8_math * s.calc_weight)/SUM(s.calc_weight) +
        SUM(pv9_math * s.calc_weight)/SUM(s.calc_weight) +
        SUM(pv10_math * s.calc_weight)/SUM(s.calc_weight)) /10 as math_score,
    (SUM(pv1_science * s.calc_weight)/SUM(s.calc_weight) + 
        SUM(pv2_science * s.calc_weight)/SUM(s.calc_weight) +
        SUM(pv3_science * s.calc_weight)/SUM(s.calc_weight) +
        SUM(pv4_science * s.calc_weight)/SUM(s.calc_weight) +
        SUM(pv5_science * s.calc_weight)/SUM(s.calc_weight) +
        SUM(pv6_science * s.calc_weight)/SUM(s.calc_weight) +
        SUM(pv7_science * s.calc_weight)/SUM(s.calc_weight) +
        SUM(pv8_science * s.calc_weight)/SUM(s.calc_weight) +
        SUM(pv9_science * s.calc_weight)/SUM(s.calc_weight) +
        SUM(pv10_science * s.calc_weight)/SUM(s.calc_weight)) /10 as science_score,
    (SUM(pv1_reading * s.calc_weight)/SUM(s.calc_weight) + 
        SUM(pv2_reading * s.calc_weight)/SUM(s.calc_weight) +
        SUM(pv3_reading * s.calc_weight)/SUM(s.calc_weight) +
        SUM(pv4_reading * s.calc_weight)/SUM(s.calc_weight) +
        SUM(pv5_reading * s.calc_weight)/SUM(s.calc_weight) +
        SUM(pv6_reading * s.calc_weight)/SUM(s.calc_weight) +
        SUM(pv7_reading * s.calc_weight)/SUM(s.calc_weight) +
        SUM(pv8_reading * s.calc_weight)/SUM(s.calc_weight) +
        SUM(pv9_reading * s.calc_weight)/SUM(s.calc_weight) +
        SUM(pv10_reading * s.calc_weight)/SUM(s.calc_weight)) /10 as reading_score
  FROM {{ ref('stg_2022_student') }} s
  JOIN {{ ref('stg_2022_school') }} sch ON s.schoolID = sch.schoolID
  GROUP BY s.countryCode, sch.schoolType
)
select
  countryCode,
  schoolType,
  math_score,
  science_score,
  reading_score
from school_data
where schoolType IN ('Public', 'Private') 
order by countryCode

