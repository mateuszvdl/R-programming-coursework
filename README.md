# R Programming Coursework

This repository contains scripts and projects from my university coursework in the R programming language, focusing on data analysis and statistical computing.

---

## Scripts Included

### 1. R Basics
* **File:** `01_r_basics.R`
* **Description:** An introductory script covering the fundamental syntax of R.
* **Topics Covered:**
    * Basic arithmetic operations.
    * Variable assignment using `<-`.
    * Creating numeric and character vectors with the `c()` function.
    * Loading packages with the `library()` function.

### 2. Data Frames and Importing Data
* **File:** `02_data_frames_and_import.R`
* **Description:** This script covers creating data sequences, addressing vectors, and the basics of working with data frames, including loading external data.
* **Topics Covered:**
    * Creating sequences with `seq()` and the `:` operator.
    * Indexing and subsetting vectors.
    * Handling special values like `NA`, `NaN`, and `Inf`.
    * Loading and inspecting a built-in data frame (`titanic` dataset).
    * Calculating descriptive statistics (`summary()`, `mean()`).
    * Creating a basic histogram with `hist()`.
    * Importing data from an Excel file using the `readxl` package.

### 3. Data Manipulation with `tidyverse`
* **File:** `03_data_manipulation_with_tidyverse.R`
* **Description:** This script introduces the `tidyverse`, a powerful collection of R packages for data science. It focuses on data manipulation and transformation workflows.
* **Topics Covered:**
    * Importing data with `readxl` and `readr`.
    * Cleaning column names with `janitor`.
    * Using the pipe operator `|>` for readable code.
    * Filtering rows with `filter()`.
    * Selecting columns with `select()` and its helper functions.
    * Creating new variables with `mutate()`.
    * Grouping and summarizing data with `group_by()` and `summarize()`.
    * Sorting data with `arrange()`.

### 4. Advanced Data Wrangling and Basic Stats
* **File:** `04_advanced_data_manipulation.R`
* **Description:** This script continues with `tidyverse` workflows, focusing on reshaping data and joining tables, and concludes with a basic statistical test.
* **Topics Covered:**
    * Reshaping data from long to wide format with `pivot_wider()`.
    * Reshaping data from wide to long format with `pivot_longer()`.
    * Joining data frames with `full_join()` and `inner_join()`.
    * Performing an independent samples t-test with `t.test()`.

### 5. Statistical Testing with `rstatix`
* **File:** `05_statistical_testing_t_tests.R`
* **Description:** This script focuses on performing and interpreting an independent samples t-test, a fundamental statistical analysis.
* **Topics Covered:**
    * Checking statistical assumptions.
    * Using packages like `skimr` for summary statistics and `ggpubr` for plotting.
    * Calculating and interpreting a t-test using the `rstatix` package.
    * Calculating effect size with Cohen's d.

---

## How to Run

To run these scripts, you will need to have R installed on your system. It is highly recommended to use an IDE like **RStudio**.

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/your-username/R-programming-coursework.git](https://github.com/your-username/R-programming-coursework.git)
    cd R-programming-coursework
    ```
    *(Replace `your-username` with your actual GitHub username).*

2.  **Install Packages:**
    These scripts use several external packages. Before running, you may need to install them from the R console:
    ```R
    install.packages(c("tidyverse", "readxl", "readr", "janitor", "titanic", "skimr", "rstatix", "datarium", "ggpubr"))
    ```

3.  **Open in RStudio:**
    Open the `.R` files in RStudio. You can run the code line-by-line or execute the entire script to see the output in the console.
