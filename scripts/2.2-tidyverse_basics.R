# 2.2 - tidyverse basics ####

# First, we need to install and load the the tidyverse metapackage
install.packages("tidyverse")
library(tidyverse)

# Notice which packages are actually being attached. Each deals with some aspect
# data I/O, wrangling and plotting of "tidy" data. You are already acquainted with
# `ggplot2`, now we'll get started with the main workhorse of the tidyverse: `tibble` and `dplyr` 

## tibble ####
# Compare the format of these two data frames. What do you notice?
rand100 <- sample(100)

df <- data.frame(
  ABC = rep(LETTERS[1:4], 25),
  num = rand100,
  desc = seq(0.1,10,0.1)
  )

tbl <- tibble(
  ABC = rep(LETTERS[1:4], 25),
  int = rand100,
  dbl = seq(0.1,10,0.1)
)

# We can also convert existing data frames into tibbles:
as_tibble(df)

# Note that we can add rownames to a new column using `as_tibble()`:
as_tibble(df, rownames = "id")

# A useful way of creating small tibbles is `tribble()`
tribble(
  ~x, ~y,  ~z,
  "a", 2,  3.6,
  "b", 1,  8.5
)

## The pipe ####
# The `|>` pipe adds the left side to the first argument of the function on the right side
df |> as_tibble(rownames = "id")
tbl |> ggplot(aes(x = ABC, y = num)) + geom_boxplot()

# It comes in handy when you would have used multiple objects or nested function calls
dim(head(tbl)) # becomes:
tbl |> head() |> dim()

## dplyr verbs ####

# Let's use the msleep dataset from the ggplot2 package
msleep

### Manipulate cases (i.e. rows) ####

#### filter() ####
msleep |> filter(order == "Rodentia")
msleep |> filter(grepl("rat", name))
msleep |> filter(!is.na(conservation), vore != "carni")

#### distinct() ####
msleep |> distinct(order)
msleep |> distinct(vore, conservation)

#### slice() ####
msleep |> slice(1:8)
msleep |> slice(n())
msleep |> slice_tail()
msleep |> slice_min(bodywt, n = 5)
msleep |> slice_max(bodywt, n = 5)

#### arrange() ####
msleep |> arrange(bodywt)
msleep |> arrange(desc(bodywt))

### Manipulate cases (i.e. rows) ####

#### mutate() ####
msleep |> mutate(brainbody_ratio = brainwt/bodywt)
msleep |> mutate(is_a_rat = grepl("rat", name))
msleep |> mutate(eats_meat = ifelse(vore == "herbi", 
                                    "No", 
                                    "Yes"))
msleep |> mutate(vore = ifelse(!is.na(vore), 
                               paste0(vore, "vore"), 
                               NA))

#### select() ####
msleep |> select(name, genus, vore, order)
msleep |> select(name:order)
msleep |> select(name, starts_with("sleep"), ends_with("wt"))
msleep |> select(-starts_with("sleep"))
msleep |> select(species_name = name, order, genus, everything())

# rename() is just a special case of select()
msleep |> rename(brain_weight = brainwt)

#### pull() ####
# Sometimes we just want a vector as an output
msleep |>
  filter(grepl("rat", name)) |>
  slice_max(sleep_total, n = 5) |>
  pull(name)

### Summarise cases ####
msleep |> summarise(mean_sleep_total = mean(sleep_total))
msleep |> count(order)

### Group cases ####
msleep |> 
  group_by(order) |>
    summarise(n = n(),
              mean_sleep_total = mean(sleep_total),
              mean_bodywt = mean(bodywt)) |>
  ungroup()

msleep |> 
  group_by(order) |>
  summarise(n = n(),
            mean_sleep_total = mean(sleep_total),
            mean_bodywt = mean(bodywt)) |>
  ungroup() |>
  ggplot(aes(x = mean_bodywt, y = mean_sleep_total, label = order)) +
  geom_text() +
  coord_cartesian(clip = "off")

## Exercise ####

# What are the 6 sleepiest animals in the msleep dataset?


# Rearrange the rows to be in order of descending body weight.


# Create a summary table showing average average sleep_cycle or each order. Start by removing observations with NA sleep_cycle.


# Rename the column genus to Genus


# For primates only, make a scatterplot of bodywt vs brainwt. Color points by species name.


# Now for all animals, make a scatterplot of bodywt vs brainwt, this time using geom_text().


