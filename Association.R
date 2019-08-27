# install.packages("arules")
# install.packages("plyr", dependencies = TRUE)
# install.packages("arulesViz")
# install.packages("RColorBrewer")
library(arules)
library(plyr)
library(arulesViz)
library(RColorBrewer)

# read csv into R dataframe
retail <- read.csv("C:/Users/Rishi/OneDrive/Curriculum/2nd Semester/Data Mining/Assignment 3/DistinctOnlineRetail.csv")

# view retail dataset
retail

# summary of retail dataset
summary(retail)

# transpose the description column according to Invoice No
transactionData <- ddply(retail,c("InvoiceNo"),function(df1)paste(df1$Description,collapse = ","))

# InvoiceNo will not be of any use in the rule mining,so we can set to NULL.
transactionData$InvoiceNo <- NULL

#Rename column to items
colnames(transactionData) <- c("items")

transactionData

# store this transaction data into a .csv
write.csv(transactionData,"C:/Users/Rishi/OneDrive/Curriculum/2nd Semester/Data Mining/Assignment 3/market_basket_transactions.csv", quote = FALSE, row.names = FALSE)

# read the csv file 
tr <- read.transactions('C:/Users/Rishi/OneDrive/Curriculum/2nd Semester/Data Mining/Assignment 3/market_basket_transactions.csv', format = 'basket', sep=',')
tr
summary(tr)

# itemFrequencyplots
itemFrequencyPlot(tr,topN=10,type="absolute",col=brewer.pal(8,'Pastel2'), main="Absolute Item Frequency Plot")

itemFrequencyPlot(tr,topN=10,type="relative",col=brewer.pal(8,'Pastel2'),main="Relative Item Frequency Plot")

# rules generation
association.rules <- apriori(tr, parameter = list(supp=0.02, conf=0.5))
summary(association.rules)
inspect(association.rules)

inspect(sort(association.rules,by='lift'))
itemsets=unique(generatingItemsets(association.rules))
itemsets
inspect(itemsets)

#maximal frequent itemset generation
maximal.sets=apriori(tr,parameter = list(supp=0.02,conf=0.5,target='maximally frequent itemsets'))
inspect(sort(maximal.sets, by='count')[1:10])

# subset.rules <- which(colSums(is.subset(association.rules, association.rules)) > 1) # get subset rules in vector
# length(subset.rules)

# subset.association.rules. <- association.rules[-subset.rules] # remove subset rules.
# subset.association.rules.
# inspect(subset.association.rules.)

# metal.association.rules <- apriori(tr, parameter = list(supp=0.002, conf=0.8),appearance = list(default="lhs",rhs="REGENCY CAKESTAND 3 TIER"))

# visualization tools
subRules<-association.rules[quality(association.rules)$confidence>0.5]
plot(subRules)
plotly_arules(subRules)

top10subRules <- head(subRules, n = 10, by = "support")
plot(top10subRules, method = "graph",  engine = "htmlwidget")

subRules2<-head(subRules, n=10, by="lift")
plot(subRules2, method="paracoord")
