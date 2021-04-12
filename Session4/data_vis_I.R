library(tidyverse)
# library(dplyr) # if tidyverse not loaded
# library(ggplot2) # if tidyverse not loaded
# LOAD Our World In Data Covid dataset ####
owid_covid = read.csv("Session3/data/owid-covid-data.csv", header = TRUE,
                      stringsAsFactors = FALSE)
owid_covid$date = as.Date(owid_covid$date)


# FILTER dataset to make smaller data.frames ####
# filter for UK data 
owid_covid %>%
  filter(location == "United Kingdom") -> owid_covid_uk

# filter for 4 countries
four_countries = c("United Kingdom", "Belgium", "Germany", "United States")
owid_covid %>%
  filter(location %in% four_countries) -> owid_covid_4countries

new_year = "2021-01-01"

# ggplot2 basics ####

# Base R plot
plot(x = owid_covid_uk$date, y = owid_covid_uk$total_cases_per_million, type = "l", col = "red")

# The same plot with ggplot2 (we are passing mapping argument to the ggplot function)
ggplot(data = owid_covid_uk, mapping = aes(x = date, y = total_cases_per_million)) +
  geom_line()

# the above code does the same as the following (we are passing mapping argument to the geom function)
ggplot(data = owid_covid_uk) +
  geom_line(mapping = aes(x = date, y = total_cases_per_million)) +
  geom_point(mapping = aes(x = date, y = total_deaths_per_million), colour = "red")

# let's change the colour of the line to red (this is not an aesthetic, i.e., 
# the colour is not derived from the dataset itself)
ggplot(data = owid_covid_uk) +
  geom_line(mapping = aes(x = date, y = total_cases_per_million), colour = "blue") 

# let's add new data, total_deaths_per_million as a differently coloured line
ggplot(data = owid_covid_uk) +
  geom_line(mapping = aes(x = date, y = total_cases_per_million), colour = "red") +
  geom_line(mapping = aes(x = date, y = total_deaths_per_million), colour = "blue") 

# COLOUR by categorical data ####
owid_covid_4countries %>%
  ggplot(aes(x = date, y = total_deaths_per_million)) +
  geom_line()

ggplot(data = owid_covid_4countries, mapping = aes(x = date, y = total_deaths_per_million)) +
  geom_line()

# What's going on here? 
owid_covid_4countries %>%
  filter(date == new_year)

# We have 4 data points for each date (one for each country), but we haven't
# told ggplot to plot them separately

# here we pass colour within the aesthetic function, because we want to colour by location

owid_covid_4countries %>%
  ggplot() +
    geom_line(mapping = aes(x = date, y = total_deaths_per_million, colour = location))

owid_covid %>%
  filter(location %in% c("Belgium", "Germany")) %>%
  ggplot() +
  geom_line(mapping = aes(x = date, y = total_deaths_per_million, colour = location))

# NOTE: the following will NOT work, it will give an error
owid_covid_4countries %>%
  ggplot() +
  geom_line(mapping = aes(x = date, y = total_deaths_per_million), colour = location)

# Q: What is the difference between the following two lines? Without running the code,
# can you tell which one will give you the expected result?
ggplot(iris) + geom_point(mapping = aes(x = Sepal.Length, y = Petal.Length, colour = "blue"))

ggplot(iris) + geom_point(mapping = aes(x = Sepal.Length, y = Petal.Length), colour = "blue")


# Building a plot step-by-step ####

owid_covid %>%
  filter(date == new_year) -> owid_covid_newyear

plot(x = log10(owid_covid_newyear$total_cases), y = log10(owid_covid_newyear$total_deaths))

# 1 - make canvas
ggplot(date = owid_covid_newyear)

# 2 - add mapping
ggplot(owid_covid_newyear, aes(x = total_cases, y = total_deaths))

# 3 - add geom(s)
ggplot(owid_covid_newyear, aes(x = total_cases, y = total_deaths)) +
  geom_point()

# 4 - change scale to log
ggplot(owid_covid_newyear, aes(x = total_cases, y = total_deaths)) +
  geom_point() +
  scale_x_log10() +
  scale_y_log10()

# 5 - add trendline
ggplot(owid_covid_newyear, aes(x = total_cases, y = total_deaths)) +
  geom_point() +
  scale_x_log10() +
  scale_y_log10() +
  geom_smooth(method = "lm")

# 6 - change theme
ggplot(owid_covid_newyear, aes(x = total_cases, y = total_deaths)) +
  geom_point() +
  scale_x_log10() +
  scale_y_log10() +
  geom_smooth(method = "lm") +
  theme_bw()

# 7 - add main title
ggplot(owid_covid_newyear, aes(x = total_cases, y = total_deaths)) +
  geom_point() +
  scale_x_log10() +
  scale_y_log10() +
  geom_smooth(method = "lm") +
  theme_bw() +
  ggtitle("OWID Covid dataset: Total cases vs. total deaths on Jan 01, 2021")

# 8 - change x and y labels
ggplot(owid_covid_newyear, aes(x = total_cases, y = total_deaths)) +
  geom_point() +
  scale_x_log10() +
  scale_y_log10() +
  geom_smooth(method = "lm") +
  theme_bw() +
  ggtitle("OWID Covid dataset: Total cases vs. total deaths on Jan 01, 2021") +
  labs(x = "Total cases", y = "Total deaths")

# 9 - remove panel grid
ggplot(owid_covid_newyear, aes(x = total_cases, y = total_deaths)) +
  geom_point() +
  scale_x_log10() +
  scale_y_log10() +
  geom_smooth(method = "lm") +
  theme_bw() +
  ggtitle("OWID Covid dataset: Total cases vs. total deaths on Jan 01, 2021") +
  labs(x = "Total cases", y = "Total deaths") +
  theme(panel.grid = element_blank())

# 10 - add location mapping to size of point
ggplot(owid_covid_newyear, aes(x = total_cases, y = total_deaths)) +
  geom_point(aes(size = population)) +
  scale_x_log10() +
  scale_y_log10() +
  geom_smooth(method = "lm") +
  theme_bw() +
  ggtitle("OWID Covid dataset: Total cases vs. total deaths on Jan 01, 2021") +
  labs(x = "Total cases", y = "Total deaths") +
  theme(panel.grid = element_blank())

# 11 - store the plot in a variable
plot_total_cases_vs_deaths = ggplot(owid_covid_newyear, aes(x = total_cases, y = total_deaths)) +
  geom_point(aes(size = population)) +
  scale_x_log10() +
  scale_y_log10() +
  geom_smooth(method = "lm") +
  theme_bw() +
  ggtitle("OWID Covid dataset: Total cases vs. total deaths on Jan 01, 2021") +
  labs(x = "Total cases", y = "Total deaths") +
  theme(panel.grid = element_blank())

print(plot_total_cases_vs_deaths)
# 12 - save the plot to file
ggsave()
ggsave("session4/results/plot_total_cases_vs_deaths.pdf", 
       plot = plot_total_cases_vs_deaths, width = 20, height = 5)
ggsave("session4/results/plot_total_cases_vs_deaths.png", 
       plot = plot_total_cases_vs_deaths)
ggsave("session4/results/plot_total_cases_vs_deaths.svg", 
       plot = plot_total_cases_vs_deaths)

# PROBLEM SET ####
# Q: Plot total_cases_per_million on x axis and total_deaths_per_million on y axis
# Change the colour of the plots to green

# Q: Using the owid_covid_4countries dataset, draw a faceted plot (one panel for
# each country), where each panel shows the date on the x axis vs. new_deaths_per_million 
# on the y axis in black and also icu_patients_per_million in red on the y axis
# Please see session4/results/plot_faceted_4countries_date_vs_deaths_and_icu.pdf for the expected output

# Q: (Advanced) Recreate the plot from session4/results/plot_bubble_total_cases_vs_deaths.pdf from
# the owid_covid_newyear dataset
# use shape = 21 for geom_point()
# hint: use geom_label_repel() from ggrepel package
# hint: use scale_size(range = c(2, 40))
# hint: save the plot as a pdf with width and height = 10

