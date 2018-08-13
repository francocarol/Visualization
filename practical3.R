
# FACETS ----

# IMDB Database

data(movies, package="ggplot2movies")
colnames(movies)

max(movies$length)
which.max(movies$length)

#Ex.: Longest movie in the list
movies[which.max(movies$length),]
movies[which.max(movies$length),]$title

(g = ggplot(movies, aes(x=length)) + xlim(0,200) +
    geom_histogram(aes(y=..density..), binwidth=3)) # DENSITY PLOT: the area under the curve sums up to 1. y is the calculated density. 
# It only changes the y scale, compared to a normal histogram, that would show actual counts (number of movies)

g + facet_grid(Comedy ~ .) # separates by comedy and non-comedy

g + facet_grid(. ~ Animation) # separates by non-animated and animated

g + facet_grid(Comedy ~ Animation) #
# left: right:
# up: down:

# Exercise: make the same plot as above, without facet
(g1 = ggplot(movies, aes(x=rating)) + xlim(0,10) +
    geom_histogram(aes(y=..density..), binwidth=0.1))

(g2 = ggplot(movies, aes(x=rating)) + xlim(0,10) +
    geom_density(binwidth=0.1))

g1 + facet_grid(. ~ mpaa)
g2 + facet_grid(. ~ mpaa)

g1 + geom_density() + facet_grid(. ~ mpaa) # overlapping both

# FACET WRAP ----

movies$decade = floor(movies$year/10) * 10
# /10 we have a decimal number,  floor() knocks out the decimal. Multiplying by 10 again, we have the movie decades

ggplot(movies, aes(x=length)) +
  geom_histogram() +
  xlim(0,200) +
  facet_wrap(~ decade, ncol=6)

# RIDGE PLOTS ----

#overlapping line plots that create the impression of a mountain range
#They can be quite useful for visualizing changes in 1 This doesn’t actually 
#fit that well into this distributions over time or space

library("ggridges")
ggplot(movies,
       aes(x = length, y = year,
           group = year, height = ..density..)) +
  geom_density_ridges(scale = 10, alpha = 0.7) +
  theme_ridges(grid=FALSE) +
  scale_x_log10(limits = c(1, 500),
                breaks = c(1, 10, 100, 1000),
                expand = c(0.01, 0)) +
  scale_y_reverse(breaks = seq(2000, 1900,by = -20),
                  expand = c(0.01, 0))


# OTHER STUFF: changing key labels and order

# way 1
data(mpg, package = "ggplot2")

mpg[mpg$drv == "4",]$drv = "4wd"
mpg[mpg$drv == "f",]$drv = "Front"
mpg[mpg$drv == "r",]$drv = "Rear"

g = ggplot(data=mpg, aes(x=displ, y=hwy)) +
  geom_point()

g + stat_smooth(aes(colour=drv))

#way 2
data(mpg, package="ggplot2")
mpg$drv = factor(mpg$drv, labels = c("4wd", "Front", "Rear"))
mpg$drv = factor(mpg$drv,
                 levels = c("Front", "Rear", "4wd"))
g = ggplot(data=mpg, aes(x=displ, y=hwy)) +
  geom_point()
g + stat_smooth(aes(colour=drv))

             