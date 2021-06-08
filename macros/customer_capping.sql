

{% macro customer_capping(field) -%}
    case
        when {{ field }} < 2000 then 'Low'
        when {{ field }} between 2000 and 3000  then 'Mid'
        when {{ field }} > 3000 then 'High'
    end
{% endmacro %}
