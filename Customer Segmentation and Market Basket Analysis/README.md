# 🛒 Customer Segmentation & Market Basket Analysis

This project is part of my MSc in Data Science and focuses on analyzing customer behavior and product purchase patterns using real-world data from an 
online supermarket delivery platform.

The study combines **Exploratory Data Analysis (EDA)**, **Customer Segmentation**, and **Market Basket Analysis (MBA)** to extract business insights and
actionable recommendations.

## 📁 Project Structure


## 📊 Key Objectives

- Understand customer purchasing behavior through data exploration.
- Segment customers based on purchasing patterns using clustering techniques.
- Analyze frequent product combinations with Market Basket Analysis.
- Translate analytical findings into strategic business recommendations.
  

## 🔍 Methods and Techniques

### 1. Exploratory Data Analysis (EDA)
- Data cleaning and preprocessing (handling nulls, renaming, feature engineering).
- Visualizations (order trends, regional patterns, price distributions, customer activity).
- Power BI used for interactive dashboards and business insights.

### 2. Customer Segmentation
- Clustering using K-Means based on Recency, Frequency, and Monetary (RFM) variables.
- Elbow Method and Silhouette Score used to determine optimal clusters.
- Final segments:
  - **Loyalists**
  - **Potential Loyalists**
  - **Churners**

### 3. Market Basket Analysis (MBA)
- Association Rule Mining using Apriori and FP-Growth algorithms.
- Focused on product name and category combinations.
- Rule metrics: Support, Confidence, Lift, Leverage, Conviction.
- Separate analysis for each customer segment to identify targeted product bundles.


## 📈 Key Findings

- Peak order time: Between **20:00–21:00** across all days.
- Most active regions: **Drosia, Anoixi, Dionisos** (wealthier areas with higher frequency).
- **Cigarettes** and **Terea** dominate revenue in urban regions like Athens and Thessaloniki.
- **FP-Growth** yielded more meaningful product association rules than Apriori.
- Targeted bundles and promotions can be developed per segment for better retention.


## 🧠 Tools & Technologies

- **SQL**: Data exploration and filtering
- **Python (Pandas, Scikit-learn, MLxtend)**: Data processing, clustering, MBA
- **Power BI**: Dashboard creation and interactive data visualization
- **Jupyter Notebook**: Code development and analysis documentation


## 📌 Author

**Nikolaos Petrakos**  
MSc Data Science – Business & Data Analytics Track  
www.linkedin.com/in/nikolaospetrakos


## 📜 License

This project is for academic and portfolio use only. If you'd like to collaborate or repurpose elements, feel free to reach out!
