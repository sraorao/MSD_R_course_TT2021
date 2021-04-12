###R for biologists
##Irina & Rao, 27/01/2021

##Breakout tasks - MSD COVID dataset
#1) Import the corresponding sheet from Excel file provided (use readxl)
#Group 1 - IFNy; Group 2 - IL-1; Group 3 - IL-2; Group 4 - IL-10

#2) Add a new column "Subtraction" (col4) by subtracting the background unstimulated value (col3) from the stimulated one (col2)

#3) Group the "Subtraction" values by the randomisation group (col3) and find mean, median, standard deviation

#4) Find the maximum and minimum values of col4 in each group (group by col3)

#5) Remove the rows, which have negative values in col4

#6) Save the table as csv comma-separated file containing columns 1, 3 and 4 only (without negative values - see #5)

