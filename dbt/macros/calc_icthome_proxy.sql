{% macro calc_icthome_proxy(columns) %}
  (
    {% for col in columns %}
      CASE 
        WHEN {{ col }} = 1 THEN 1
        WHEN {{ col }} = 2 THEN 0
        WHEN {{ col }} = 3 THEN 0
        ELSE NULL
      END
      {% if not loop.last %} + {% endif %}
    {% endfor %}
  )
{% endmacro %}