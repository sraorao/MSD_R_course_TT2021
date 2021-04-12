###R for biologists
##Irina & Rao, 02/02/2021-03/02/2021
library(tidyverse)
#Import the all sheets from Excel file provided (use readxl)
library(readxl)
ifny <- read_excel("Session4/data/MSD_data.xlsx", sheet = 'IFNy')
il1 <- read_excel("Session4/data/MSD_data.xlsx", sheet = 'IL-1')
il2 <- read_excel("Session4/data/MSD_data.xlsx", sheet = 'IL-2')
il10 <- read_excel("Session4/data/MSD_data.xlsx", sheet = 'IL-10')
library(dplyr)
ifny %>% mutate(Subtraction=Calc.Conc.Mean_S1S2-Calc.Conc.Mean_Unst) -> ifny
il1 %>% mutate(Subtraction=Calc.Conc.Mean_S1S2-Calc.Conc.Mean_Unst) -> il1
il2 %>% mutate(Subtraction=Calc.Conc.Mean_S1S2-Calc.Conc.Mean_Unst) -> il2
il10 %>% mutate(Subtraction=Calc.Conc.Mean_S1S2-Calc.Conc.Mean_Unst) -> il10

ifny<-ifny[,c(1,5,6)]
il1<-il1[,c(1,5,6)]
il2<-il2[,c(1,5,6)]
il10<-il10[,c(1,5,6)]

cyto <- Reduce(function(...) merge(..., all = TRUE, by = c("Participant_ID","Randomised_to")),
       list(ifny, il1, il2, il10))
colnames(cyto)<-c("ID","Randomisation","IFNy","IL1","IL2","IL10")
#Remove negative values
cyto %>% filter(across(c(IFNy, IL1, IL2, IL10),~ .x>0|is.na(.x)==TRUE)) -> cyto
cyto %>% filter(across(c(-ID,-Randomisation),~ .x>0|is.na(.x)==TRUE)) -> cyto

#Convert groups into factors
cyto$Randomisation <- as.factor(cyto$Randomisation)
levels(cyto$Randomisation)
c(1,2)
levels(cyto$Randomisation)<-c("ChAdOx1", "Control")
#install.packages("data.table")
library(data.table)
#Wide to long format

#cyto_melted<-melt(cyto,id.vars=c("ID","Randomisation"))
#reshape(cyto,idvar = c("ID","Randomisation"),direction = "long")

#Stick with gather from tidyr
cyto_melted<-gather(cyto,key="variable",value = "value",-ID,-Randomisation)
cyto_melted<-na.omit(cyto_melted)
#cyto2<-na.omit(cyto)
#library(reshape2)

library(ggplot2)
#Barplot
ggplot(cyto_melted, aes(fill=Randomisation, y=value, x=variable)) + 
  geom_bar(position="dodge", stat="identity") +
  theme_bw()

#Compare to this - we plot the means
ggplot(cyto_melted, aes(fill=Randomisation, y=value, x=variable)) + 
  geom_bar(position="dodge", stat = "summary", fun = "median") +
  theme_bw()

#Stacked barplot
ggplot(cyto_melted, aes(fill=Randomisation, y=value, x=variable)) + 
  geom_bar(position="stack", stat = "summary",) +
  theme_bw()

#Percent stacked barplot
ggplot(cyto_melted, aes(fill=Randomisation, y=value, x=variable)) + 
  geom_bar(position="fill", stat="summary", fun = "mean") +
  theme_bw()

#Reverse the groupping - check the relative aboundance of each cytokine by randomisation group
ggplot(cyto_melted, aes(fill=variable, y=value, x=Randomisation)) + 
  geom_bar(position="fill", stat="identity", width = 0.5) +
  theme_bw()

#Add error bars
ggplot(cyto_melted, aes(fill=Randomisation, y=value, x=variable)) + 
  geom_bar(position="dodge", stat = "summary", fun = "mean") + 
  stat_summary(geom = "errorbar", fun.data = mean_se, 
               position = position_dodge(width = 0.90), width = 0.3) +
  theme_bw()

#Bar plots is not a good way to represent our data!

#Boxplot
ggplot(cyto_melted, aes(fill=Randomisation, y=value, x=variable)) + 
  geom_boxplot() +
  theme_bw()

#Scale - log transform
ggplot(cyto_melted, aes(fill=Randomisation, y=log(value), x=variable)) + 
  geom_boxplot()

#Facets
ggplot(cyto_melted, aes(fill=Randomisation, y=log(value), x=variable)) + 
  geom_boxplot() +
  theme_bw() +
  facet_wrap(~Randomisation)

#Remove legend
ggplot(cyto_melted, aes(fill=Randomisation, y=log(value), x=variable)) + 
  geom_boxplot() +
  theme_bw() +
  theme(legend.position = "none")+
  facet_wrap(~Randomisation)

##########################
#####End of session 4#####
#Dotplot + means
ggplot(cyto_melted, aes(fill=Randomisation, y=log(value), x=variable))+
  geom_dotplot(binaxis = "y", stackdir = "center",
               position = position_dodge(0.8), dotsize = 0.8) + 
  stat_summary(
    fun.data = "mean_sdl", fun.args = list(mult=1), 
    geom = "pointrange", color = "black",position = position_dodge(0.8)
  )

#Changing binwidth
ggplot(cyto_melted, aes(fill=Randomisation, y=log(value), x=variable))+
  geom_dotplot(binaxis = "y", stackdir = "center",
               position = position_dodge(0.8), dotsize = 0.8, binwidth = 0.2) + 
  stat_summary(
    fun.data = "mean_sdl", fun.args = list(mult=1), 
    geom = "pointrange", color = "black",position = position_dodge(0.8))

#Dot+boxplots
ggplot(cyto_melted, aes(fill=Randomisation, y=log(value), x=variable))+
  geom_dotplot(binaxis = "y", stackdir = "center",
               position = position_dodge(0.8),dotsize = 0.8, binwidth = 0.2) + 
geom_boxplot(width = 0.8, outlier.shape = NA)

#Jitter plots
ggplot(cyto_melted, aes(fill=Randomisation, y=log(value), x=variable))+
geom_jitter(aes(shape=Randomisation, color=Randomisation),
  position = position_jitter(0.2),
  size = 1.2)

#Change positions 
ggplot(cyto_melted, aes(fill=Randomisation, y=log(value), x=variable))+
  geom_jitter(aes(shape=Randomisation, color=Randomisation),
              position = position_jitterdodge(jitter.width = 0.2, dodge.width = 0.8),
              size = 1.2)

#Adding stat
ggplot(cyto_melted, aes(fill=Randomisation, y=log(value), x=variable)) +
  geom_jitter(aes(shape=Randomisation, color=Randomisation),
              position = position_jitterdodge(jitter.width = 0.2, dodge.width = 0.8),
              size = 1.2) + 
  theme_bw() +
  stat_summary(
  aes(color = Randomisation),
  fun.data="mean_sdl",  fun.args = list(mult=1), 
  geom = "pointrange",  size = 0.4,
  position = position_dodge(0.8))

###################
#####Session 5#####
#Performing statistics and adding significance levels
library(ggpubr)
#Summary
compare_means(data = cyto_melted, formula = value ~ Randomisation, group.by = "variable")
#Adding to the ggplot
#Boxplot
ggplot(cyto_melted, aes(fill=Randomisation, y=log(value), x=variable)) + 
  geom_boxplot() +
  theme_bw() +
  stat_compare_means(aes(group = Randomisation), method = "wilcox", hide.ns = F, paired = F,
                     label = "p.signif",bracket.size = 0.3)
#alternatively - label = "p.format"

#Barplot
ggplot(cyto_melted, aes(fill=Randomisation, y=value, x=variable)) + 
  geom_bar(position="dodge", stat = "summary", fun = "mean") + 
  stat_summary(geom = "errorbar", fun.data = mean_se, 
               position = position_dodge(width = 0.90), width = 0.3) +
  stat_compare_means(aes(group = Randomisation), label = "p.signif", label.y = 75)+
  theme_bw()


