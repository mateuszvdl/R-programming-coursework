# R Programming Coursework

This repository contains scripts and projects from my university coursework in the R programming language, focusing on data analysis and statistical computing.

---

## Scripts Included

### 1. R Basics
* **File:** `01_r_basics.R`
* **Description:** An introductory script covering the fundamental syntax of R.

### 2. Data Frames and Importing Data
* **File:** `02_data_frames_and_import.R`
* **Description:** This script covers creating data sequences, addressing vectors, and the basics of working with data frames, including loading external data.

### 3. Data Manipulation with `tidyverse`
* **File:** `03_data_manipulation_with_tidyverse.R`
* **Description:** This script introduces the `tidyverse`, a powerful collection of R packages for data science. It focuses on data manipulation and transformation workflows.

### 4. Advanced Data Wrangling and Basic Stats
* **File:** `04_advanced_data_manipulation.R`
* **Description:** This script continues with `tidyverse` workflows, focusing on reshaping data and joining tables, and concludes with a basic statistical test.

### 5. Statistical Testing with `rstatix`
* **File:** `05_statistical_testing_t_tests.R`
* **Description:** This script focuses on performing and interpreting an independent samples t-test, a fundamental statistical analysis.

### 6. One-Sample and Non-Parametric Tests
* **File:** `06_one_sample_and_non_parametric_tests.R`
* **Description:** This script demonstrates how to perform a one-sample t-test and introduces non-parametric testing with the Wilcoxon test.

### 7. Correlation Analysis
* **File:** `07_correlation_analysis.R`
* **Description:** This script focuses on exploring relationships between variables using correlation analysis.

### 8. Data Visualization with `ggplot2`
* **File:** `08_data_visualization_with_ggplot2.R`
* **Description:** This script introduces `ggplot2`, a powerful and versatile library for creating complex and aesthetically pleasing data visualizations.

### 9. Linear Regression
* **File:** `09_linear_regression.R`
* **Description:** This script introduces linear regression for modeling the relationship between a dependent and an independent variable.
* **Topics Covered:**
    * Visualizing linear trends with `geom_smooth(method = "lm")`.
    * Building a linear model using the `lm()` function.
    * Interpreting model results with `summary()`.
    * Using packages like `sjPlot` and `broom` for model analysis.

---

## How to Run

To run these scripts, you will need to have R and preferably RStudio installed.

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/your-username/R-programming-coursework.git](https://github.com/your-username/R-programming-coursework.git)
    cd R-programming-coursework
    ```
    *(Replace `your-username` with your actual GitHub username).*

2.  **Install Packages:**
    These scripts use several external packages. Before running, you may need to install them from the R console:
    ```R
    install.packages(c("tidyverse", "readxl", "readr", "janitor", "titanic", "skimr", "rstatix", "datarium", "ggpubr", "PerformanceAnalytics", "xlsx", "PogromcyDanych", "ggrepel", "ggthemes", "jtools", "sjPlot", "ggfortify", "broom"))
    ```
    *Note: The `xlsx` package requires Java to be installed on your system.*

3.  **Open in RStudio:**
    Open the `.R` files in RStudio. You can run the code line-by-line or execute the entire script to see the output.

---

## License

This project is licensed under the [BSD 3-Clause License](LICENSE).
