# Advanced Data Preprocessing and Statistical Normalization in R

This project demonstrates how raw and inconsistent sensor data (BALTEX dataset) is cleaned and statistically scaled before being integrated into machine learning models. The data preprocessing steps were implemented by creating custom functions from scratch in R based on the underlying mathematical formulas, rather than relying on ready-made (black-box) packages.

## Theoretical Approach: DIKW Hierarchy

From a Management Information Systems (MIS) perspective, raw data is misleading unless processed correctly. In this project, the data analytics cycle is structured around the DIKW (Data, Information, Knowledge, Wisdom) pyramid:

* **Data:** Raw Excel rows containing erroneous `-999` measurements and missing/invalid IDs (`-`).
* **Information:** The structured dataset obtained by identifying and cleaning erroneous sensor data to preserve statistical reliability.
* **Knowledge:** Converting variables with completely different units, such as Elevation, Catchment Size, and Latitude (meters, square meters, degrees), into the same scale using statistical algorithms (Min-Max and Z-Score).
* **Wisdom:** Using this prepared framework to prevent machine learning models (e.g., KNN, Linear Regression) from falsely assuming "larger numbers are more important," thereby laying the groundwork for algorithms to operate with maximum accuracy.

## Project Steps and Methodology

### 1. Data Cleaning and Missing Value Management

* `-999` values representing sensor reading errors were identified. This massive gap, accounting for 34% of the total dataset, was statistically removed to preserve the original variance of the data and prevent artificial clustering, rather than being synthetically imputed with algorithms like KNN.
* Rows with invalid/missing station IDs (`NAT_STA_ID`) entered as (`-`) were filtered out. In total, the 718 rows of raw data were reduced to a clean, analysis-ready table of 332 rows.

### 2. Feature Scaling

Instead of using built-in R functions like `scale()`, the statistical architecture was coded using custom functions:

* **Min-Max Normalization:** A modular function was created to compress variables with different units into a range between 0 and 1, making them comparable.
```R
min_max_yap <- function(x) {
  (x - min(x)) / (max(x) - min(x))
}

```


* **Z-Score (Standardization):** A standardization formula was applied to calculate how many standard deviations a data point is from the group mean, enabling outlier analysis.
```R
z_score <- (x - mean(x)) / sd(x)

```
