#### Problem set ####
# Use the migmorph data.frame for these questions

# Q1: Knockdown of which gene results in the highest migration?
# # hint: this can be accomplished with the max() function
migmorph[migmorph$migration == max(migmorph$migration), ]

# Q2: Make a new data.frame that has only rows with 0.9 > migration > 0.4 AND elongatedness > 1.4
migmorph_subset = migmorph[(migmorph$migration < 0.9) & 
                             (migmorph$migration > 0.4) & 
                             (migmorph$elongatedness > 1.4), ]
# Q2.1: What is the correlation between migration and elongatedness in this new dataset?
cor.test(migmorph_subset$migration, migmorph_subset$elongatedness)
# Q2.2: Draw an XY plot showing the relationship between these two variables in this new dataset
plot(migmorph_subset$migration, migmorph_subset$elongatedness)
