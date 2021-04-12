###R for biologists
##Irina & Rao, 20/01/2021


#### DETOUR: paste() joins two or more character objects ####
# We made a vector of patient ids as follows
patient_ids = c("234", "342", "892")

# We then realised that the ids need to be prefixed with JR
paste("JR", patient_ids)
paste("JR", patient_ids, sep = "")


gene_names = c("TP53", "PTEN", "RB1", "MYC")
gene_ids = c(7157, 5728, 5925, 4609)

gene_names_and_ids = paste(gene_names, gene_ids, sep = "-")


#### LOOP FUNCTIONS ####
# Loop functions do essentially the same thing as for loops
# But they may be more convenient in many situations


p53 = c("TP53", "7157")
pten = c("PTEN", "5728")
rb1 = c("RB1", "5925")
cmyc = c("MYC", "4609")

all_genes = list(p53, pten, rb1, cmyc)
lapply(all_genes, paste, collapse = "-")


# An equivalent way to do this (Spot the difference!)

for(each_gene in all_genes) {
  joined_name = paste(each_gene, collapse = "-")
  print(joined_name)
}

# another example - we have a list of vectors a, b, c; we want the mean for each of them
my_list = list(a = c(1, 2, 3), b = c(4, 5, 6), c = c(7, 8, 9))
lapply(my_list, mean)

# Q: Write the equivalent in a for loop

