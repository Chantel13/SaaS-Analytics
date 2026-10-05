SaaS Customer & Subscription Analysis

**SQL | Excel | Data Analysis | Business Reporting**

## Project Overview

This project analyses a SaaS business to understand how customers are acquired, how subscriptions perform, where revenue is generated, and where the business may be losing value through cancellations, payment issues and customer support challenges.

The analysis covers **January 2023 to August 2026** and uses multiple related datasets covering customers, subscriptions, payments, product usage, support tickets and marketing campaigns.

The goal was not only to identify what happened, but to translate the findings into practical business actions and identify what should be investigated next.

---

## The Business Questions

The analysis focused on a few key questions:

- How is the customer base growing?
- Which plans, industries and channels contribute most to revenue?
- How significant are subscription cancellations?
- Are payment failures and refunds creating potential revenue leakage?
- Where are customer support issues concentrated?
- How can the business improve retention and sustainable growth?

---

## Methodology

### SQL Analysis

I used SQL Server to analyse the relational datasets and answer the business questions.

The analysis included:

- `JOIN` to connect related customer, subscription, payment, usage and support data
- `COUNT`, `SUM` and `AVG` for business metrics
- `GROUP BY` and `ORDER BY` for comparisons and rankings
- `CASE` statements for conditional calculations
- `DATEDIFF` for support resolution analysis
- `YEAR`, `MONTH` and `DATENAME` for time-based analysis
- Subqueries and `CTE`s for more complex calculations
- Data quality checks to identify duplicates, invalid values, missing dates and inconsistent records

The analysis was structured around business questions rather than simply applying SQL functions for their own sake.

### Excel Visualisation

After completing the SQL analysis, I used Excel to bring information from the related datasets together using **XLOOKUP** and create a consolidated analysis for visualisation.

I then used pivot tables, charts and dashboard elements to communicate the most important results in a more accessible way.

---

## Key Findings & Business Actions

### 1. Revenue is growing, but sustainable growth depends on retention

Net revenue reached approximately **R13.99 million** across the analysis period.

Revenue increased from:

- **R1.62m in 2023**
- **R4.03m in 2024**
- **R4.90m in 2025**
- **R3.42m through August 2026**

The Business plan generated the highest plan-level revenue at approximately **R4.39m**, while Retail generated approximately **R2.73m** in industry revenue.

**What this means:**
The business has established strong revenue generation, but protecting existing recurring revenue becomes increasingly important as the customer base grows.

**Recommended action:**
Monitor recurring revenue and higher-value plan customers regularly, particularly customers showing signs of reduced usage or cancellation.

> *Note: 2026 covers January–August only and should therefore not be compared directly with full-year figures.*

---

### 2. Subscription cancellations are the biggest retention concern

The dataset contains **3,300 subscriptions**, including:

- **772 active**
- **2,528 cancelled**

Approximately **77% of recorded subscriptions are cancelled**. Cancellation levels are also relatively similar across the different plans.

**What this means:**
The finding highlights a clear retention concern, but the 77% figure should **not automatically be interpreted as a current churn rate**, because subscriptions began at different points in time.

**Recommended action:**
The next analysis should investigate:

- Customer tenure before cancellation
- Cancellation by acquisition channel
- Cancellation by industry and customer segment
- Usage before cancellation
- Payment failures followed by cancellation

This would help identify **which customers are most at risk and why they leave**.

---

### 3. Payment and billing issues may be affecting customer value

The payment data contains:

- **1,074 failed payments**
- **499 refunds**
- Approximately **R813,604** associated with failed payments
- Approximately **R385,799** associated with refunds

Billing was also the most common support issue, with **856 tickets**, and had the lowest average satisfaction among the major issue categories at approximately **2.9/5**.

**What this means:**
Payment and billing problems appear in both the financial and customer-support data, making them an important area to investigate.

**Recommended action:**

- Introduce automated payment retries
- Notify customers when payments fail
- Monitor repeated payment failures
- Investigate the main causes of refunds
- Analyse whether payment failures are followed by cancellations
- Investigate recurring billing-related support issues

The aim would be to distinguish temporary payment problems from genuine customer dissatisfaction.

---

### 4. Acquisition should be measured by customer value, not only volume

Referral and Organic Search were among the largest acquisition channels, bringing in **526** and **525 customers** respectively.

They also generated approximately:

- **R2.97m** in net revenue from Referral
- **R2.82m** from Organic Search

Campaign acquisition costs varied considerably.

**What this means:**
Acquiring more customers does not necessarily mean acquiring more valuable customers.

**Recommended action:**
Evaluate acquisition performance across the full customer journey:

**Acquisition Cost → Retention → Revenue → Customer Lifetime Value**

This would provide a better view of which channels and campaigns are contributing to sustainable growth.

---

## Overall Business Priorities

Based on the analysis, I would focus the next stage of the project on four areas:

1. **Improve customer retention** by understanding why and when customers cancel.
2. **Protect recurring revenue** by monitoring cancellations, payment failures and refunds together.
3. **Improve the billing experience** by investigating recurring billing issues and support dissatisfaction.
4. **Measure acquisition quality** by connecting acquisition costs with retention and customer value.

---

## Limitations

There were several limitations to the current analysis:

- The dataset is historical and represents the available data rather than a live business environment.
- The **77% cancelled-subscription figure is not treated as a formal churn rate** because subscription start dates vary.
- The analysis identifies patterns and relationships but does not establish causation.
- More detailed customer tenure, cancellation-reason and customer-lifetime-value analysis would be needed to explain *why* customers leave.
- The Excel dashboard is **static**, so users cannot dynamically filter and drill into individual customer segments or other dimensions.

These limitations also helped identify the next analytical questions rather than being treated as problems with the project.

---

## Next Steps

To take the project further, I would:

### Analytical

- Build a cohort retention analysis
- Analyse customer tenure before cancellation
- Connect payment failures with subsequent cancellations
- Analyse feature usage against retention
- Calculate Customer Lifetime Value (CLV)
- Compare acquisition cost with long-term customer value

### BI

Rebuild the Excel dashboard in **Power BI** with:

- Interactive filters
- Drill-down analysis
- Dynamic KPIs
- Customer, plan and industry segmentation
- Retention and revenue monitoring

This would turn the current static analysis into a more interactive business intelligence solution.

---

## Project Deliverables
```
SaaS-Analytics/
│
├── README.md
├── SaaS_Analysis.sql
├── SaaS_Dashboard.xlsx
├── Business_Report.pdf
└── images/
    └── SaaS Business Analytics Dashboard.png
```

### Dashboard Preview

![SaaS Business Analytics Dashboard](SaaS%20Business%20Analytics%20Dashboard.png)

---

## Final Takeaway

The analysis shows a SaaS business with **strong revenue generation, a growing customer base and broad product usage**.

The bigger opportunity is making that growth sustainable.

Rather than focusing only on acquiring more customers, the analysis points towards **retention, payment reliability, billing experience and customer value** as areas that deserve further attention.

The next stage would therefore be to move from understanding **what happened** to understanding **why it happened**, and then use those insights to support better retention, revenue and customer experience decisions.

---

**Tools:** SQL Server | Excel | XLOOKUP | Pivot Tables | Data Visualisation | Business Analysis
