#author: kamal chhetri

############### Task ################

# We have to discover most important association rules (AR) which refers to mushrooms,
#to my mind  the most important factor in mushrooms that we use it in food, 
#so our goal is to discover AR to  our analize our samples like edible. 
#To reach the best result we have to try different combination in a priori parameter,
#which influenced on a priori algorithm for finding AR.

# First of all, we have to analize our data and prepare
# it in appropriate form. Our task for this exercise is to find 
# some interesting # association rules. Next step of task to decrease 
# quantity of these rules and find at least 20. We can reach this,
# by changing parameters,like "support" or "confidence" and quantity 
# of elements from left and right side ("minlen");

# Set working directory
setwd("~/R");

# Library loading
library(arules) # association rules
library(arulesViz) # visualization of reles

# Set dataset for a task
mushSet = read.table("mush.data", header = F, sep=",", na.strings= "*")

# Changing attributes names
colnames(mushSet) <- c("edible", "cap-shape", "cap-surface","cap-color","bruises","odor","gill-attachment",
                       "gill-spacing","gill-size","gill-color","stalk-shape","stalk-root",
                       "stalk-surface-above-ring","stalk-surface-below-ring","stalk-color-above-ring",
                       "stalk-color-below-ring","veil-type","veil-color","ring-number",
                       "ring-type","spore-print","population","habitat")

# Let us consider what exactly we should know about mushroom before making any of association rules.
# We need to make a preliminary analize to exclude unnecessary data.
summary(mushSet)

# We noticed that "veil-type" all oservations contain this parameter, so it's could be deleted.
mushSet[["veil-type"]]<-NULL

# Convert from "data.frame" datatype to "transactions" datatype
mushTR <- as(mushSet, "transactions")


# First of all, we interested in finding just edible mushrooms, because we don't use in food poisoned one's
# and we have to be sure about what we are eating, so we select "confidence" to value 100% and "support" to 30% by default,
# next step is to carry on several experiments with "minlen" to distinguish it;s lowest value.

summary(mushSet[["edible"]])

aParam  = new("APparameter", "confidence" = 1, "support" = 0.1, "minlen"= 8)
aRules <-apriori(mushTR,aParam)
rulesConseqEdible<- subset(aRules, subset = rhs %in% "edible=e" & confidence >=1)
inspect(rulesConseqEdible)



aParam  = new("APparameter", "confidence" = 1, "support" = 0.5, "minlen"= 7)

aParam  = new("APparameter", "confidence" = 1, "support" = 0.4, "minlen"= 6)

aParam  = new("APparameter", "confidence" = 1, "support" = 0.2, "minlen"= 5)

# Let's carry out several experiments and find out what characteristics lead to edible 
# pattern and what is the lowest quantity of them could satisfied our results.

aParam  = new("APparameter", "confidence" = 1, "support" = 0.3, "minlen"= 2)
print(aParam)

# The most suitable option in our case is: "confidence" = 1, "support" = 0.3, "minlen"= 2

aRules <-apriori(mushTR,aParam)
summary(aRules)

aRules.sorted<-sort(aRules, by="lift")
inspect(aRules)
rulesConseqEdible<- subset(aRules, subset = rhs %in% "edible=e" & confidence >=1)
inspect(rulesConseqEdible)

# I've changed several times parameters of confidence, support and minlen, in most cases we've got to many association rules.
# I've reached the most appropriate configuration with next parameters: "confidence" = 1, "support" = 0.3, "minlen"= 2, 

# Documentation help
?print
?APparameter
?summary
?inspect
?sort
?subset

##################################### Conclusion ########################################
# To sum, we see that to obtain adequate results we have to try different combinations of 
# parameters. In our case changing of "support" in positive side to (0.5) gives us NULL 
# of AR, if the value of "support" is too low, number of AR is quite huge, the same result 
# with "minlen" parameter, and so huge quantity of gives us no benefits in discovering 
# useful data. Adequate parameters in our case is: "confidence" = 1, "support" = 0.3,
# "minlen"= 2. According to these parameters.I've received 20 AR, which mentioned below. 
# We see that number of items per item set is different, so some of these rules could be much 
# effective than others, we could reduce some of them, but on practice we could have different
# situations, so to my mind these is appropriate number of rules.

########################### Association rules result ####################################

lhs                    rhs          support confidence     lift
1  {odor=n,                                                       
    stalk-shape=t}     => {edible=e} 0.3072378          1 1.930608
2  {odor=n,                                                       
    gill-size=b,                                                  
    stalk-shape=t}     => {edible=e} 0.3072378          1 1.930608
3  {odor=n,                                                       
    stalk-shape=t,                                                
    ring-number=o}     => {edible=e} 0.3072378          1 1.930608
4  {odor=n,                                                       
    gill-attachment=f,                                            
    stalk-shape=t}     => {edible=e} 0.3072378          1 1.930608
5  {odor=n,                                                       
    stalk-shape=t,                                                
    veil-color=w}      => {edible=e} 0.3072378          1 1.930608
6  {odor=n,                                                       
    gill-size=b,                                                  
    ring-number=o}     => {edible=e} 0.3308715          1 1.930608
7  {odor=n,                                                       
    gill-size=b,                                                  
    stalk-shape=t,                                                
    ring-number=o}     => {edible=e} 0.3072378          1 1.930608
8  {odor=n,                                                       
    gill-attachment=f,                                            
    gill-size=b,                                                  
    stalk-shape=t}     => {edible=e} 0.3072378          1 1.930608
9  {odor=n,                                                       
    gill-size=b,                                                  
    stalk-shape=t,                                                
    veil-color=w}      => {edible=e} 0.3072378          1 1.930608
10 {odor=n,                                                       
    gill-attachment=f,                                            
    stalk-shape=t,                                                
    ring-number=o}     => {edible=e} 0.3072378          1 1.930608
11 {odor=n,                                                       
    stalk-shape=t,                                                
    veil-color=w,                                                 
    ring-number=o}     => {edible=e} 0.3072378          1 1.930608
12 {odor=n,                                                       
    gill-attachment=f,                                            
    stalk-shape=t,                                                
    veil-color=w}      => {edible=e} 0.3072378          1 1.930608
13 {odor=n,                                                       
    gill-attachment=f,                                            
    gill-size=b,                                                  
    ring-number=o}     => {edible=e} 0.3072378          1 1.930608
14 {odor=n,                                                       
    gill-size=b,                                                  
    veil-color=w,                                                 
    ring-number=o}     => {edible=e} 0.3072378          1 1.930608
15 {odor=n,                                                       
    gill-attachment=f,                                            
    gill-size=b,                                                  
    stalk-shape=t,                                                
    ring-number=o}     => {edible=e} 0.3072378          1 1.930608
16 {odor=n,                                                       
    gill-size=b,                                                  
    stalk-shape=t,                                                
    veil-color=w,                                                 
    ring-number=o}     => {edible=e} 0.3072378          1 1.930608
17 {odor=n,                                                       
    gill-attachment=f,                                            
    gill-size=b,                                                  
    stalk-shape=t,                                                
    veil-color=w}      => {edible=e} 0.3072378          1 1.930608
18 {odor=n,                                                       
    gill-attachment=f,                                            
    stalk-shape=t,                                                
    veil-color=w,                                                 
    ring-number=o}     => {edible=e} 0.3072378          1 1.930608
19 {odor=n,                                                       
    gill-attachment=f,                                            
    gill-size=b,                                                  
    veil-color=w,                                                 
    ring-number=o}     => {edible=e} 0.3072378          1 1.930608
20 {odor=n,                                                       
    gill-attachment=f,                                            
    gill-size=b,                                                  
    stalk-shape=t,                                                
    veil-color=w,                                                 
  £  ring-number=o}     => {edible=e} 0.3072378          1 1.930608
