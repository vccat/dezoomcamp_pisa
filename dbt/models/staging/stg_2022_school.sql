{{
    config(
        materialized='view'
    )
}}

with school_tmp as (
    select *,
        row_number() over(partition by CAST(CNTSCHID AS INTEGER)) as rn
    from {{ source('pisa_external', 'school_2022') }}
    where CNTSCHID is not null

)
select
    {{ dbt.safe_cast("CNTSCHID", api.Column.translate_type("integer")) }} as schoolID,
    CNT as countryCode,
    CASE 
        WHEN SC013Q01TA = 1 THEN 'Public'  
        WHEN SC013Q01TA = 2 THEN 'Private'  
        ELSE 'Other'  
    END AS schoolType

from school_tmp
where rn = 1

-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}