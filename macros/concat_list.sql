

{% macro concat_list(fields) -%}
    {{ fields|join(' ||  ') }}
{% endmacro %}
