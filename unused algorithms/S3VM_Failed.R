# The corresponding paper is: Li, Zhiyong, et al. "Reject inference in credit scoring using semi-supervised support vector machines." Expert Systems with Applications 74 (2017): 105-114.

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
unbiased_sampled <- unbiased_data[sample(nrow(unbiased_data), nrow(unbiased_data)*0.01), ]

# Model, but sadly with only 1% of the data the model still has computational constraints

SV3M <- SelfLearning(loan_status~.,unbiased_sampled,method= SVM, prob = FALSE, cautious = FALSE,max_iter = 20)