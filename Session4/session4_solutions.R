# PROBLEM SET ####

# Q1: Using the owid_covid_newyear dataset, plot total_cases_per_million on x axis and total_deaths_per_million on y axis
# Change the colour of the plots to 'darkgreen'
ggplot(owid_covid_newyear, aes(x = total_cases_per_million, y = total_deaths_per_million)) +
  geom_point(colour = "darkgreen")

# Q2: Using the owid_covid_4countries dataset, draw a faceted plot (one panel for
# each country), where each panel shows the date on the x axis vs. new_deaths_per_million 
# on the y axis in black and also icu_patients_per_million in red on the y axis
# Please see session4/results/plot_faceted_4countries_date_vs_deaths_and_icu.pdf for the expected output
owid_covid_4countries %>%
  ggplot(aes(x = date, y = new_deaths_per_million)) +
    geom_line(colour = "black") +
    geom_line(aes(x = date, y = icu_patients_per_million), colour = "red") +
    facet_wrap(~location) +
    theme_bw() +
    theme(panel.grid = element_blank(), panel.border = element_blank())

# Q3: (Advanced) Recreate the plot from session4/results/plot_bubble_total_cases_vs_deaths.pdf from
# the owid_covid_newyear dataset
# use shape = 21 for geom_point()
# hint: use geom_label_repel() from ggrepel package (v0.9.1)
# hint: use scale_size(range = c(2, 40))
# hint: save the plot as a pdf with width and height = 10
library(dplyr)
library(ggplot2)
library(ggrepel)
owid_covid_newyear %>%
  ggplot(aes(x = total_cases, y = total_deaths)) +
    geom_point(aes(size = population, fill = continent), shape = 21, colour = "black", alpha = 0.5) +
    scale_x_log10() +
    scale_y_log10() +
    geom_label_repel(aes(label = location)) +
    theme_bw() +
    theme(panel.grid = element_blank()) +
    guides(fill = guide_legend(override.aes = aes(color = NA))) +
    labs(x = "Total cases", y = "Total deaths", title = "OWID Covid dataset: Total cases vs. total deaths on Jan 01, 2021") + 
    scale_size(range = c(2, 40))
  
ggsave("Session4/results/bubble_solution.pdf", width = 10, height = 10)
