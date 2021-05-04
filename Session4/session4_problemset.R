# PROBLEM SET ####
# use the owid_covid_newyear dataset for questions 1-3
# Q1: Plot total_cases_per_million on x axis and total_deaths_per_million on y axis
# Change the colour of the plots to 'darkgreen'

# Q2: Using the owid_covid_4countries dataset, draw a faceted plot (one panel for
# each country), where each panel shows the date on the x axis vs. new_deaths_per_million 
# on the y axis in black and also icu_patients_per_million in red on the y axis
# Please see session4/results/plot_faceted_4countries_date_vs_deaths_and_icu.pdf for the expected output

# Q3: (Advanced) Recreate the plot from session4/results/plot_bubble_total_cases_vs_deaths.pdf from
# the owid_covid_newyear dataset
# use shape = 21 for geom_point()
# hint: use geom_label_repel() from ggrepel package
# hint: use scale_size(range = c(2, 40))
# hint: save the plot as a pdf with width and height = 10

# Q4: For the covid data from India, plot date along the x axis and total number of 
# COVID-19 vaccination doses administered on the y axis; # also plot new confirmed 
# cases on the y axis in a different colour (look up the codebook https://github.com/owid/covid-19-data/blob/master/public/data/owid-covid-codebook.csv
# for description of the columns)
