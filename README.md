# 🇵🇭 Philippine Macroeconomic CPI Tracking Pipeline (ELT)

An end-to-end Extract, Load, Transform (ELT) data pipeline designed to ingest, normalize, and visualize the regional Year-on-Year Changes of the Consumer Price Index (CPI) in the Philippines (Jan 2023 – Dec 2025).

## Project Architecture Overview
* **Extract & Load:** Ingested a wide-format, heavily unstructured macroeconomic CSV dataset into a local **PostgreSQL** data warehouse utilizing Python (`pandas` + `sqlalchemy`).
* **Transform:** Utilized **dbt (Data Build Tool)** to implement string normalization, split category metadata codes, and unpivot 36 months of data columns into a highly dynamic, unified time-series fact table.
* **Visualize:** Modeled a high-performance executive dashboard in **Tableau** to monitor structural commodity trajectories and highlight regional volatility indexes.

---

## Project Repository Structure
```text
ph-cpi-project/
├── data/                                       # Raw data storage (Gitignored)
├── scripts/                                    # Ingestion scripts
│   └── load_cpi_data.py                        # Python ingestion to PostgreSQL
├── transform_dbt/                              # Core transformation folder
│   ├── models/
│   │   ├── staging/                            # Staging Layer (Cleaning & Typing)
│   │   │   ├── src_macro.yml
│   │   │   └── stg_cpi_inflation.sql
│   │   └── marts/                              # Marts Layer (Business-ready Tables)
│   │       ├── fct_cpi_trends.sql              # Unpivoted Time-Series Fact table
│   │       └── dim_regional_volatility.sql     # Materialized volatility dimensions
├── dashboards/                                 # BI Deliverables
│   └── cpi_inflation_tracker.twbx              # Packaged Tableau Dashboard Workbook
├── .gitignore
├── requirements.txt
└── README.md

```

---

## Data Transformation Highlights (dbt)

The original source data was reporting months horizontally (`2023 Jan`, `2023 Feb`, etc.), making standard BI analytical expressions incredibly slow and limiting time-series capabilities.

### Key Transformations Executed:

1. **Text Normalization:** Trimmed administrative parsing noise (such as the double period `..` prefixing region rows like `..National Capital Region`).
2. **Dimension Splitting:** Extracted strict legal numeric category codes from their corresponding string literals (e.g., separating `01` from `FOOD AND NON-ALCOHOLIC BEVERAGES`).
3. **Data Unpivoting:** Restructured the layout into a clean, vertical table layout where each record isolates a specific `region_name`, `commodity_group`, `report_date`, and `yoy_inflation_rate`.

---

## Tableau Insights & Dashboard Layout

*(Tip: Take a high-resolution screenshot of your beautiful Tableau dashboard and replace the link below!)*


### Technical Hurdles & Design Pivots

* **Geographical Naming Ambiguity:** During development, several administrative region strings failed to match Tableau's native state/province map layer. To maximize visualization scalability without embedding custom polygon datasets, I pivoted the architecture to a **Sorted Horizontal Bar Chart**. This successfully omitted geographical scaling bias (giving small urban areas like NCR equal visibility next to geographically massive regions) and allowed for instantaneous ranked sorting.
* **Granular Aggregation Handling:** Standard deviation components originally suffered from pre-aggregation summation errors inside the text card grid. Resolving this via strict `MAX` and `AVG` measure level overrides inside Tableau successfully normalized historical volatility scales to true-to-life macroeconomic intervals.

### Analytical Takeaways

* **Supply-Side Shock Capturing:** The line matrix identifies a massive divergence between volatile commodity groupings (such as Food and Energy peaks through late 2023) and sticky structural indices (Education/Communication), effectively showcasing standard central bank logic for balancing core vs. headline inflation filters.
* **Geographic Instability:** Island regions and agricultural hubs outside of NCR show a significantly higher Standard Deviation in commodity changes over time, proving a localized economic dependency on seasonal logistics and transport premiums.

---

## How to Reproduce Locally

1. **Clone the repository:**
```bash
git clone https://github.com/AmadeusMMIII/ph-cpi-project.git
cd ph-cpi-project
```


2. **Install dependencies:**
```bash
pip install -r requirements.txt
```


3. **Run Ingestion:** Set up your environment variables or replace your local PostgreSQL connection string inside `scripts/load_cpi_data.py` and run:
```bash
python scripts/load_cpi_data.py
```


4. **Execute dbt Models:** Navigate to the `transform_dbt` folder, configure your database targets inside `profiles.yml`, and run:
```bash
dbt run
```


5. **Open Workbook:** Connect Tableau to your newly compiled `analytics.fct_cpi_trends` target schema table or review the packaged `cpi_inflation_tracker.twbx` file!