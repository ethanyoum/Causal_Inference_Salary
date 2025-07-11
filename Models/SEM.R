## SEM (Simultaneous Equations Model)

# Load AER library
library(AER)

# Check if treatment and job_title exist
table(data$job_title, data$treatment)

# Check instruments
table(data$company_size, data $experience_level)

# Define the simultaneous equations
eq1 <- salary_in_usd ~ treatment + job_title + experience_level  # Salary equation
eq2 <- treatment ~ salary_in_usd + job_title + experience_level  # Work setting equation

# Check if treatment and job_title exist
table(data$job_title, data$treatment)

unique(data$job_title)

summary(data$company_size)
summary(data$experience_level)

data$job_title <- relevel(as.factor(data$job_title), ref = "Data Analyst")

# Define the Simultaneous Equations Model (SEM)
eq1 <- salary_in_usd ~ treatment + experience_level   # Salary Equation
eq2 <- treatment ~ salary_in_usd + company_size       # Work Setting Equation

# Define Instrumental Variables (IVs)
inst1 <- ~ company_size   # Instrument for Work Setting (treatment)
inst2 <- ~ experience_level  # Instrument for Salary (salary_in_usd)

# Create a list of equations
iv_formula <- list(eq1, eq2)

# Run the 2SLS Estimation
SEM.model <- systemfit(iv_formula, method = "2SLS", inst = list(inst1, inst2), data = data)

# Print model results
summary(SEM.model)

# Correlation matrix
cor_matrix <- cor(data %>% select_if(is.numeric))
print(cor_matrix)
