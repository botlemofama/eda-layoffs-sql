# Exploratory Data Analysis (EDA) – Global Tech Layoffs Dataset

## Overview
This project performs Exploratory Data Analysis (EDA) on a cleaned dataset of global tech layoffs. The goal is to uncover patterns, trends, and insights related to workforce reductions across companies, industries, and countries.

The dataset used in this analysis was first cleaned in a separate SQL Data Cleaning project.

---

## Dataset
The dataset includes information on layoffs such as:

- Company
- Industry
- Location
- Country
- Number of employees laid off
- Percentage of workforce laid off
- Company funding
- Company stage
- Date of layoffs

Source:
Kaggle – Tech Layoffs Dataset  
[https://www.kaggle.com/datasets/swaptr/layoffs-2022]
---

## Objectives

The analysis aims to answer key questions such as:

- Which companies laid off the most employees?
- Which industries were most affected?
- Which countries experienced the highest layoffs?
- How have layoffs changed over time?
- Which companies experienced complete workforce layoffs?

---

## Analysis Performed

### 1. Dataset Overview
Initial inspection of the dataset to understand structure and identify potential anomalies.

### 2. Extreme Layoff Events
Identified the largest layoff events based on:

- Maximum total layoffs
- Maximum percentage layoffs

### 3. Company-Level Analysis
Examined companies responsible for the largest workforce reductions.

Key questions explored:

- Which companies had the biggest single layoffs?
- Which companies laid off the most employees overall?

### 4. Geographic Analysis
Layoffs were aggregated by:

- Location
- Country

This helped identify regions most affected by layoffs.

### 5. Industry Analysis
Layoffs were analyzed by industry to determine which sectors experienced the most workforce reductions.

### 6. Company Stage Analysis
Layoffs were grouped by company stage to examine whether startups, growth companies, or mature companies were more vulnerable.

### 7. Time-Based Trends
Layoffs were analyzed across time periods including:

- Yearly layoffs
- Monthly layoffs
- Rolling cumulative layoffs

This helps reveal economic trends and potential cycles.

### 8. Ranking Analysis
Using window functions, the top 3 companies with the highest layoffs per year were identified.

---

## SQL Concepts Used

This project demonstrates:

- Aggregate Functions (`SUM`, `MAX`, `MIN`)
- Window Functions (`DENSE_RANK`)
- Common Table Expressions (CTEs)
- Grouping and Sorting
- Time-based analysis
- Rolling totals

---

## Tools Used

- SQL (MySQL)

---

## Key Insights

Some major insights from the dataset include:

- Certain companies experienced extremely large workforce reductions.
- Layoffs are concentrated in specific industries.
- Some companies laid off 100% of their workforce, indicating shutdowns.
- Layoffs show clear spikes during specific time periods.

---

## Author

SQL portfolio project demonstrating real-world exploratory data analysis techniques.
