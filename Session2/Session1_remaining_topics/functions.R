###R for biologists
##Irina & Rao, 20/01/2021

####Functions are also assigned to variables####
add <- function(x, y) return(x + y)
add(10, 11)

add <- function(x, y) {
  return(x + y)
}

sum_of_squares <- function(x) {
  sum(x^2)
}

sum_of_squares(1:5)

####Create a function to convert Fahrenheit to Celsius####
fahrenheit_to_celsius <- function(temp_F) {
  temp_C <- (temp_F - 32) * 5 / 9
  return(temp_C)
}

fahrenheit_to_celsius(35)

##There is a package doing the same thing for you (and many more)!
install.packages("weathermetrics")
library("weathermetrics")

fahrenheit.to.celsius(35)