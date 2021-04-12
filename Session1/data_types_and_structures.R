###R for biologists
##Irina & Rao, 19/01/2021

#### constants - unchanging elements in R####
2
pi


#### variables -place-holders to which data can be assigned and changed####
x = 2
y = 5
z
my_number
LETTERS

# Let's assign some data to variables
# Note that x is different from "x" or 'x'

x = 2
y <- 3


x
y
z = x

x = 5

# What is the value of z now?
z
# What is the value of x now?
x
# Variable names
gene_name_p53 = "TP53"
gene_id_p53 = 7157
is_oncogene_p53 = FALSE
gene_7157 = "TP53"
# 7157_gene = 4 # this won't work because a variable name can't start with a number

# Q: assign the values 1000 and 50 to the 
# variables num_students and num_teachers, 
# and now calculate the total number of 
# people in the class, assign this to num_people
# # hint use + to add two values
num_students = 1000
num_teachers = 50
num_people = num_students + num_teachers

#### Types of data####
num_participants = 25       # numeric
my_uni = "Oxford"           # character
am_i_happy_today = TRUE     # logical
num_instructors = "2"       # type?



#### Conversion of data types####
num_participants +  num_instructors
as.numeric(num_participants) + as.numeric(num_instructors)

# Q: What happens when you try to convert "two" to numeric type?
as.numeric("two")
# Q: What happens when you try to convert "Truth" to logical type?
as.logical(9)

#### Data Structures####
# Atomic vectors - most basic data type, can be of length => 0
# length 0
num_participants = numeric()
my_uni = character()
am_i_happy_today = logical()

# length 1 - we have done this already!
num_genes = 2

# length > 1 - we need to use the c() function or the : operator for a sequence of numbers
gene_num = 1:4
gene_names = c("TP53", "PTEN", "RB1", "MYC")
gene_ids = c(7157, 5728, 5925, 4609)
genes = c("PTEN", 7153)

# Contents of atomic vectors are of a single type; if not, they are 'coerced'
gene_name_p53 = "TP53"
gene_id_p53 = 7157
is_oncogene_p53 = FALSE
info_p53 = c(gene_name_p53, gene_id_p53, is_oncogene_p53)
info_p53

info_p53 = c(gene_id_p53, is_oncogene_p53)
info_p53

# Subsetting atomic vectors with []
gene_names[3]
gene_names[2:4]
gene_names[c(2,4)]
gene_names_TS = gene_names[c(1, 2, 3)]


# lists
info_p53 = list(gene_name_p53, gene_id_p53, is_oncogene_p53)
info_p53

all_genes = list(num = gene_num, name = gene_names, id = gene_ids)
all_genes

# Subsetting lists is slightly different: [] yields a list, [[]] or $ yields an element of a list
all_genes[1]

all_genes[[1]]
all_genes[["name"]]
all_genes$name
all_genes$num

# data frames 
all_genes_df = data.frame(num = gene_num, name = gene_names, id = gene_ids)
all_genes_df

# subsetting data frames with [row, column]
all_genes_df[1, 2]
all_genes_df[1, ]
all_genes_df_subset = all_genes_df[2:3, 1:3]
all_genes_df[c(1, 3), ]
all_genes_df[2:3, ]
all_genes_df[, 2]
all_genes_df$name
all_genes_df$id
# Q: Subset all_genes_df for only the 2nd and 3rd rows
# hint: fill in the blanks as needed: all_genes[ , ]
all_genes[c(2,3), ]
all_genes_df[2:3, ]

# How to get information about objects in R
print(gene_names)
length(gene_names)
class(gene_names)
str(gene_names)

# Q: Examine the ToothGrowth dataset that is preloaded in your R session
# hint: Use ? to look up a description of the dataset in the help pages
# hint: try print(), length(), class(), str() on ToothGrowth
# hint: Now try head() and tail()

# Q: Subset ToothGrowth to show only the rows where the dose is higher than or equal to 1.0
# hint: Try ToothGrowth$dose >= 1.0
# hint: Remember that you can pass a vector of TRUE/FALSE within the [] to subset: ToothGrowth[true_false_vector, ]
