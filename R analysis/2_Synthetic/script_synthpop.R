###############################################################################
###############################################################################
###############################################################################

# Synthetic Data Generation in R
# using synthpop

##############################################################################

# Packages --------------------------------------------------------------------

library(synthpop)
library(ggplot2)

# Dataset ---------------------------------------------------------------------

file <- "data_v2.csv"
data <- read.csv(
  paste0(
    c(unlist(strsplit(getwd(), "/"))[1:(length(unlist(strsplit(getwd(), "/")))
                                        -1)], # removing n levels in files hierarchy
      "0_Data",
      file
      ),collapse = '/'
  )
)

###############################################################################

# Data Preparation ------------------------------------------------------------

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
   ,"Q1A" 
   ,"Q2A" 
   ,"Q3A" 
   ,"Q4A" 
   ,"Q5A" 
   ,"Q6A" 
   ,"Q7A" 
   ,"Q8A" 
   ,"Q9A" 
   ,"Q10A" 
   ,"Q11A" 
   ,"Q12A" 
   ,"Q13A" 
   ,"Q14A" 
   ,"Q15A" 
   ,"Q16A" 
   ,"Q17A" 
   ,"Q18A" 
   ,"Q19A" 
   ,"Q20A" 
)

df <- data[,var_all]

df$Q1A <- as.factor(df$Q1A)
df$Q2A <- as.factor(df$Q2A)
df$Q3A <- as.factor(df$Q3A)
df$Q4A <- as.factor(df$Q4A)
df$Q5A <- as.factor(df$Q5A)
df$Q6A <- as.factor(df$Q6A)
df$Q7A <- as.factor(df$Q7A)
df$Q8A <- as.factor(df$Q8A)
df$Q9A <- as.factor(df$Q9A)
df$Q10A <- as.factor(df$Q10A)
df$Q11A <- as.factor(df$Q11A)
df$Q12A <- as.factor(df$Q12A)
df$Q13A <- as.factor(df$Q13A)
df$Q14A <- as.factor(df$Q14A)
df$Q15A <- as.factor(df$Q15A)
df$Q16A <- as.factor(df$Q16A)
df$Q17A <- as.factor(df$Q17A)
df$Q18A <- as.factor(df$Q18A)
df$Q19A <- as.factor(df$Q19A)
df$Q20A <- as.factor(df$Q20A)

###############################################################################

# Synthesize the dataset ------------------------------------------------------

# Examine the features that will be relevant to synthesising.
codebook.syn(df)

# Synthesizing the dataset
synthetic <- syn(df
                 ,method = "cart"
                 ,seed = 123
)
synthetic

# View the synthetic dataset
summary(synthetic)

options("scipen"=999) # Disable scientific notation
compare(synthetic, df,
        nrow = 6, 
        ncol = 2)

# Extract the synthetic dataset
sy <- synthetic$syn



# Compute utility
utility <- utility.gen(synthetic, df)

# Extract overall pMSE
overall_pMSE <- utility$pMSE