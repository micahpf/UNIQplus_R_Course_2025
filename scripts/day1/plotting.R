## DAY 2 AFTERNOON SESSIONS: PLOTTING WITH BASE R ####

### Base R ####
#Let´s start by exploring basic R plotting. 
#It is important to understand there is no need to remember all the arguments and optional things we can do with graphs. The important is to understand how plotting works and know the sources to get the information to reach your desired plot.
#We will work in heroes dataset
heroes = read.csv("../datasets/heroes_information.csv")
View(heroes)
str(heroes)
heroes$Publisher = as.factor(heroes$Publisher) # change Publisher variable to factor
heroes$Gender = as.factor(heroes$Gender) # change Gender variable to factor
levels(heroes$Gender)= c("Not Specified", "Female", "Male")# Define a new level as "Not Specified"


#### Histograms ####
hist(heroes$Height) # Histogram to see distribution
hist(heroes$Height, breaks=50) # More detail
hist(heroes$Height, breaks=50, col="red") # Add colour
hist(heroes$Height, breaks=50, col="red", main = "Height distribution") # Add title

#### Barplots ####
plot(heroes$Publisher) # Barplot
plot(heroes$Publisher, las=2) # turn 90 degrees x labels
plot(heroes$Publisher, las=2, cex.names=0.6) # change size labels
plot(heroes$Publisher, las=2, cex.names=0.6, ylim= c(0,500)) # Increase y axis range
plot(heroes$Publisher, las=2, cex.names=0.6, ylim= c(0,500), main = "Barplot of heroes by publisher") # add title


#### XY graphs / scatterplots / correlation ####
plot(heroes$Height, heroes$Weight) # Scatterplot of x and y values
plot(heroes$Height, heroes$Weight, col="blue") #colour for every gender
plot(heroes$Height, heroes$Weight, col=heroes$Gender) #colour for every gender
plot(heroes$Height, heroes$Weight, col=heroes$Gender, pch=24) #change symbol
plot(heroes$Height, heroes$Weight, col=heroes$Gender, pch=24, cex=2) #change size

plot(heroes$Height, heroes$Weight, col=heroes$Gender, pch=24)
legend(x=700, y=700, legend = levels(heroes$Gender), col=c(1:3), pch= 24) #create legend

# Remember we can check the different symbols we can use  
ggpubr::show_point_shapes()

#### Boxplots ####
boxplot(heroes$Height) # We can see distribution of the variable Height
boxplot(heroes$Height,heroes$Weight) # We can plot multiple boxplots (multiple variables)
boxplot(heroes$Height,heroes$Weight, names=c("Height", "Weight")) # Add name of variables plotted

# If we want to plot data based on a categorical data we can use plot()
plot(heroes$Gender, heroes$Height) # plot height data splited by Gender
plot(heroes$Gender, heroes$Height, col=c("green","blue", "red")) #add colour
plot(heroes$Gender, heroes$Height, col=c("green","blue", "red"), xlab = "Gender" ) #change x axis title

#### Save graphs ####
pdf("Barplot_heroes.pdf")
plot(heroes$Publisher, las=2, cex.names = 0.6, ylim= c(0,500), main = "Barplot of heroes by publisher") 
dev.off()


pdf("Barplot_heroes.pdf", width=15, height = 15)
plot(heroes$Publisher, las=2, cex.names = 0.6, ylim= c(0,500), main = "Barplot of heroes by publisher") 
dev.off()

png("Hero_scatterplot.png")
plot(heroes$Height, heroes$Weight, col=heroes$Gender, pch=24)
dev.off()

#### More advanced information####
# Colours can be defined in different ways

# specifing colour name (most common)
boxplot(heroes$Height, col="blue") 
# you can find all the names for colours that R offers using
colors()

# specifing hexadecimal color code 
boxplot(heroes$Height, col="#FF00CC") 
# https://htmlcolorcodes.com will allow you to pick a colour and get the code

# using number 
boxplot(heroes$Height, col=431) 

# using rgb() function to build a color (red, green, blue)
boxplot(heroes$Height, col=rgb(0.3, 0.7, 0.3))

#### Exercises ####


# Plot a boxplot of the Weight by Alignment.





# Plot the frequency of every alignment in the dataset







