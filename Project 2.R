#GODLIVER ALANGYAM AWONLIE
#ALY 6010
#11/19/2024
#Milestone Project 2



#Loading libraries
library(pacman)
library(tidyverse)
library(dplyr)
library(janitor)

#Loading dataset into R 
air_quality <- read_csv("Air_Quality.csv")


# Clean column names
air_quality <- clean_names(air_quality)

# Convert dates to proper format
air_quality$start_date <- as.Date(air_quality$start_date, format="%m/%d/%Y")


# Extracting the PM2.5 pollutant from the dataset
pm25_data <- air_quality |>
  filter(indicator_id== 365)|>
  filter(geo_type_name == "UHF42")

#Performing a discriptive analysis on the PM2.5 pollutant
describe_pm25 <- pm25_data |> 
  summarize(
    mean_value = mean(data_value,na.rm = TRUE),
    median_value = median(data_value, na.rm = TRUE),
    sd_value = sd(data_value, na.rm = TRUE),
    min_value = min(data_value, na.rm = TRUE),
    max_value = max(data_value, na.rm = TRUE),
    n_observations = n()
    )

#T-test statistic for the PM25 values
PM25_ttest_result <- t.test(pm25_data$data_value, mu= 10)
print(PM25_ttest_result)



# Extract PM2.5 data for both regions
pm25_sq <- pm25_data |>filter(geo_place_name == "Southeast Queens")|> select(data_value)
pm25_bb <- pm25_data |> filter(geo_place_name == "Bensonhurst - Bay Ridge")|>select(data_value)

# Perform two-sample t-test
doublet_test_result <- t.test(pm25_sq$data_value, pm25_bb$data_value)

# Display the results
doublet_test_result


# Extract NO2 data for summer and winter
no2_summer <- air_quality |> filter(name == "Nitrogen dioxide (NO2)" & grepl("Summer",time_period)) |> select(data_value)
no2_winter <- air_quality |> filter(name == "Nitrogen dioxide (NO2)" & grepl("Winter", time_period)) |> select(data_value)
no2_summer
#Performing two-sample t-test
season_test_result <- t.test(no2_summer$data_value, no2_winter$data_value)

#Display the result
season_test_result






