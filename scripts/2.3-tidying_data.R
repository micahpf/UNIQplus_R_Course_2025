# 2.3 - Making data tidy ####
library(tidyverse)

## Pivoting longer ####

# We'll use the built-in example the tidyr package
table1

### Simple example
table4a |> 
  pivot_longer(cols = -country, names_to = "year", values_to = "cases")

### String data in column names
relig_income

relig_income |>
  pivot_longer(
    cols = !religion,
    names_to = "income",
    values_to = "count"
  )

### Numeric data in column names
billboard

billboard |>
  pivot_longer(
    cols = starts_with("wk"),
    names_to = "week",
    values_to = "rank",
    values_drop_na = TRUE
  )

billboard |>
  pivot_longer(
    cols = starts_with("wk"),
    names_to = "week",
    names_prefix = "wk",
    names_transform = as.integer,
    values_to = "rank",
    values_drop_na = TRUE
  )

## Pivoting wider ####
table2 |> 
  pivot_wider(
    names_from = type, 
    values_from = count
  )

fish_encounters
  
fish_encounters |>
  pivot_wider(
    names_from = station,
    values_from = seen
  )

fish_encounters |>
  pivot_wider(
    names_from = station,
    values_from = seen,
    values_fill = 0
  )

fish_encounters |>
  pivot_wider(
    names_from = station,
    values_from = seen,
    values_fill = 0
  ) |>
  column_to_rownames(var = "fish") |>
  as.matrix()

## Combining datasets ####
# We'll load a package with several tibbles related to flight data in NYC
install.packages("nycflights13")
library(nycflights13)

# Drop unimportant variables so it's easier to understand the join results
flights2 <- flights |> select(year:day, hour, origin, dest, tailnum, carrier)
airlines
weather2 <- weather |> select(origin:hour, starts_with("wind"), visib)
planes
airports

# We can merge the two tables together using a `*_join` from `dplyr`
flights2 |>
  left_join(airlines)

flights2 |>
  left_join(weather2)

# We can control which variables are used to join the datasets with the `by` arg
# The column `year` in the two datasets mean something different and don't match
# so `left_join()` adds a .x and .y suffix to differentiate them in the new data
flights2 |> left_join(planes, by = "tailnum")

# We can define how to match `by` columns across datasets using this notation:
flights2 |> left_join(airports, by = c("dest" = "faa"))
flights2 |> left_join(airports, by = c("origin" = "faa"))

### Mutating joins ####

(df1 <- tibble(x = c(1, 2), y = 2:1))
(df2 <- tibble(x = c(3, 1), a = 10, b = "a"))

# inner_join(x, y) only includes observations that match in both x and y.
df1 |> inner_join(df2)

# left_join(x, y) includes all observations in x, regardless of whether they match or not. 
# This is the most commonly used join because it ensures that you don’t lose 
# observations from your primary table.
df1 |> left_join(df2)

# right_join(x, y) includes all observations in y.
df1 |> right_join(df2)
df1 |> left_join(df2)

# full_join() includes all observations from x and y.
df1 |> full_join(df2)

# NB: If a match is not unique, a join will add all possible combinations of the 
# matching observations:

(df3 <- tibble(x = c(1, 1, 2), y = 1:3))
(df4 <- tibble(x = c(1, 1, 2), z = c("a", "b", "a")))

df3 %>% left_join(df4)

### Filtering joins ####
# Filtering joins do not add columns, they simply filter the rows to match across datasets
# They never duplicate, only keep or drop rows

# semi_join(x, y) keeps all observations in x that have a match in y.
# Which flights have corresponding plane data?
flights2 %>% 
  semi_join(planes, by = "tailnum") %>% 
  count(tailnum, sort = TRUE)

# anti_join(x, y) drops all observations in x that have a match in y.
# Which flights don't have corresponding plane data?
flights2 %>% 
  anti_join(planes, by = "tailnum") %>% 
  count(tailnum, sort = TRUE)

## Separating composite columns ####
# Recall that tidy data should have just one observation per cell
# We can use `separate_wider_*()` functions to split composite observations
(table5_sep <- table5 |>
   separate_wider_delim(rate, "/", names = c("cases", "population")))

## Combining two columns
# We can reverse the above with `unite()`
table5 |>
  unite(col = "year", century:year, sep = "", remove = TRUE)

## Exercises ####
# Change the below to keep the original column. Consult `?separate_wider_delim`.
table5_sep <- table5 |>
  separate_wider_delim(rate, "/", names = c("cases", "population"))

# Use `unite()` to reverse the following `table5_sep` back to the same form as `table5`
table5_sep

# Manipulate these two tables
table4a
table4b
# to be identical to this table
table1

# Here's a fun plot. 
billboard |>
  pivot_longer(
    cols = starts_with("wk"),
    names_to = "week",
    names_prefix = "wk",
    names_transform = as.integer,
    values_to = "rank",
    values_drop_na = TRUE
  ) |>
  filter(artist %in% c("N'Sync", "Backstreet Boys, The")) |>
  ggplot(aes(x = week, y = rank, color = track, group = track, linetype = artist)) +
  geom_line() +
  scale_y_reverse() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))

## More resources ####

# For a lot more detail on pivots
vignette("pivot")

# Click on HTML link in the "Two-table verbs" row after running this:
browseVignettes(package = "dplyr")

