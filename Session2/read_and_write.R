###R for biologists
##Irina & Rao, 20/01/2021

###Working directory###
getwd()
list.files()
setwd()
#Q: change wd to "data" subfolder

###Reading and writing data files###
##read txt and csv files
##Dataset:
#The Strength of Phenotypic Selection in Natural Populations, Kingsolver et al. (2001)
populations<-read.delim("data/selection.txt")
View(populations)
dim(populations)
str(populations)
#read excel
install.packages("readxl")
library(readxl)
populations2<-read_excel("data/selection.xls")
str(populations2)
#Notice the difference! -> use strings as factors = F

#read data from internet
my_data <- read.delim("http://www.sthda.com/upload/boxplot_format.txt")

#Q: try to read any of your own csv files with read.csv

#write files
populations_short<-populations[,c(1,3:4)]
write.table(populations_short,"populations_short.txt",quote = F, sep="\t", row.names = F)
write.csv(populations_short,"populations_short.csv",quote = F,row.names = F)

install.packages("xlsx")
library(xlsx)

#Q: write populations as excel file, keep only the first 100 rows

