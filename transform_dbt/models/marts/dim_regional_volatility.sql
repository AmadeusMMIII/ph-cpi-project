with source_data as (
    select * from {{ ref('fct_cpi_trends') }}
)

select
    region_name,
    commodity_group,
    -- Calculate standard deviation of the inflation rate
    stddev(yoy_inflation_rate) as inflation_standard_deviation,
    -- Max spike vs Minimum dip to find the absolute range of volatility
    max(yoy_inflation_rate) - min(yoy_inflation_rate) as max_spread_range,
    avg(yoy_inflation_rate) as average_inflation_rate
from source_data
group by 1, 2