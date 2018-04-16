# Exercise 4: practicing with dplyr

# Install the `nycflights13` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
  library(dplyr)
  install.packages("nycflights13")
  library(nycflights13)
  

# The data frame `flights` should now be accessible to you.
# Use functions to inspect it: how many rows and columns does it have?
# What are the names of the columns?
# Use `??flights` to search for documentation on the data set (for what the 
# columns represent)
  ??flights
  View(flights)
  ncol(flights)
  nrow(flights)

# Use `dplyr` to give the data frame a new column that is the amount of time
# gained or lost while flying (that is: how much of the delay arriving occured
# during flight, as opposed to before departing).
  flights_delay <- mutate(flights, gained_lost = arr_delay - dep_delay)
    

# Use `dplyr` to sort your data frame in descending order by the column you just
# created. Remember to save this as a variable (or in the same one!)
 flights_delay <- arrange(flights, gained_lost)

# For practice, repeat the last 2 steps in a single statement using the pipe
# operator. You can clear your environmental variables to "reset" the data frame
  flights_change <- flights %>% 
    mutate(gained_lost = arr_delay - dep_delay) %>% 
    arrange(-gained_lost)

# Make a histogram of the amount of time gained using the `hist()` function
  hist(flights_change$gained_lost)

# On average, did flights gain or lose time?
# Note: use the `na.rm = TRUE` argument to remove NA values from your aggregation
  summaries <- summarize(flights_change, mean = mean(gained_lost, na.rm = TRUE))

# Create a data.frame of flights headed to SeaTac ('SEA'), only including the
# origin, destination, and the "gain_in_air" column you just created
  jfk_sea <- flights_change %>% 
    filter(origin == "JFK", dest == "SEA") %>% 
    select(origin, dest, gained_lost)

# On average, did flights to SeaTac gain or loose time?
  summarise(jfk_sea, mean = mean(gained_lost, na.rm = TRUE))

# Consider flights from JFK to SEA. What was the average, min, and max air time
# of those flights? Bonus: use pipes to answer this question in one statement
# (without showing any other data)!
  summary <- flights_change %>% 
    filter(origin == "JFK", dest == "SEA") %>% 
    summarise(
      avg_time = mean(gained_lost, na.rm = T),
      min_time = min(gained_lost, na.rm = T),
      max_time = max(gained_lost, na.rm = T)
    )
