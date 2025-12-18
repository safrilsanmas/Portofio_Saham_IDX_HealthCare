# Health Sector Stock Portfolio Optimization using PAM Clustering
**Research Portfolio | Undergraduate Thesis (Statistics)**

---

## 📌 Project Overview
This repository contains a **full research pipeline script** developed as part of my undergraduate thesis in Statistics.  
The project focuses on **stock portfolio formation in the Indonesian health sector** by integrating clustering techniques and downside-risk–based portfolio optimization.

The analysis supports **data-driven investment decision-making** under asymmetric risk conditions by combining statistical learning methods and financial risk modeling.

---

## 🎯 Research Objectives
The objectives of this research are to:
- Cluster health sector stocks using **Partitioning Around Medoids (PAM) Clustering**
- Reduce dimensionality and multicollinearity using **Principal Component Analysis (PCA)**
- Select representative stocks from each cluster
- Construct an optimal portfolio using the **Mean–Semivariance approach**
- Measure portfolio risk using **Value at Risk (VaR)** with Historical Simulation
- Evaluate portfolio performance using the **Sharpe Ratio**

---

## 🛠️ Methodology Summary

### 1. Exploratory Data Analysis
- Descriptive statistics (manual computation)
- Outlier detection using **Mahalanobis Distance**

### 2. Data Preprocessing
- Standardization using **Maximum Absolute Scaling**
- Assumption testing:
  - Kaiser–Meyer–Olkin (KMO)
  - Multicollinearity (Variance Inflation Factor)

### 3. Dimensionality Reduction
- **Principal Component Analysis (manual computation)**
- Eigenvalue–eigenvector decomposition
- Construction of principal component scores

### 4. Clustering Analysis
- Distance measurement using **Euclidean Distance**
- Clustering using **Partitioning Around Medoids (PAM)**
- Determination of optimal number of clusters using **Silhouette Index**

### 5. Portfolio Construction
- Log return calculation
- Downside risk measurement using **Semivariance and Semicovariance**
- Portfolio weight optimization using matrix inversion

### 6. Risk and Performance Evaluation
- **Value at Risk (VaR)** using Historical Simulation (1, 5, and 20 holding periods)
- **Sharpe Ratio** using BI Rate as the risk-free rate

---

## 📐 Mathematical Formulation (Key Concepts)

- **Log Return**  
  \( R_t = \ln(P_t / P_{t-1}) \)

- **Semivariance**  
  \( SV_i = E[\min(R_i - B, 0)^2] \)

- **Mean–Semivariance Portfolio**  
  \( \mu_p = \sum w_i \mu_i \)  
  \( SV_p = w^T SV w \)

- **Value at Risk (Historical Simulation)**  
  \( VaR_{\alpha} = Q_{\alpha}(R_p) \)

- **Sharpe Ratio**  
  \( SR = (E(R_p) - R_f) / \sigma_p \)

---

## 📂 Script Description
The complete analysis is implemented in a single script:

```text
full_research_pipeline_health_sector.R
