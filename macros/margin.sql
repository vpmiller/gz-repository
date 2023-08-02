{% macro margin (turnover, purchase_cost) %}
    {{ turnover }} - {{ purchase_cost }}
{% endmacro %}