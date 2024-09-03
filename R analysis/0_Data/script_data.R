###############################################################################
###############################################################################
###############################################################################

# Synthetic Data Generation in R

##############################################################################

# Dataset ---------------------------------------------------------------------

file <- "data.csv"
data <- read.csv(file,
                 sep = "\t"
)

# Variables -------------------------------------------------------------------

user_answer <- c(
  "Q1A", # "Never tell anyone the real reason you did something unless it is useful to do so.",
  "Q2A", # "The best way to handle people is to tell them what they want to hear.",
  "Q3A", # "One should take action only when sure it is morally right.",
  "Q4A", # "Most people are basically good and kind.",
  "Q5A", # "It is safest to assume that all people have a vicious streak and it will come out when they are given a chance.",
  "Q6A", # "Honesty is the best policy in all cases.",
  "Q7A", # "There is no excuse for lying to someone else.",
  "Q8A", # "Generally speaking, people won't work hard unless they're forced to do so.",
  "Q9A", # "All in all, it is better to be humble and honest than to be important and dishonest.",
  "Q10A", # "When you ask someone to do something for you, it is best to give the real reasons for wanting it rather than giving reasons which carry more weight.",
  "Q11A", # "Most people who get ahead in the world lead clean, moral lives.",
  "Q12A", # "Anyone who completely trusts anyone else is asking for trouble.",
  "Q13A", # "The biggest difference between most criminals and other people is that the criminals are stupid enough to get caught.",
  "Q14A", # "Most people are brave.",
  "Q15A", # "It is wise to flatter important people.",
  "Q16A", # "It is possible to be good in all respects.",
  "Q17A", # "P.T. Barnum was wrong when he said that there's a sucker born every minute.",
  "Q18A", # "It is hard to get ahead without cutting corners here and there.",
  "Q19A", # "People suffering from incurable diseases should have the choice of being put painlessly to death.",
  "Q20A"  # "Most people forget more easily the death of their parents than the loss of their property."
)

item_position <- c(
  "Q1I", # "Never tell anyone the real reason you did something unless it is useful to do so.",
  "Q2I", # "The best way to handle people is to tell them what they want to hear.",
  "Q3I", # "One should take action only when sure it is morally right.",
  "Q4I", # "Most people are basically good and kind.",
  "Q5I", # "It is safest to assume that all people have a vicious streak and it will come out when they are given a chance.",
  "Q6I", # "Honesty is the best policy in all cases.",
  "Q7I", # "There is no excuse for lying to someone else.",
  "Q8I", # "Generally speaking, people won't work hard unless they're forced to do so.",
  "Q9I", # "All in all, it is better to be humble and honest than to be important and dishonest.",
  "Q10I", # "When you ask someone to do something for you, it is best to give the real reasons for wanting it rather than giving reasons which carry more weight.",
  "Q11I", # "Most people who get ahead in the world lead clean, moral lives.",
  "Q12I", # "Anyone who completely trusts anyone else is asking for trouble.",
  "Q13I", # "The biggest difference between most criminals and other people is that the criminals are stupid enough to get caught.",
  "Q14I", # "Most people are brave.",
  "Q15I", # "It is wise to flatter important people.",
  "Q16I", # "It is possible to be good in all respects.",
  "Q17I", # "P.T. Barnum was wrong when he said that there's a sucker born every minute.",
  "Q18I", # "It is hard to get ahead without cutting corners here and there.",
  "Q19I", # "People suffering from incurable diseases should have the choice of being put painlessly to death.",
  "Q20I"  # "Most people forget more easily the death of their parents than the loss of their property."
)

time_question <- c(
  "Q1E", # "Never tell anyone the real reason you did something unless it is useful to do so.",
  "Q2E", # "The best way to handle people is to tell them what they want to hear.",
  "Q3E", # "One should take action only when sure it is morally right.",
  "Q4E", # "Most people are basically good and kind.",
  "Q5E", # "It is safest to assume that all people have a vicious streak and it will come out when they are given a chance.",
  "Q6E", # "Honesty is the best policy in all cases.",
  "Q7E", # "There is no excuse for lying to someone else.",
  "Q8E", # "Generally speaking, people won't work hard unless they're forced to do so.",
  "Q9E", # "All in all, it is better to be humble and honest than to be important and dishonest.",
  "Q10E", # "When you ask someone to do something for you, it is best to give the real reasons for wanting it rather than giving reasons which carry more weight.",
  "Q11E", # "Most people who get ahead in the world lead clean, moral lives.",
  "Q12E", # "Anyone who completely trusts anyone else is asking for trouble.",
  "Q13E", # "The biggest difference between most criminals and other people is that the criminals are stupid enough to get caught.",
  "Q14E", # "Most people are brave.",
  "Q15E", # "It is wise to flatter important people.",
  "Q16E", # "It is possible to be good in all respects.",
  "Q17E", # "P.T. Barnum was wrong when he said that there's a sucker born every minute.",
  "Q18E", # "It is hard to get ahead without cutting corners here and there.",
  "Q19E", # "People suffering from incurable diseases should have the choice of being put painlessly to death.",
  "Q20E"  # "Most people forget more easily the death of their parents than the loss of their property."
)

Ten_Item_Personality <- c(
  "TIPI1", #	Extraverted, enthusiastic.
  "TIPI2", #	Critical, quarrelsome.
  "TIPI3", #	Dependable, self-disciplined.
  "TIPI4", #	Anxious, easily upset.
  "TIPI5", #	Open to new experiences, complex.
  "TIPI6", #	Reserved, quiet.
  "TIPI7", #	Sympathetic, warm.
  "TIPI8", #	Disorganized, careless.
  "TIPI9", #	Calm, emotionally stable.
  "TIPI10" #	Conventional, uncreative.
)

check_list <- c(
  "VCL1", #	boat
  "VCL2", #	incoherent
  "VCL3", #	pallid
  "VCL4", #	robot
  "VCL5", #	audible
  "VCL6", #	cuivocal
  "VCL7", #	paucity
  "VCL8", #	epistemology
  "VCL9", #	florted
  "VCL10", #	decide
  "VCL11", #	pastiche
  "VCL12", #	verdid
  "VCL13", #	abysmal
  "VCL14", #	lucid
  "VCL15", #	betray
  "VCL16"  #	funny
  
)

demographics <- c(
  "education", # "How much education have you completed?", 
  #1=Less than high school, 2=High school, 3=University degree, 4=Graduate degree
  "urban", #				"What type of area did you live when you were a child?", 
  #1=Rural (country side), 2=Suburban, 3=Urban (town, city)
  "gender", #				"What is your gender?", 
  #1=Male, 2=Female, 3=Other
  "engnat", #				"Is English your native language?", 
  #1=Yes, 2=No
  "age", #					"How many years old are you?"
  "hand", #				"What hand do you use to write with?", 
  #1=Right, 2=Left, 3=Both
  "religion", #			"What is your religion?", 
  #1=Agnostic, 2=Atheist, 3=Buddhist, 4=Christian (Catholic), 5=Christian (Mormon), 6=Christian (Protestant), 7=Christian (Other), 8=Hindu, 9=Jewish, 10=Muslim, 11=Sikh, 12=Other
  "orientation", #			"What is your sexual orientation?", 
  #1=Heterosexual, 2=Bisexual, 3=Homosexual, 4=Asexual, 5=Other
  "race", #				"What is your race?", 
  #10=Asian, 20=Arab, 30=Black, 40=Indigenous Australian, 50=Native American, 60=White, 70=Other
  "voted", #				"Have you voted in a national election in the past year?", 
  #1=Yes, 2=No
  "married", #				"What is your marital status?", 
  #1=Never married, 2=Currently married, 3=Previously married
  "familysize", #			"Including you, how many children did your mother have?"		
  "major" #				"If you attended a university, what was your major (e.g. "psychology", "English", "civil engineering")?"
)

server <- c(
  "country", # the user's network location
  "screenw", # width of user's device in pixels
  "screenh"	 # width of user's device in pixels
)

time_page <- c(
  "introelapse",
  "testelapse",
  "surveyelapse"
) 

# Control
# df <- data[, !(names(data) %in% c( 
#                                  user_answer
#                                 ,item_position
#                                 ,time_question
#                                 ,Ten_Item_Personality
#                                 ,check_list
#                                 ,demographics
#                                 ,server
#                                 ,time_page
#                                 )
#                )
#            ]

# Subset ----------------------------------------------------------------------

df <- data[, c(  user_answer
                ,Ten_Item_Personality
                ,demographics
                )
           ]

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

# Save ------------------------------------------------------------------------

write.csv(df, 
          file = "data_v2.csv"
)

###############################################################################
###############################################################################
###############################################################################