# Let´s create a vector with multiple NAs
my_data = c(3, 4, NA, 4, 5, NA, 1, NA, NA)
median(my_data, na.rm = TRUE)
# Test if there are NAs in our data
is.na(my_data) # Gives us a logical vector
which(is.na(my_data)) # gives us the location (indexes) of these NAs (TRUE)

# However if we are testing a large vector
sum(is.na(my_data)) # identify number of NA
table(is.na(my_data)) # counts number of NA

# We can test a column of our hero dataset
which(is.na(heroes$Weight))

# Remove NA
remove_na = is.na(my_data) # logical vector which information about where NAs are
my_data = my_data[!remove_na] # subset my_data to not include the TRUE elements
my_data
is.na(my_data)

# Now let's work with a data frame
data.frame = data.frame (c1 = 1:8, c2 = factor (c("a", "b", "a", "c", "b", "c", "a", "b")))
View(data.frame)
data.frame[4,1] = data.frame[6,2] = NA

# Test if there are NAs
is.na(data.frame)
table(is.na(data.frame))

# Filter missing data
na.omit(data.frame)

View(data.frame)


# Let's work on a similar data.frame
data.frame = data.frame (c1 = 1:8, c2 = factor (c("a", "-", "a", "c", "b", "c", "-", "b")))
View(data.frame)

# Check if there is any NA
is.na(data.frame)

# However we know that column 2 misses some values as - 
sum(data.frame == "-") 

# Let´s recode them to NAs
data.frame[data.frame == "-"] = NA
is.na(data.frame)
View(data.frame)

# The hero dataset has some missing values that are not strictly shown as NA. Can you identify any and recode them?
