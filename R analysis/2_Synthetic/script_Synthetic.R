###############################################################################
###############################################################################
###############################################################################

# Synthetic Data Generation in R

##############################################################################

# Packages --------------------------------------------------------------------

library(xgboost)
library(tsibble)
library(feasts)
library(dplyr)
library(ggplot2)

# Dataset ---------------------------------------------------------------------

# Microdata 
df <- readRDS(
  paste0(
    c(unlist(strsplit(getwd(), "/"))[1:(length(unlist(strsplit(getwd(), "/")))
                                        -2)], # removing 2 levels in files hierarchy
      "0_Data"
      ),collapse = '/'
  )
)



data <- read.csv("data/data.csv",
                 sep = "\t"
                 )
# str(data)

var_all <- c(
    "age" 
   ,"gender"  
   ,"married"   
   ,"religion"
   ,"education" 
   ,"urban"  
   ,"engnat"  
   ,"hand"   
   ,"orientation" 
   ,"race"     
   ,"voted"       
   ,"familysize" 
             )

df <- data[,var_all]

# "age" 
table(df$age)
df <- df[df$age < 100,]
table(df$age)
hist(df$age)
# "gender"  
# 1=Male, 2=Female, 3=Other
table(df$gender)
df$gender <- as.factor(df$gender)
df <- df[df$gender %in% c(1,2),]
df$gender <- droplevels(df$gender)
levels(df$gender) <- c("Male", 
                       "Female")
table(df$gender)
# "married" 
# 1=Never married, 2=Currently married, 3=Previously married
df$married <- as.factor(df$married)
df <- df[df$married %in% c(1:3),]
df$married <- droplevels(df$married)
levels(df$married) <- c("Never married", 
                       "Currently married",
                       "Previously married")
table(df$married)
# "religion" 
# 1=Agnostic, 2=Atheist, 3=Buddhist, 4=Christian (Catholic), 
# 5=Christian (Mormon), 6=Christian (Protestant), 7=Christian (Other),
# 8=Hindu, 9=Jewish, 10=Muslim, 11=Sikh,
df$religion <- as.factor(df$religion)
df <- df[df$religion %in% c(1:11),]
df$religion <- droplevels(df$religion)
levels(df$religion) <- c("Agnostic", 
                         "Atheist", 
                         "Buddhist", 
                         "Catholic", 
                         "Mormon", 
                         "Protestant", 
                         "Other Christian",
                         "Hindu", 
                         "Jewish", 
                         "Muslim", 
                         "Sikh")
table(df$religion)
# "education"  
# 1=Less than high school, 2=High school, 3=University degree, 
# 4=Graduate degree
df$education <- as.factor(df$education)
table(df$education)
df <- df[df$education %in% c(1:4),]
df$education <- droplevels(df$education)
levels(df$education) <- c("Lesser", 
                          "High school",
                          "University",
                          "Graduate")
table(df$education)
# "urban"  
# 1=Rural (country side), 2=Suburban, 3=Urban (town, city)
df$urban <- as.factor(df$urban)
df <- df[df$urban %in% c(1:3),]
df$urban <- droplevels(df$urban)
levels(df$urban) <- c("Rural", 
                      "Suburban",
                      "Urban")
table(df$urban)
# "engnat"  
# 1=Yes, 2=No
df$engnat <- as.factor(df$engnat)
table(df$engnat)
df <- df[df$engnat %in% c(1,2),]
df$engnat <- droplevels(df$engnat)
levels(df$engnat) <- c("Yes", 
                       "No")
table(df$engnat)
# "hand"   
# 1=Right, 2=Left, 3=Both
df$hand <- as.factor(df$hand)
df <- df[df$hand %in% c(1:3),]
df$hand <- droplevels(df$hand)
levels(df$hand) <- c("Right", 
                     "Left",
                     "Both")
table(df$hand)
# "orientation" 
# 1=Heterosexual, 2=Bisexual, 3=Homosexual, 4=Asexual, 5=Other
df$orientation <- as.factor(df$orientation)
df <- df[df$orientation %in% c(1:5),]
df$orientation <- droplevels(df$orientation)
levels(df$orientation) <- c("Heterosexual", 
                            "Bisexual", 
                            "Homosexual", 
                            "Asexual", 
                            "Other")
table(df$orientation)
# "race"     
# 10=Asian, 20=Arab, 30=Black, 40=Indigenous Australian, 
# 50=Native American, 60=White, 70=Other
df$race <- as.factor(df$race)
df <- df[df$race %in% c(10,20,30,#40,
                        50,60,70),]
df$race <- droplevels(df$race)
levels(df$race) <- c("Asian",
                      "Arab",
                      "Black", 
                     #"Indigenous Australian", 
                      "Native American", 
                      "White",
                      "Other"
                      )
table(df$race)
# "voted"     
# 1=Yes, 2=No
df$voted <- as.factor(df$voted) 
df <- df[df$voted %in% c(1,2),]
df$voted <- droplevels(df$voted)
levels(df$voted) <- c("Yes", 
                       "No")
table(df$voted)
# "familysize" 
table(df$familysize)
df <- df[df$familysize < 20,]
df <- df[df$familysize > 0,]
table(df$familysize)
hist(df$familysize)

# str(df)
# summary(df)
puvodni <- data
data <- df
###############################################################################
# Synthesize the dataset ------------------------------------------------------

# Load necessary libraries
library(partykit)
library(dplyr)

# Assuming df is your original dataframe
# Convert character columns to factors
df <- df %>%
  mutate(across(where(is.character), as.factor))

# Create an empty dataframe to store synthetic data with the same structure as the original dataframe
synthetic_data <- df[1:nrow(df), ]

# Initialize synthetic_data with random values from the original data to preserve factor levels
for (col_name in colnames(df)) {
  synthetic_data[[col_name]] <- sample(df[[col_name]], nrow(df), replace = TRUE)
}

# Function to generate synthetic data for a single column
generate_synthetic_column <- function(synthetic_data, col_name, model) {
  predictions <- predict(model, newdata = synthetic_data)
  synthetic_data[, col_name] <- predictions
  return(synthetic_data)
}

# Generate synthetic data for each column sequentially
for (col_name in colnames(df)) {
  # Check if the column has only one unique level
  if (length(unique(df[[col_name]])) == 1) {
    synthetic_data[[col_name]] <- df[[col_name]]
    next
  }
  
  # Determine if the column is numeric or factor
  is_numeric <- is.numeric(df[[col_name]])
  
  # Create a formula for the CART model using the remaining columns as predictors
  predictors <- setdiff(colnames(df), col_name)
  formula <- as.formula(paste(col_name, "~", paste(predictors, collapse = "+")))
  
  # Fit the conditional inference tree model
  model <- ctree(formula, data = df)
  
  # Generate synthetic data for the column
  synthetic_data <- generate_synthetic_column(synthetic_data, col_name, model)
}

# Convert factor levels in the synthetic dataset to match the original dataset
for (col_name in colnames(df)) {
  if (is.factor(df[[col_name]])) {
    synthetic_data[[col_name]] <- factor(synthetic_data[[col_name]], levels = levels(df[[col_name]]))
  }
}

# Display the structure and summary of the synthetic dataset
str(synthetic_data)
summary(synthetic_data)
