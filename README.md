US Energy & Economic Performance Data Pipeline

🚀 Project Overview

This Data Engineering project implements an end-to-end Extract, Load, Transform (ELT) pipeline to integrate critical US data sources for economic and energy analysis.

The primary goal is to combine electricity consumption and source data from the EIA API with external files for Population and Gross Domestic Product (GDP). This standardized data is modeled into a high-performance Galaxy Schema Dimensional Model to support a dynamic Power BI dashboard. This structure allows analysts to visualize critical relationships, such as economic decoupling and shifting energy mixes, at both the national and state levels.

🛠️ Technology Stack

The pipeline uses a combination of Python for ingestion and Snowflake for robust, high-performance cloud data warehousing and transformation.

Category

Technology

Purpose

Programming

Python

Primary language for data ingestion and initial pre-processing.

Libraries

Pandas, Requests

Data manipulation/pre-processing (Pandas) and connecting to external APIs (Requests).

Database / DWH

Snowflake (SQL)

Cloud data warehouse used for Staging, Core layers, and all core ELT transformations.

Execution

Jupyter Notebook

Interactive environment for running extraction and loading scripts.

Business Intelligence

Power BI

Final data visualization, interactive dashboards, and KPI reporting.

📐 Data Architecture: ELT Pipeline

The project follows a standard ELT workflow:

Extract & Load (E/L): Raw data is fetched (EIA API, local files) and loaded directly into the Staging Layer using Python/Jupyter.

Staging Layer (L): Temporary tables in Snowflake store raw data, mirroring the source structure.

Transformation (T): Python handles initial cleaning, while Snowflake SQL executes data quality checks, standardization, and consolidation of staging tables.

Core Layer (T/Model): The final Galaxy Schema Dimensional Model is defined and populated, establishing the source of truth for analytics.

Reporting: Power BI connects to the Core Layer to generate analytical dashboards.

Examples of Key Analytical Insights

The dimensional model enables advanced analysis, including:

Consumption Efficiency: Calculating the correlation between GDP per Capita and Residential Electricity Sales per Capita for the most populous states.

Economic Decoupling: Identifying states where GDP growth is maintained while industrial and commercial energy consumption decreases, indicating improved energy efficiency.

Energy Mix Impact: Visualizing how the shift in electricity sources (Renewable, Nuclear, Fossil Fuels) correlates with economic performance indicators.

Sector-Specific Trends: Analyzing the percentage change in Commercial Sector electricity sales in high-growth states compared to the national average.

📁 Project Files & Structure

Filepath

Type

Stage

Description (Insight Focus)

Extraction and ingestion/Extraction or Ingestion.ipynb

Jupyter Notebook (Python)

E L

Initializes the data flow, securing raw EIA energy metrics and foundational GDP/Population data for subsequent analysis.

Staging/Staging-layer.sql

SQL Script

L

Establishes the foundation for all analysis by creating the raw tables that hold the initial, unfiltered State and National performance data.

Transformation/Transformation_.sql

SQL Script

T (Cleaning)

Executes data cleansing and consolidation to ensure accurate state-to-state and year-over-year comparisons for key insights (e.g., Decoupling).

Core/Core_Layer_.sql

SQL Script

T (Modeling)

Builds the final Galaxy Schema to enable powerful analytical queries, driving insights into economic vs. consumption efficiency.

Cons_Project.pbix

Power BI Report

Reporting

The final report containing interactive visualizations that highlight Decoupling, Energy Mix shifts, and Per Capita correlation findings.

Live Dashboard

Link

Reporting

View Live Dashboard

⚙️ Setup and Execution Guide

Prerequisites

Access to a Snowflake SQL environment.

Python environment with pandas and requests.

Jupyter Notebook or similar environment to run the ingestion script.

Power BI Desktop to view the report file (Cons_Project.pbix).

Step-by-Step Execution

Define Staging Schema: Execute the Staging/Staging-layer.sql script in your Snowflake environment.

Ingest Raw Data: Run the Extraction and ingestion/Extraction or Ingestion.ipynb notebook to fetch data from the EIA API and local files, loading it into the newly created staging tables.

Apply Transformations: Execute the Transformation/Transformation_.sql script to clean and standardize the data.

Build Core Model: Execute the Core/Core_Layer_.sql script to define and populate the final Dimension and Fact tables.

Reporting: Open Cons_Project.pbix in Power BI and refresh the data source, pointing it to your populated Core Layer tables in Snowflake.
