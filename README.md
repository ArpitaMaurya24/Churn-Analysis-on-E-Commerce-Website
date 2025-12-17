#  E-commerce Customer Churn Analysis

This project focuses on analyzing customer behavior and identifying churn patterns in an e-commerce website.  
The analysis combines **Python for data cleaning**, **PostgreSQL for data storage and SQL analysis**, and **Power BI for visualization and insights**.



##  Project Overview

Customer churn is a major challenge in e-commerce businesses.  
This project aims to:
- Understand customer purchasing behavior
- Identify inactive and churn-prone customers
- Segment customers based on value and activity
- Provide actionable insights using interactive dashboards



##  Tools & Technologies

- **Python** (Jupyter Notebook)
  - Pandas, NumPy
  - Data cleaning and preprocessing
- **PostgreSQL**
  - Data storage
  - Advanced SQL analysis using joins, CTEs, window logic
- **Power BI**
  - Data modeling
  - DAX measures
  - Interactive dashboards with slicers & KPIs

---

##  Data Pipeline

1. Raw e-commerce data cleaned and prepared using **Python (Jupyter Notebook)**
2. Cleaned datasets loaded into **PostgreSQL**
3. Business questions answered using **SQL queries**
4. SQL outputs connected to **Power BI**
5. KPIs and visuals created using **DAX and filters**



##  Key SQL Analysis Performed

The following customer behavior and churn-related analyses were performed:

- Orders placed per customer
- Average order value per customer
- Most recent order date (recency)
- Number of reviews written per customer
- Number of unique product categories purchased
- Most frequently bought product
- Customers active in the last 30 days
- Low-frequency but high-value customers
- Customers with pending or cancelled orders
- Cart abandonment without purchase
- Days since last order (recency metric)
- Total monetary value per customer
- Customers inactive for 60+ days
- One-time buyers who never returned
- Customers with highest lifetime value (LTV)
- Customer value segmentation (High / Medium / Low)
- Churned segment analysis (90+ days inactive)
- Comprehensive customer-level summary including:
  - Total orders
  - Total items bought
  - Categories purchased
  - Total spend
  - Days since last order
  - Reviews count
  - Abandoned cart count



##  Power BI Dashboard

The Power BI dashboard includes:

- **KPIs**
  - Total Customers
  - Churn Rate
  - Total Orders
  - Average order Frequency
  - Active Customer

- **Visuals**
  - Orders in each month
  - Customer behaviour (view/cart/wishlist/purchase)
  - order status
  - Recency-based churn trends
  - Top Reviews

- **Features**
  - Interactive slicers (gender, rating, customer status, month)
  - DAX measures for churn, recency, frequency, and monetary metrics
  - Drill-down analysis for customer behavior



##  Project Structure

```text
ecommerce-churn-analysis/
│── data/
│── notebooks/
│   └── data_cleaning.ipynb
│── sql/
│   └── churn_analysis_queries.sql
│── powerbi/
│   └── churn_dashboard.pbix
│── README.md
