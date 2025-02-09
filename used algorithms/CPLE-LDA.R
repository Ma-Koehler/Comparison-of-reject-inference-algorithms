# The corresponding paper is: Loog, Marco. "Contrastive pessimistic likelihood estimation for semi-supervised classification." IEEE transactions on pattern analysis and machine intelligence 38.3 (2015): 462-475.

# Load Library (Reference: https://cran.r-project.org/web/packages/RSSL/index.html)
library(RSSL)

# Load data

accepts <- read.csv("../data/CPLE_accepts.csv", header=TRUE, stringsAsFactors=FALSE)
rejects  <- read.csv("../data/CPLE_rejects.csv", header=TRUE, stringsAsFactors=FALSE)

# Preprocessing, since the library wants the rejects labeled as NA

rejects$loan_status <- NA
unbiased_data <- rbind(accepts, rejects)
unbiased_data$loan_status <- factor(unbiased_data$loan_status, labels = c("0", "1"))
formula <- loan_status~.

# Model

CPLE_LDA <- MCPLDA(loan_status~.,unbiased_data, max_iter = 50)
CPLE_result <- CPLE_LDA@responsibilities

# Print results for the Python file

write.csv(CPLE_result, "../data/CPLE_result.csv")
