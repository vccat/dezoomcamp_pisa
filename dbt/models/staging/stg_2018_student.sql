{{
    config(
        materialized='view'
    )
}}

select 
    {{ dbt.safe_cast("CNTSTUID", api.Column.translate_type("integer")) }} as studentID, 
    {{ dbt.safe_cast("CNTSCHID", api.Column.translate_type("integer")) }} as schoolID, 
    CNT as countryCode, 
    ICTHOME,  
    CASE
        WHEN ICTHOME BETWEEN 0 AND 4 THEN 'Low'
        WHEN ICTHOME BETWEEN 5 AND 7 THEN 'Medium'
        WHEN ICTHOME >= 8 THEN 'High'
        ELSE NULL
    END AS ICTAccess,
    W_FSTUWT as calc_weight,
    PV1MATH as pv1_math,
    PV2MATH as pv2_math,
    PV3MATH as pv3_math,
    PV4MATH as pv4_math,
    PV5MATH as pv5_math,
    PV6MATH as pv6_math,
    PV7MATH as pv7_math,
    PV8MATH as pv8_math,
    PV9MATH as pv9_math,
    PV10MATH as pv10_math,
    PV1READ as pv1_reading,
    PV2READ as pv2_reading,
    PV3READ as pv3_reading,
    PV4READ as pv4_reading,
    PV5READ as pv5_reading,
    PV6READ as pv6_reading,
    PV7READ as pv7_reading,
    PV8READ as pv8_reading,
    PV9READ as pv9_reading,
    PV10READ as pv10_reading,
    PV1SCIE as pv1_science,
    PV2SCIE as pv2_science,
    PV3SCIE as pv3_science,
    PV4SCIE as pv4_science,
    PV5SCIE as pv5_science,
    PV6SCIE as pv6_science,
    PV7SCIE as pv7_science,
    PV8SCIE as pv8_science,
    PV9SCIE as pv9_science,
    PV10SCIE as pv10_science
from {{ source('pisa_external', 'student_2018') }}
where CNTSTUID is not null

