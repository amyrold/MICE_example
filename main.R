# Table of Contents ----

#==============================================================================#
# 0. ----
# Install packages
install.packages("mice")
install.packages("MASS")

# Load packages
library(mice)
library(MASS)

#==============================================================================#
# 1. Simulate Data ----
# Set seed for reproducibility
set.seed(123)

# Define the mean vector and covariance matrix
mean_vector <- c(50, 30, 20)
cov_matrix <- matrix(c(100, 50, 30, 50, 40, 20, 30, 20, 50), ncol = 3)

# Generate the data
simulated_data <- mvrnorm(n = 100, mu = mean_vector, Sigma = cov_matrix)

# Convert to a data frame and name the columns
simulated_df <- as.data.frame(simulated_data)
colnames(simulated_df) <- c("Feature1", "Feature2", "Feature3")

# View the first few rows of the data
head(simulated_df)

#==============================================================================#
# 2. Introduce missingness to data ----

# Define the parameters for missing data
# Here, we specify a simple mechanism for missingness, but this can be customized
# 'prop' defines the proportion of missing data
# 'patterns' defines the missing data pattern across variables
amp <- ampute(data = simulated_df,prop = 0.2)$amp

# View the dataset with missing values
head(amp)
#==============================================================================#
# 3. Impute the missing values ----

# Applying MICE to impute missing data
imputedData <- mice(amp, m=5, method='pmm', seed=500)

# Create a complete dataset from the imputed datasets
completedData <- complete(imputedData, action = 1)

# View the original and completed data
head(amp)
head(completedData)

















