with staged as (
    select * from {{ ref('stg_cpi_inflation') }}
),

unpivoted as (
    select region_name, commodity_code, commodity_group, '2023-01-01'::date as report_date, "2023_jan" as yoy_inflation_rate from staged union all
    select region_name, commodity_code, commodity_group, '2023-02-01'::date as report_date, "2023_feb" as yoy_inflation_rate from staged union all
    select region_name, commodity_code, commodity_group, '2023-03-01'::date as report_date, "2023_mar" as yoy_inflation_rate from staged union all
    select region_name, commodity_code, commodity_group, '2023-04-01'::date as report_date, "2023_apr" as yoy_inflation_rate from staged union all
    select region_name, commodity_code, commodity_group, '2023-05-01'::date as report_date, "2023_may" as yoy_inflation_rate from staged union all
    select region_name, commodity_code, commodity_group, '2023-06-01'::date as report_date, "2023_jun" as yoy_inflation_rate from staged union all
    select region_name, commodity_code, commodity_group, '2023-07-01'::date as report_date, "2023_jul" as yoy_inflation_rate from staged union all
    select region_name, commodity_code, commodity_group, '2023-08-01'::date as report_date, "2023_aug" as yoy_inflation_rate from staged union all
    select region_name, commodity_code, commodity_group, '2023-09-01'::date as report_date, "2023_sep" as yoy_inflation_rate from staged union all
    select region_name, commodity_code, commodity_group, '2023-10-01'::date as report_date, "2023_oct" as yoy_inflation_rate from staged union all
    select region_name, commodity_code, commodity_group, '2023-11-01'::date as report_date, "2023_nov" as yoy_inflation_rate from staged union all
    select region_name, commodity_code, commodity_group, '2023-12-01'::date as report_date, "2023_dec" as yoy_inflation_rate from staged union all
    
    select region_name, commodity_code, commodity_group, '2024-01-01'::date as report_date, "2024_jan" as yoy_inflation_rate from staged union all
    select region_name, commodity_code, commodity_group, '2024-02-01'::date as report_date, "2024_feb" as yoy_inflation_rate from staged union all
    select region_name, commodity_code, commodity_group, '2024-03-01'::date as report_date, "2024_mar" as yoy_inflation_rate from staged union all
    select region_name, commodity_code, commodity_group, '2024-04-01'::date as report_date, "2024_apr" as yoy_inflation_rate from staged union all
    select region_name, commodity_code, commodity_group, '2024-05-01'::date as report_date, "2024_may" as yoy_inflation_rate from staged union all
    select region_name, commodity_code, commodity_group, '2024-06-01'::date as report_date, "2024_jun" as yoy_inflation_rate from staged union all
    select region_name, commodity_code, commodity_group, '2024-07-01'::date as report_date, "2024_jul" as yoy_inflation_rate from staged union all
    select region_name, commodity_code, commodity_group, '2024-08-01'::date as report_date, "2024_aug" as yoy_inflation_rate from staged union all
    select region_name, commodity_code, commodity_group, '2024-09-01'::date as report_date, "2024_sep" as yoy_inflation_rate from staged union all
    select region_name, commodity_code, commodity_group, '2024-10-01'::date as report_date, "2024_oct" as yoy_inflation_rate from staged union all
    select region_name, commodity_code, commodity_group, '2024-11-01'::date as report_date, "2024_nov" as yoy_inflation_rate from staged union all
    select region_name, commodity_code, commodity_group, '2024-12-01'::date as report_date, "2024_dec" as yoy_inflation_rate from staged union all
    
    select region_name, commodity_code, commodity_group, '2025-01-01'::date as report_date, "2025_jan" as yoy_inflation_rate from staged union all
    select region_name, commodity_code, commodity_group, '2025-02-01'::date as report_date, "2025_feb" as yoy_inflation_rate from staged union all
    select region_name, commodity_code, commodity_group, '2025-03-01'::date as report_date, "2025_mar" as yoy_inflation_rate from staged union all
    select region_name, commodity_code, commodity_group, '2025-04-01'::date as report_date, "2025_apr" as yoy_inflation_rate from staged union all
    select region_name, commodity_code, commodity_group, '2025-05-01'::date as report_date, "2025_may" as yoy_inflation_rate from staged union all
    select region_name, commodity_code, commodity_group, '2025-06-01'::date as report_date, "2025_jun" as yoy_inflation_rate from staged union all
    select region_name, commodity_code, commodity_group, '2025-07-01'::date as report_date, "2025_jul" as yoy_inflation_rate from staged union all
    select region_name, commodity_code, commodity_group, '2025-08-01'::date as report_date, "2025_aug" as yoy_inflation_rate from staged union all
    select region_name, commodity_code, commodity_group, '2025-09-01'::date as report_date, "2025_sep" as yoy_inflation_rate from staged union all
    select region_name, commodity_code, commodity_group, '2025-10-01'::date as report_date, "2025_oct" as yoy_inflation_rate from staged union all
    select region_name, commodity_code, commodity_group, '2025-11-01'::date as report_date, "2025_nov" as yoy_inflation_rate from staged union all
    select region_name, commodity_code, commodity_group, '2025-12-01'::date as report_date, "2025_dec" as yoy_inflation_rate from staged
)

select 
    region_name,
    commodity_code,
    commodity_group,
    report_date,
    -- Extract year and month fields for easier visualization filtering
    extract(year from report_date) as report_year,
    extract(month from report_date) as report_month,
    yoy_inflation_rate
from unpivoted