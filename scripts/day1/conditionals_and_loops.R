# When you type a Boolean expression in R, R will output TRUE if the expression is true and FALSE if the expression is false.
4 > 3
1028 < 12

# Having x and y
x = 2
y = 20
# Is x the same as y?
x = y # Careful! Remember equal operator is ==. Here you have redefined x with the value in y
x

# Let´s try again
x = 2
y = 20
x == y

# Test other conditions
y > x & y < 100
y%%x == 0 # %% gives the reminder of the first value with the second

# Let´s work with different data
a = c("Spain", "Italy", "Germany", "Luxemburg")
is.numeric(a) # test whether vector a is numeric
a[1]>a[3] # test whether element one of a is bigger than the third. 

# We can test also logical values
TRUE == FALSE
TRUE > FALSE

# Play with different type of data and operators!


# if 
x = 3
y = 5

if (x == 3){ 
  print("x value is 3")
}


if (x > 3){
  print("x value is higher than 3")
}


if (y > 3){
  print("y value is higher than 3")
}


# if... else conditional
if (x > 3){
  print("x value is higher than 3")
} else {
  print("x value is not higher than 3") 
}

sunny_countries = c("Spain", "Italy", "Greece", "Croatia")
if ("Germany" %in% sunny_countries){
  print("That´s my next holiday destination!")
} else {
  print("No way I´m going there this summer")
}



# Chained conditionals

x = 0
if (x > 0) {
  print("Positive number")
}else if (x < 0){
  print("Negative number")
} else {
  print("Zero")
}


temperature = 8
if (temperature < 10) {
  print("It´s cold today")
} else if (x > 10 & x < 20) {
  print("It´s not bad today")
} else {
  print("It´s nice today")
}


# Let's test what happens using if... else on a vector
v = c(1:10)

if(v == 3){
  print("Value equals 3")
} else {
  print("Value different than 3")
}


# We can use ifelse()
# syntax should be ifelse(condition, TrueBranch, FalseBranch)
ifelse(v==3, "Value equals 3", "Value different than 3")


# See one more example
if (v %% 2 == 0) {
  print("even number")
} else {
  print("odd number")
}

# using ifelse()
ifelse(v %% 2 == 0, "even number", "odd number")



# Let´s create new data
# %in% operator is used to check if the value of the first argument are present in the second argument and returns a logical vector.
sunny_countries = c("Spain", "Italy", "Greece", "Croatia")

if ("Spain" %in% sunny_countries){
  print("That´s my next holiday destination!")
} else {
  print("No way I´m going there this summer")
}


if ("Germany" %in% sunny_countries){
  print("That´s my next holiday destination!")
} else {
  print("No way I´m going there this summer")
}

# We can do the same for biological related vectors, for example:

genes_interest= c("PI3K", "FOXO", "VLDL", "LIPC")

if ("VLDL" %in% genes_interest){
  print("Gene of interest found")
} else {
  print("The gene of interest could not be found")
}

if ("P38" %in% genes_interest){
  print("Gene of interest found")
} else {
  print("The gene of interest could not be found")
}

# chained conditionals (ifelse)
temperature = 8
if (temperature < 10) {
  print("It´s cold today")
} else if (x > 10 & x < 20) {
  print("It´s not bad today")
} else {
  print("It´s nice today")
}


temperature = 45
if (temperature < 10) {
  print("It´s cold today")
} else if (x > 10 & x < 20) {
  print("It´s not bad today")
} else {
  print("It´s nice today") # That´s no longer really accurate
}

# How would you add an extra conditional for extremely high temperature?
temperature = 45
if (temperature < 10) {
  print("It´s cold today")
} else if (x > 10 & x < 20) {
  print("It´s not bad today") 
} else if (x >= 20 & x < 35) {
  print("It's nice today")
} else {
  print("It´s extremely hot today")
}


## Loops

# for-loop
genes = c("PI3K", "FOXO", "VLDL", "LIPC")
target = "FOXO"

for (val in genes)
{
  print(val)
}

v = c(1:10)
for (val in v)
{
  new_val = val + 1
  print(new_val)
}

# Exercise: we can add a conditional expression in the for-loop body 
genes = c("PI3K", "FOXO", "VLDL", "LIPC")
target = "FOXO"

for (val in genes)
{
  if(val == target){
    print(paste(val,"is a target"))
  } else {
    print(paste(val, "is not a target"))
  }
}


# for loops on lists
my_list = list(c(1,2,4), c("high", "low", NA), c(23, NA, 67))

for (val in my_list)
{
  print(is.na(val))
}


# while-loop
x = 0

while (x < 10)
{
  x = x + 1
  print (x)
} 


# Check the following while-loop. What´s wrong?
b = 2

while (b > 1)
{
  b = b + 1
  print ("This is an infinite loop")
}

# We can scape from this situation using by pressing Esc or clicking STOP on the console


# ADVANCED: if you want to have a look, break and next statements are used to terminate loops at a particular iteration or to skip a particular iteration.
