###############################################################################
###############################################################################
###############################################################################

# Traditional SDC

##############################################################################

# Packages --------------------------------------------------------------------

library(sdcMicro)


# Dataset ---------------------------------------------------------------------

file <- "data_v2.rds"
df <- readRDS(
   paste0(c(unlist(strsplit(getwd(), "/"))[1:(length(unlist(strsplit(getwd(), "/")))
                                              -1)], # removing 1 levels in files hierarchy
            "0_Data",
            file
   ),collapse = '/')
)

###############################################################################

# Select variables for creating sdcMicro object
# All variable names should correspond to the names in the data file
# selected categorical key variables
selectedKeyVars = c("education",
                    "urban", 
                    "gender", 
                    "engnat", 
                    "hand",
                    "religion",
                    "orientation",
                    "race",
                    "voted",
                    "married"
                    )

# selected categorical numerical variables
selectedNumVar = c("age",
                   "familysize"
                   )

# creating the sdcMicro object with the assigned variables
sdcInitial <- createSdcObj(dat = df,
                           keyVars = selectedKeyVars,
                           numVar = selectedNumVar
                           )

# Summary of object
sdcInitial

# Risk ------------------------------------------------------------------------

# Accessing the risk slot
sdcInitial@risk

# GLobal risk
sdcInitial@risk$global

# Individual risk
sdcInitial@risk$individual







###############################################################################
###############################################################################
###############################################################################