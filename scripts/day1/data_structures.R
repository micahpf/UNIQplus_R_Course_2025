my_var <- "apple"
# atomic vectors
my_vector <- c(1, 2, 3, 5)
my_vec2 <- 1:400

my_vector
my_vec2

my_vector[4]
my_vector[3:4]

squirrel[c(1, 2), ]
# subset the 3, 6, 10 rows
squirrel[c(3, 6, 10), ]

vector_mixed <- c(1, "two", 5, "apple", TRUE)
vector_mixed

as.numeric(vector_mixed)
as.logical(vector_mixed)
as.logical(my_vector)
as.numeric(as.character(my_vector))

squirrel_incorrect <- read.csv("../datasets/nyc_squirrel_uniq_plus.csv", header = FALSE)
str(squirrel_incorrect)


all_data <- list(my_vector, squirrel, squirrel_incorrect)

View(all_data[2]) # gives a list
View(all_data[[2]]) # gives a data.frame

squirrel[[3]] # all data.frames are lists

# matrix
matrix(1:40, nrow = 10)
head(as.matrix(squirrel))
