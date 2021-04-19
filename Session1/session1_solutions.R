####Problem set####

#Q: In the vector gene_names, print the genes whose names start with P, using a loop to iterate through each gene name
gene_names = c("TP53", "PTEN", "RB1", "MYC")

# 1
for(each_gene in gene_names) {
  if(startsWith(each_gene, "P")) {
    print(each_gene)
  }
}

# 2
# startsWith(gene_names, "P")
gene_names[startsWith(gene_names, "P")]

#Q: In a vector of numbers 1 to 20, print the numbers that are divisible by 3
num1to20 = 1:20

# 1
for(each_num in num1to20) {
  if((each_num %% 3) == 0) {
    print(each_num)
  }
}

# 2
# We know that num1to20 %% 3 gives the remainder for each number in the vector num1to20
# We can convert the remainder vector into a logical vector with as.logical()
# and get a negation of the vector with !
num1to20[!as.logical(num1to20 %% 3)]
