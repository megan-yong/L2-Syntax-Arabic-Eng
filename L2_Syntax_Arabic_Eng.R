setwd('C:/Users/Owner/OneDrive/Desktop/')

library(tidyverse)
library(reshape2)
library(vcd)

data <- read.csv('L2_Syntax_Arabic_Eng(1).csv')

#### (1) Data tidying ####

summary(data)

# (a) Convert to long format

data_long <- melt(data, id=c("ID", "Age", "Prof", "Level", "Place"))

# (b) Convert all char variables to factor

data_long[sapply(data_long, is.character)] <- 
  lapply(data_long[sapply(data_long, is.character)], as.factor)

# (c) Remove NAs

data_long <- filter(data_long, !is.na(value))

# (d) Rename columns

colnames(data_long)[colnames(data_long) == 'variable'] <- 'Item'
colnames(data_long)[colnames(data_long) == 'value'] <- 'Rating'

# (e) Remove filler questions

data_filter <- data_long[!grepl("F", data_long$Item), ]

# (f) Drop levels from columns

data_filter <- droplevels(data_filter)

# (g) Sort Item column into sentence types

data_filter <- data_filter %>% mutate(Type = case_when(
  grepl("A", Item) ~ "A",
  grepl("B", Item) ~ "B",
  grepl("C", Item) ~ "C",
  grepl("D", Item) ~ "D",
))

# (h) Subset normal and z-score ratings

data_sub_norm <- subset(data_filter, !grepl("Z", Item))

data_sub_z <- subset(data_filter, grepl("Z", Item))

# (i) Reverse z-scores

data_sub_z$Rating <- data_sub_z$Rating * -1

# (j) Add response column to normal data

data_sub_norm$Response[data_sub_norm$Rating >= 5] <- "Accept"
data_sub_norm$Response[data_sub_norm$Rating <= 4] <- "Reject"

# (k) Convert char variables to factors

data_sub_norm[sapply(data_sub_norm, is.character)] <- 
  lapply(data_sub_norm[sapply(data_sub_norm, is.character)], as.factor)

data_sub_z[sapply(data_sub_z, is.character)] <- 
  lapply(data_sub_z[sapply(data_sub_z, is.character)], as.factor)


#### (2) Inferential statistics ####

# (a) Chi square test for Type A Response against Level

data_A <- filter(data_sub_norm, data_sub_norm$Type == "A")
data_A <- droplevels(data_A)
data_A <- table(data_A[ ,c("Response", "Level")])

accept_A <- c(158,90)
reject_A <- c(76,78)

totals_A <- rbind(accept_A, reject_A)

chisq.test(totals_A)

## Pearson's Chi-squared test with Yates' continuity correction
## data:  totals_A
## X-squared = 7.4729, df = 1, p-value = 0.006263
##

# (b) Chi square test for Type B Response against Level

data_B <- filter(data_sub_norm, data_sub_norm$Type == "B")
data_B <- droplevels(data_B)
data_B <- table(data_B[ ,c("Response", "Level")])

accept_B <- c(114,75)
reject_B <- c(120,93)

totals_B <- rbind(accept_B, reject_B)

chisq.test(totals_B)

## Pearson's Chi-squared test with Yates' continuity correction
## data:  totals_B
## X-squared = 0.49858, df = 1, p-value = 0.4801
##

# (c) Chi square test for Type C Response against Level

data_C <- filter(data_sub_norm, data_sub_norm$Type == "C")
data_C <- droplevels(data_C)
data_C <- table(data_C[ ,c("Response", "Level")])

accept_C <- c(112,30)
reject_C <- c(122,138)

totals_C <- rbind(accept_C, reject_C)

chisq.test(totals_C)

## Pearson's Chi-squared test with Yates' continuity correction
## data:  totals_C
## X-squared = 37.238, df = 1, p-value = 1.046e-09
##

# (d) Chi square test for Type D Response against Level

data_D <- filter(data_sub_norm, data_sub_norm$Type == "D")
data_D <- droplevels(data_D)
data_D <- table(data_D[ ,c("Response", "Level")])

accept_D <- c(163,99)
reject_D <- c(71,69)

totals_D <- rbind(accept_D, reject_D)

chisq.test(totals_D)

## Pearson's Chi-squared test with Yates' continuity correction
## data:  totals_D
## X-squared = 4.4986, df = 1, p-value = 0.03392
##


#### (3) Visualisations ####

# (a) Compare responses of type B

totals_B <- as.data.frame.table(totals_B)

totals_B <- totals_B %>%
  group_by(Var2) %>%
  mutate(Perc = Freq / sum(Freq) * 100)
  
ggplot(totals_B, aes(x=Var2, y=Perc, fill=Var1)) +
  geom_bar(stat="identity", position="dodge") +
  labs (x = "English Level", 
        y = "Percentage",
        fill = "Response") +
  scale_fill_discrete(labels=c("Accept", "Reject")) +
  scale_x_discrete(labels = c("A" = "Adv", "B" = "Int"))

# (b) Compare responses of type C

totals_C <- as.data.frame.table(totals_C)

totals_C <- totals_C %>%
  group_by(Var2) %>%
  mutate(Perc = Freq / sum(Freq) * 100)

ggplot(totals_C, aes(x=Var2, y=Perc, fill=Var1)) +
  geom_bar(stat="identity", position="dodge") +
  labs (x = "English Level", 
        y = "Percentage", 
        fill = "Response") +
  scale_fill_discrete(labels=c("Accept", "Reject")) +
  scale_x_discrete(labels = c("A" = "Adv", "B" = "Int"))

# (c) Compare responses of each type

data_all <- table(data_sub_norm[ ,c("Response", "Type")])

accept_all <- c(248,189,142,262)
reject_all <- c(154,213,260,140)

totals_all <- rbind(accept_all, reject_all)
totals_all <- as.data.frame.table(totals_all)

totals_all <- totals_all %>%
  group_by(Var2) %>%
  mutate(Perc = Freq / sum(Freq) * 100)

ggplot(totals_all, aes(x=Var2, y=Perc, fill=Var1)) +
  geom_bar(stat="identity", position="dodge") +
  labs (x = "Type", 
        y = "Percentage", 
        fill = "Response") +
  scale_fill_discrete(labels=c("Accept", "Reject"))
