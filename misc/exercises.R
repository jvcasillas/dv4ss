# -----------------------------------------------------------------------------
#
# Data visualization workshop
# Last update: 20241101
# Author: Joseph V. Casillas
#
# -----------------------------------------------------------------------------

# Install tidyverse if necessary
if(!require("tidyverse")){
  install.packages("tidyverse")
  library("tidyverse")
}

# Ex: load-data
link <- url("https://github.com/jvcasillas/dv4ss/raw/main/misc/new_data.RDS")
new_data <- readRDS(link)


# Ex: explore1
head(new_data) # show first 6 rows

# Ex: explore2
summary(new_data) # get general summary

# What kind of information did you learn about the dataframe?




#
# Aesthetics (aes())
#
# - Aesthetic mappings: how we map data to color, size, and **axis**...
# - Let's update our template

# Ex: aes-ex
ggplot(
  data = new_data, 
  mapping = aes(x = proficiency, y = score)
) 


#
# Geometric objects (geom_\*) {.smaller}
#

# Ex: p-geom-ex
ggplot(
  data = new_data, 
  mapping = aes(x = proficiency, y = score)
) + 
  geom_point()

# There are many types of geoms...
# - geom_point()
# - geom_smooth()
# - geom_hist()
# - geom_bar()
# - geom_boxplot()
# - etc. 


#
# Statistical transformations (stat_\*)
#
# - `stat_summary()` will calculate a value (e.g., mean, median) and overlay it

# Ex: p-stat-sum-ex
ggplot(
  data = new_data, 
  mapping = aes(x = group, y = score)
) + 
  stat_summary(
    fun.data = mean_sdl, 
    geom = 'pointrange'
  )


#
# Walkthrough with [ggplot2
#

# Let's revist some basic plots
#
# - Histogram
# - Scatterplots
# - Boxplots
# - Point estimate + spread

#
# Histogram
#

## Beginner
# Ex: p-histogram-ex-beg
# Continuous variable on the x-axis
ggplot(
  data = new_data, 
  mapping = aes(x = score)
) + 
  geom_histogram() 

## Intermediate
# Ex: p-histogram-ex-int
# Streamline code and adjust options
ggplot(new_data) + 
  aes(x = score) + 
  geom_histogram(
    color = "black", 
    fill = "grey70", 
    bins = 9
  ) + 
  theme_bw(
    base_size = 12, 
    base_family = "Palatino"
  )

#
# Scatterplot
# 

## Beginner
# Ex: p-scatterplot-ex-beg
# Continuous variables on both axis
ggplot(
  data = new_data, 
  mapping = aes(x = proficiency, y = score)
) + 
  geom_point() 

## Intermediate
# Ex: p-scatterplot-ex-int
# Include aesthetic mapping from inside geom_point()
ggplot(new_data) + 
  aes(x = proficiency, y = score) + 
  geom_point(aes(color = group), size = 4) + 
  theme_minimal(
    base_size = 12, 
    base_family = "Palatino"
  ) + 
  theme(
    legend.position = "inside", 
    legend.position.inside = c(.15, .85)
  )

#
# Boxplot (box and whisker plot)
#

## Beginner
# Ex: p-boxplot-ex-beg
# Try a different geom
ggplot(
  data = new_data, 
  mapping = aes(x = group, y = score)
) + 
  geom_boxplot() 


## Intermediate
# Ex: p-boxplot-ex-int
# Adjust colors, new theme
ggplot(new_data) + 
  aes(x = group, y = score, fill = group) + 
  geom_boxplot() + 
  scale_fill_viridis_d(option = "C", end = 0.85) + 
  theme_classic(base_size = 12) + 
  theme(
    legend.position = "inside", 
    legend.position.inside = c(0.8, 0.85)
  )

## Advanced
# Ex: p-boxplot-ex-adv
# Overlay raw data
ggplot(new_data) + 
  aes(x = group, y = score) + 
  geom_boxplot(aes(fill = group), show.legend = F) + 
  geom_jitter(
    height = 0, width = 0.2, 
    size = 4, alpha = 0.4
  ) + 
  scale_fill_viridis_d(
    name = NULL, 
    begin = 0.3, end = 0.8
  ) + 
  labs(x = NULL) + 
  theme_classic(base_size = 12, base_family = "Palatino")




#
# A better way... point estimate + spread
#  

## Beginner
# Ex: p-point-estimate-spread-ex-beg
# Point estimate can be mean, median, mode, 
# Spread can be SD, SE, 95% CI, etc.
ggplot(
  data = new_data, 
  mapping = aes(x = group, y = score) 
) + 
  stat_summary(
    fun.data = mean_sdl, 
    geom = 'pointrange', 
    size = 1, 
    linewidth = 1
  ) 


## Intermediate
# Ex: p-point-estimate-spread-ex-int
# Customize, add caption
ggplot(new_data) + 
  aes(x = group, y = score) + 
  geom_point(alpha = 0.3, size = 4) + 
  stat_summary(
    fun.data = mean_cl_boot, 
    geom = 'pointrange', 
    size = 1, 
    linewidth = 1
  ) + 
  labs(caption = "Mean ±95% CI") + 
  theme_minimal(base_size = 12)

## Advanced
# Ex: p-point-estimate-spread-ex-adv
# Customize points and gridlines, add jitter
ggplot(new_data) + 
  aes(x = group, y = score) + 
  geom_jitter(
    height = 0, width = 0.2, 
    alpha = 0.3, size = 3
  ) + 
  stat_summary(
    aes(fill = group), 
    fun.data = mean_se, 
    geom = 'pointrange', 
    size = 1, linewidth = 1, 
    pch = 21, show.legend = F
  ) + 
  labs(y = "Score", x = NULL, caption = "Mean ±SE") + 
  scale_fill_viridis_d(
    option = "A", begin = 0.3, end = 0.7
  ) + 
  theme_minimal(
    base_size = 12, base_family = "Palatino"
  ) + 
  theme(
    axis.title.y = element_text(size = rel(0.9), hjust = 0.95),
    axis.title.x = element_text(size = rel(0.9), hjust = 0.95),
    panel.grid.major = element_line(color = 'grey80', linewidth = 0.15),
    panel.grid.minor = element_line(color = 'grey80', linewidth = 0.15)
  )



#
# Faceting
#
# - What about when we want to see more factors at once?
# - For example, what if we want to see **score** as a function of **proficiency** and **age**?
# - We use `facet_wrap()` or `facet_grid()` to create facets

# Ex: p-shapes-ex1
ggplot(
  data = new_data, 
  mapping = aes(x = proficiency, y = score)
) + 
  facet_grid(. ~ age) + 
  geom_point()

# Ex: p-shapes-ex2
ggplot(
  data = new_data, 
  mapping = aes(
    x = age, y = score
  )
) + 
  facet_grid(group ~ .) + 
  geom_boxplot()


#
# More exercises 
# 
# Using `new_data`, create the following
# - a boxplot with a variable mapped to the `fill` aesthetic
# - a boxplot with a variable mapped to the `color` aesthetic and a 
#   horizontal facet
# - a scatterplot with a regression line (see `?geom_smooth`)
# - a scatterplot with a regression line (see `?geom_smooth`) and a 
#   categorical factor (try the aesthetic `shape`)
# - a histogram of `proficiency`
# - What does `geom_violin()` do? What geom can it replace?
