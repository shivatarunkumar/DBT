{% macro cents_to_dollars(customer_phone) %}
SUBSTR(customer_phone,1,3)
{% endmacro %}