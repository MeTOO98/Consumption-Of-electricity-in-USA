# **US State Energy & Economic Performance Data Pipeline**

## **Project Overview**

This Data Engineering project delivers an end-to-end **Extract, Load, Transform (ELT) pipeline** for integrating multiple US data sources. The pipeline ingests electricity consumption data and Types of Source data from the **EIA API** and consolidates external files for **Population** and **Gross Domestic Product (GDP)**.

The core objective is to clean, standardize, and integrate these disparate sources into a high-performance **Galaxy Schema Dimensional Model**. This robust structure supports a dynamic Power BI dashboard, enabling analysts to **visualize energy consumption trends alongside economic indicators**, with full national and state-level detail.

## **Data Architecture: ELT Pipeline**

The project follows a modern Extract, Load, and Transform (ELT) architecture, **using Snowflake (SQL) for high-performance transformations, combined with Python for initial data pre-processing.**

1. **Extract & Load (Jupyter/Python):** Raw data is pulled from external APIs and local files, then loaded directly into the Staging Layer.  
2. **Staging Layer (SQL):** Raw data tables are created for initial storage, mirroring the source structure.  
3. **Transformation (Python & SQL):** Python handles initial cleaning and file consolidation, while Snowflake SQL executes data quality checks, standardization, deduplication, and consolidation of disparate staging tables.  
4. **Core Layer (SQL):** The final Dimensional Model is defined and populated, ready for analytics.  
5. **Reporting (Power BI):** The BI tool connects to the Core Layer Fact and Dimension tables to generate insights.

## **Data Sources**

The analysis relies on multiple reliable sources :

| Metric | Source | Description |
| :---- | :---- | :---- |
| **Electricity Data** | Energy Information Administration (EIA) API | Detailed monthly/annual data on electricity sales, consumption, and source types, segmented by **State and US Total**. |
| **Population** | External Files | **National and state-level** population data across various date ranges (2005-2024, split into multiple staging tables). |
| **GDP** | External File | **National and state-level** Gross Domestic Product . |

## **Stack Technology**

The following technologies and tools are utilized across the various stages of the ELT pipeline:

| Category | Technology | Purpose |
| :---- | :---- | :---- |
| **Programming** | Python | Primary language for data ingestion and initial pre-processing/cleaning. |
| **Libraries** | Pandas, Requests | Data manipulation/pre-processing (Pandas) and connecting to external APIs (Requests). |
| **Database / DWH** | Snowflake (SQL) | Cloud data warehouse used for Staging, Core layers, and all core ELT transformations. |
| **Execution** | Jupyter Notebook | Interactive environment used for running the extraction and loading scripts. |
| **Business Intelligence** | Power BI | Final data visualization, interactive dashboards, and KPI reporting. |

## **Project Files & Structure**

| Filepath | Type | Stage | Description |
| :---- | :---- | :---- | :---- |
| Extraction and ingestion/Extraction or Ingestion.ipynb | Jupyter Notebook (Python) | **E L** | Handles API connection (e.g., EIA), data fetching, and bulk loading of raw data into the staging tables. Includes initial date formatting. |
| Staging/Staging-layer.sql | SQL Script | **L** | Defines the structure (CREATE TABLE statements) for all raw staging tables (cons\_states, GPD\_states, pop\_5\_10, etc.) before transformation. |
| Transfermotion/Transformation\_.sql | SQL Script | **T (Cleaning)** | Executes data quality routines: data type correction, state/sector name standardization, filtering out incomplete records (e.g., 'other' sector sales), and consolidating population data. |
| Core/Core\_Layer\_.sql | SQL Script | **T (Modeling)** | Defines the final dimensional model (Dim\_States, Dim\_Date, GDP\_POP\_Fact, fact\_types). Populates these tables using the cleaned data from staging and transformation steps. |
| Cons\_Project | **Power BI Dashboard Link** | **Reporting** | The final BI dashboard: [View Live Dashboard](https://app.powerbi.com/view?r=eyJrIjoiNjIyNDUyZmMtNjkxZi00OTBkLWFjZmYtMjI0MDBiNjhkNTgxIiwidCI6ImM5NDdhYWExLTUxYzUtNDY3Yi04YWUwLTFhYTY0NzUxNmJjZiJ9) |

## **Data Model**

The core data is modeled using a **Galaxy Schema** (or multi-fact schema), featuring two main Fact tables (Fact\_Cons, fact\_types and GDP\_POP\_Fact) connected to shared Dimension tables like Dim\_States and Dim\_Date.

## **Examples of Insights**

The dimensional structure enables powerful, multi-faceted analytical queries, such as:

* **Consumption Efficiency:** Calculating the correlation coefficient between **GDP per Capita** and **Residential Electricity Sales per Capita** for the top 5 most populous states over the last decade.  
* **Economic Indicators:** Identifying states that demonstrate **decoupling**—where Gross Domestic Product (GDP) increases while industrial and commercial energy consumption either remains flat or decreases—suggesting improved energy efficiency.  
* **Energy Mix Analysis:** Visualizing how the mix of electricity sources (e.g., Renewable, Nuclear, Fossil Fuels) in a state impacts overall sales volume and whether this shift correlates with state-level population growth.  
* **Sector-Specific Trends:** Analyzing the percentage change in Commercial Sector electricity sales in high-growth states (e.g., Texas, Florida) compared to the National Average over the last five years to forecast future utility demand.
