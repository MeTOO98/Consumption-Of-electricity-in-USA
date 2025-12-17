# **US and States Energy & Economic Performance Data Pipeline**

## **Project Overview**

This Data Engineering project delivers an end-to-end **Extract, Load, Transform (ELT) pipeline** for integrating multiple US data sources. The pipeline ingests electricity consumption data and Types of Source data from the **EIA API** and consolidates external files for **Population** and **Gross Domestic Product (GDP)**.

The core objective is to clean, standardize, and integrate these disparate sources into a high-performance **Galaxy Schema Dimensional Model**. This robust structure supports a dynamic Power BI dashboard, enabling analysts to **visualize energy consumption trends alongside economic indicators**, with full national and state-level detail.

## **Data Architecture: ETL Pipeline**

The project follows a modern Extract, Load, and Transform (ELT) architecture, **using Snowflake (SQL) for high-performance transformations, combined with Python for initial data pre-processing.**

1. **Extract & Load (Jupyter/Python):** Raw data is pulled from external API and local files, then loaded directly into the Staging Layer.  
2. **Staging Layer (SQL):** Raw data tables are created for initial storage, mirroring the source structure.  
3. **Transformation (Python & SQL):** Python handles initial cleaning and file consolidation, while Snowflake SQL executes data quality checks, standardization, deduplication, and consolidation of disparate staging tables.  
4. **Core Layer (SQL):** The final Dimensional Model is defined and populated, ready for analytics.  
5. **Reporting or Analysis (Power BI):** The BI tool connects to the Core Layer Fact and Dimension tables to generate insights.

<img width="6718" height="1743" alt="architecture" src="https://github.com/user-attachments/assets/e370cd97-d241-4c75-9a83-046b91f2e50c" />  


## **Data Sources**

The analysis relies on multiple reliable sources :

| Metric | Source | Description |
| :---- | :---- | :---- |
| **Electricity Data** | Energy Information Administration (EIA) API | Detailed monthly/annual data on electricity sales, consumption, and source types, segmented by **State and US Total**. |
| **Population** | External Files | **National and state-level** population data across various date ranges (2005-2022, split into multiple staging tables). |
| **GDP** | External File | **National and state-level** Gross Domestic Product . |

## **Stack Technology**

The following technologies and tools are utilized across the various stages of the ELT pipeline:

| Category | Technology | Purpose |
| :---- | :---- | :---- |
| **Programming** | Python | Primary language for data ingestion and initial pre-processing/cleaning. |
| **Libraries** | Pandas, Requests | Data manipulation/pre-processing (Pandas) and connecting to external APIs (Requests). |
| **DWH** | Snowflake (SQL) | Cloud data warehouse used for Staging, Core layers, and all core ELT transformations. |
| **Execution** | Jupyter Notebook | Interactive environment used for running the extraction and loading scripts. |
| **Business Intelligence** | Power BI | Final data visualization, interactive dashboards, and KPI reporting. |

## **Project Files & Structure**

| Filepath | Type | Stage | Description |
| :---- | :---- | :---- | :---- |
| Extraction and ingestion/Extraction and Ingestion.ipynb | Jupyter Notebook (Python) | **E L** | Handles API connection (e.g., EIA), data fetching, and bulk loading of raw data into the staging tables. Includes initial date formatting. |
| Staging/Staging-layer.sql | SQL Script | **L** | Defines the structure (CREATE TABLE statements) for all raw staging tables (cons\_states, GPD\_states, pop\_5\_10, etc.) before transformation. |
| Transformotion/Transformation\_.sql | SQL Script | **T (Cleaning)** | Executes data quality routines: data type correction, state/sector name standardization, filtering out incomplete records (e.g., 'other' sector sales), and consolidating population data. |
| Core/Core\_Layer\_.sql | SQL Script | **T (Modeling)** | Defines the final dimensional model (Dim\_States, Dim\_Date, GDP\_POP\_Fact, fact\_types). Populates these tables using the cleaned data from staging and transformation steps. |
| Dashboard | **Power BI Dashboard** | **Reporting** | The final BI dashboard: [View Live Dashboard](https://app.powerbi.com/view?r=eyJrIjoiNjIyNDUyZmMtNjkxZi00OTBkLWFjZmYtMjI0MDBiNjhkNTgxIiwidCI6ImM5NDdhYWExLTUxYzUtNDY3Yi04YWUwLTFhYTY0NzUxNmJjZiJ9) |

## **Data Model**

The core data is modeled using a **Galaxy Schema** (or multi-fact schema), featuring three main Fact tables (Fact\_Cons, fact\_types and GDP\_POP\_Fact) connected to shared Dimension tables like Dim\_States and Dim\_Date.

<img width="1247" height="737" alt="Model" src="https://github.com/user-attachments/assets/dd060dce-a853-4294-a638-d73a006deba4" />


## **Examples of Insights**

The dimensional structure enables powerful, multi-faceted analytical queries, such as:

* **Consumption Efficiency:** Calculating the correlation coefficient between **Consumption** and **GDP** and how we use electricity efficiently.  
* **Analyzing Economic Shocks:** The pipeline allows for time-series analysis to visualize the effect of major economic downturns (like the **2008 Financial Crisis** and **COVID-19 pandemic**) on both **state GDP** and **energy consumption**, showing differential state recovery patterns.    
* **Energy Mix Analysis:** Visualizing the mix of electricity sources (e.g., Renewable, Fossil Fuels) and the percentage of each source of them.  
