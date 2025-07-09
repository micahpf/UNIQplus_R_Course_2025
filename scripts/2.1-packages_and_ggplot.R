# 2.1 - Packages and ggplot2 ####
## 2.1.1 - Installing and loading packages ####

### base R ####
# So far we have been using R packages installed and loaded in "base R"
sessionInfo()

# Look at the help page for "base" and each of the other "attached base packages"
?base

### Install a CRAN package ####
# Do you have ggplot2 installed already?
?ggplot2::`ggplot2-package` 
# Also try the "Packages" tab in the "Output pane" (bottom right)

# If not:
install.packages("ggplot2")
# Restart R to make recently installed packages available

# Try again
?ggplot2::`ggplot2-package`

### Install a Bioconductor package ####
# First, install the Bioconductor package manager from CRAN
# Bioconductor depends on an ecosystem of bioinformatics-specifc packages
# with their own standards, so they use a separate package manager to handle
# the dependencies
install.packages("BiocManager")

# Then use BiocManager to install a package
BiocManager::install("fgsea")

# Check whether fgsea is installed
??fgsea

### How to install via github ####
# ***In the interest of time, we won't run this during class***
# Packages from github are installed from source, which requires compilers
# A package on CRAN will be the stable version, but the latest "development" 
# version is often offered on github. For example, see the README for
# https://github.com/nanxstats/ggsci/
# To install via github
# install.packages("remotes")
# install_github("ggsci")

### Loading packages ####
# Check which packages you have loaded again
sessionInfo()

# Now load ggplot2
library(ggplot2)

# How did sessionInfo change?
sessionInfo()

## 2.1.2 - ggplot2 ####

# We'll be walking through a modified version of the material found here:
vignette("ggplot2")

# ggplot2 divides plotting into 7 components
# - Data*
# - Mapping*
# - Layers*
# - Scales
# - Facets
# - Coordinates
# - Themes
# *The first three are required, the rest have sensible defaults

### Data ####
# We'll use a dataset that comes loaded with ggplot2
?mpg
mpg

# The first argument of a ggplot call is always the dataset you will be drawing from
ggplot(data = mpg)

### Mapping ####
# The mapping of a plot is a set of instructions on how to map data variables onto
# aesthetic attributes of the geometric objects being plotted.
# In the second argument, we assign a particular column of the dataset to a 
# particular graphical attribute, such as x and y
ggplot(mpg, mapping = aes(x = cty, y = hwy))

# Notice how setting the aesthetics automatically adds axes with the ranges from 
# the data. We can adjust these later if desired.

### Layers ####
# We draw parts of the plot in layers, which take mapped data and plot them.
# Each layer has three parts:
# - The **geometry** determines *how* data are displayed, such as points, lines, barplots, or boxplots.
# - The **statistical transformation** that may compute new variables from the data 
#   and affect *what* of the data is displayed.
# - The **position** adjustment that primarily determines where a piece of data is being displayed.

#### Geom ####

# We can layer different types of plots, "geometries", using `geom_*` functions
# Each has their own help pages with examples and requirements

# To create a scatterplot we use geom_point()
ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point()

# We can add aesthetics to the plot
ggplot(mpg, aes(x = cty, y = hwy, color = class)) +
  geom_point()

# We can add additional geometries to the plot:
ggplot(mpg, aes(x = cty, y = hwy, color = class)) +
  geom_point() +
  geom_abline() +
  geom_smooth(method = "lm")

# Note that each `geom_*` function can take data, and mapping arguments
# The data and mapping in `ggplot()` are taken as global settings, while
# those in a `geom_*` are specific to that geometry, and overwrite the global
ggplot(mpg, aes(x = cty, y = hwy, color = class)) +
  geom_point() +
  geom_smooth(method = "lm", color = "grey", fill = "grey")

ggplot(mpg, aes(x = cty, y = hwy, color = class)) +
  geom_text(aes(label = model))

# Also note that we can change plot aesthetics without mapping to a data variable
ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point(alpha = 0.25, color = "orange")

# To create a histogram, we use geom_histogram()
# Note that the counts are not in the data frame, they are computed by ggplot
ggplot(mpg, aes(x = cty)) +
  geom_histogram()

#### Stat ####
# Some geoms automatically calculate summary statistics on the data to plot
# We can adjust this with `stat = *`
# You will mostly encounter these with geom_histogram, geom_bar, geom_col, etc.

# Each geom has a specific `stat = *` default.
df <- data.frame(ABC = letters[1:5],
                 nums = 1:5)

ggplot(df, aes(x = ABC, y = nums)) +
  geom_bar()

?geom_bar

ggplot(df, aes(x = ABC, y = nums)) +
  geom_bar(stat = "identity")

ggplot(df, aes(x = ABC, y = nums)) +
  geom_col()

# We can also make transformations after ggplot has calculated stats with after_stat()
# Returning to geom_histogram():
ggplot(mpg, aes(x = cty)) +
  geom_histogram()

ggplot(mpg, aes(x = cty)) +
  geom_histogram(aes(y = after_stat(density)))

#### Position ####

# To plot a bar plot of the bodyweight of each class
ggplot(mpg, aes(x = class)) +
  geom_bar()

# When we add a fill color aesthetic, the bars are stacked
ggplot(mpg, aes(x = class, fill = drv)) +
  geom_bar()

# We can put bars side-by-side with the position component
ggplot(mpg, aes(x = class, fill = drv)) +
  geom_bar(position = position_dodge())

### Scales ####
# ggplot uses `scale_{aesthetic}_{type}()` functions to control scales

# Coming back to our scatter plot:
ggplot(mpg, aes(x = cty, y = hwy, color = class)) +
  geom_point()
  
ggplot(mpg, aes(x = cty, y = hwy, color = class)) +
  geom_point() +
  scale_color_viridis_d()

ggplot(mpg, aes(x = cty, y = hwy, color = class)) +
  geom_point() +
  scale_color_viridis_d() +
  scale_x_log10() +
  scale_y_log10()

### Facets ####
# We can split our data into subplots easily using facet_wrap() and facet_grid()
ggplot(mpg, aes(x = cty, y = hwy, color = class)) +
  geom_point() +
  scale_color_viridis_d() +
  facet_wrap(~manufacturer)

ggplot(mpg, aes(x = cty, y = hwy, color = class)) +
  geom_point() +
  scale_color_viridis_d() +
  facet_grid(year ~ drv)

### Coordinates ####
ggplot(mpg, aes(x = cty, y = hwy, color = class)) +
  geom_point() +
  scale_color_viridis_d() +
  coord_fixed()

ggplot(mpg, aes(x = class, fill = drv)) +
  geom_bar() +
  coord_polar()

### Theme ####
# The theme system controls almost any visuals of the plot that are not controlled 
# by the data. Many elements of the theme are organized hierarchically, and can 
# can be discovered with tab completion.

# Pre-configured `theme_*()` functions can change many aspects of the appearance at once.
ggplot(mpg, aes(x = cty, y = hwy, color = class)) +
  geom_point() +
  scale_color_viridis_d() +
  theme_bw()

# We can set a theme to use instead of the default using theme_set(theme_*())
theme_set(theme_minimal())

# You can fine tune the appearance with `theme()` where the order of element names
# often follow an order like this: theme({compenent}.{part}.{aesthetic}.{orientation})
# We use `element_*({aesthetic} = {string/number})` to control the graphical attributes of
# theme components.
ggplot(mpg, aes(x = cty, y = hwy, color = class)) +
  geom_point() +
  scale_color_viridis_d() +
  theme(legend.position = "bottom", 
        axis.title.x = element_text(color = "red"),
        axis.text.y = element_text(size = 12))


### Saving ggplots ####
# You can save ggplots as objects and continue to add to them
(p1 <- ggplot(mpg, aes(x = cty, y = hwy, color = class)) +
  geom_point() +
  scale_color_viridis_d() +
  theme(legend.position = "bottom", 
        axis.title.x = element_text(color = "red"),
        axis.text.y = element_text(size = 12)))

(p1 <- p1 + geom_smooth(method = "lm", color = "gray", fill = "gray"))

# You can also save plots to a file
ggsave("mpg_plot_example.png", p1)

## Exercise ####

# Run ?datasets and run the command to get the complete list of datasets in the "Details" section.


# Click `Index` at the bottom of the ?datasets help page and choose click on one of the hyperlinks at random. 
# You will see a description of the dataset and an example at the bottom. 
# Copy and paste the example into your console and see the output.



# `iris` is one of the datasets from the `datasets` package.
# GGally::ggpairs(iris) is an attempt to improve upon graphics::pairs(iris) using ggplot2.
# Install the package "GGally" from CRAN, load the package and run ggpairs(iris) and compare to pairs(iris)



# Using ggplot2, create a scatterplot of the iris dataset with Sepal.Length on the x axis, and Sepal.Width on the y axis



# Color the points by Species



# Change the color of all of the points to "red"



