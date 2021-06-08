{% macro extract_country_code(customer_phone) -%}
    SUBSTR(customer_phone,1,3)
{% endmacro %}