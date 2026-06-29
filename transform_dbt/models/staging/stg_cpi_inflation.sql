with raw_data as (
    select * from {{ source('raw_sources', 'raw_cpi_inflation') }}
)

select
    -- Remove leading periods '..' from Geolocation names (e.g., '..National Capital Region (NCR)')
    trim(leading '.' from geolocation) as region_name,
    
    -- Extract commodity numeric code (e.g., '01')
    split_part(commodity_description, ' - ', 1) as commodity_code,
    
    -- Extract the commodity label description (e.g., 'FOOD AND NON-ALCOHOLIC BEVERAGES')
    split_part(commodity_description, ' - ', 2) as commodity_group,
    
    -- Include all month columns dynamically or explicitly
    "2023_jan", "2023_feb", "2023_mar", "2023_apr", "2023_may", "2023_jun",
    "2023_jul", "2023_aug", "2023_sep", "2023_oct", "2023_nov", "2023_dec",
    "2024_jan", "2024_feb", "2024_mar", "2024_apr", "2024_may", "2024_jun",
    "2024_jul", "2024_aug", "2024_sep", "2024_oct", "2024_nov", "2024_dec",
    "2025_jan", "2025_feb", "2025_mar", "2025_apr", "2025_may", "2025_jun",
    "2025_jul", "2025_aug", "2025_sep", "2025_oct", "2025_nov", "2025_dec"
from raw_data