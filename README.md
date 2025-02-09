# Title

**Type:** A comparison of modern reject inference algorithms for synthetically created missing values in loan data

**Author:** Max Köhler

**1st Examiner:** Prof. Dr. Stefan Lessmann

**2nd Examiner:** Prof. Dr. Matthias Weidlich

These are my main results for the reject inference algorithms:

<img width="1103" alt="Bildschirmfoto 2025-02-09 um 20 57 03" src="https://github.com/user-attachments/assets/416a025f-478f-4604-bf29-b1737839da0e" />


## Table of Content

- [Summary](#summary)
- [Working with the repo](#Working-with-the-repo)
    - [Dependencies](#Dependencies)
    - [Setup](#Setup)
- [Reproducing results](#Reproducing-results)
    - [Training code](#Training-code)
    - [Evaluation code](#Evaluation-code)
    - [Pretrained models](#Pretrained-models)
- [Results](#Results)
- [Project structure](-Project-structure)

## Summary

**Keywords**: Credit Scoring, Reject Inference, Data Analysis, Data Generation

**Full text**: This bachelor's thesis aims to compare modern reject inference frameworks. For this I used real world data from Lending Club and created accepts and rejects synthetically through a data generation process. On this generated data I compared the AUC, Brier Score and KS-Statistic for my implemented reject inference frameworks.
The GitHub repository contains the data generation process as well as the implementations for the reject inference frameworks.

## Working with the repo

### Dependencies

I use Python 3.12 in my macOS-environment. You can use my requirements.txt, but I mostly use standard librarys like Scikit-learn or imbalanced-learn.

For the R implementations you need to install the package RSSL: https://cran.r-project.org/web/packages/RSSL/index.html.

### Setup

1. Clone this repository

2. Install requirements 
```bash
pip install --upgrade pip
pip install -r requirements.txt
```

## Reproducing results

### Preparing the data

You need to first create the files "accepts_original.parquet" and "rejects_original.parquet" and if you follow the implementations and their order accordingly you can create the rest of the data yourself through the data generation process.

First take a look at the "Data_Preprocessing.ipynb" file. There I use my original Lending Loan accepts and rejects and set them up for the data generation process. I also showcase their statistics and do statistical tests.

In the data generation file "Data_Generation.ipynb" I rebalance my data and create an unbiased dataset from my accepts only. Thus we have synthetically generated accepts and rejects. I use the accepts as a baseline, then rebalance my data using SMOTE oversampling. After that I employ a scorecard to predict probabilities of default and assign my observations to accepts and rejects, where we know the true outcome loan_status. I also showcase their statistics and do some statistical analysis.

Furthermore there is a small file "Coefficient_Analysis.ipynb" for the analysis of the coefficients of the accetps. This file showcases the unobserved variables and the correlation matrix used in the thesis. But this is not necessary for the reject inference models.
There is also some R-Code used.

### The used models

I have implemented 5 models in the folder "used algorithms", which are used for the thesis.

1. Logistic_Regression.ipynb
2. Shallow_Self-learning.ipynb
3. Naive_Bayes.ipynb
4. Label_Spreading.ipynb
5. CPLE-LDA.ipynb and CPLE-LDA.R (this is a special case since the data preprocessing and the analysis of the results is done in the ipynb file but the implementation was done in R using the RSSL package)

There are further models in the folder "unused algorithms" which I tried to implement but those sadly did not work or I the computational constraint was too high:

1. CPLE-LightGBM.ipynb
2. SV3M.R (this file is also dependent on the file "CPLE-LDA.ipynb" since it uses the same scaled data that this file produces as input)

## Results

The results are directly shown in the ipynb files. At the end I calculate the AUC, Brier Score and KS-Statistic in each ipynb file.

## Project structure

```bash
├── README.md
├── requirements.txt                                -- required libraries
├── data                                            -- stores csv and parquet files
└── Data Generation
    ├── Data_Preprocessing.ipynb                    -- preprocesses data
    ├── Data_Generation.ipynb                       -- generate new accepts and rejects
    └── Correlation_Analysis.ipynb                  -- analyse correlation of unobserved variables
├── used algorithms
    ├── Logistic_Regression.ipynb                   -- Implementation of Logistic Regression on accepts
    ├── Shallow_Self-learning.ipynb                 -- Implementation of Shallow Self-learning
    ├── Naive_Bayes.ipynb                           -- Implementation of Naive Bayes EM
    ├── Label_Spreading.ipynb                       -- Implementation of Label Spreading    
    ├── CPLE-LDA.ipynb                              -- Preprocess and result of CPLE-LDA    
    └── CPLE-LDA.R                                  -- Implementation of result of CPLE-LDA    
├── unused algorithms
    ├── CPLE-LGBM_Failed.ipynb                      -- Failed implementation of CPLE-LightGBM
    └── SV3M_Failed.R                               -- Failed implementation of SV3M
```
