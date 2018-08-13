# Refer the installation and loading steps in practical1
library("jrGgplot2")
library("ggplot2")

#Data from James Bond movies!
data(bond, package = "jrGgplot2")
library("ggplot2")

head(bond)

g = ggplot(data=bond, mapping = aes(x=Kills, y=Alcohol_Units))
g # grey box: we did not added any layers to this plot

# Note the following is the same as the above couple of lines:
g = ggplot(bond, aes(x=Kills, y=Alcohol_Units))
g

#Several geom types:
#ggplot2.tidyverse.org/reference/

# Each with its own aesthetics options
# Ex. error-bar geom needs ymax and ymin

# COMBINIG GEOMS ----

(g = ggplot(bond, aes(x=Actor, y=Alcohol_Units)))
# with parenthsis, you run the defined variable g (you dont have to run g in the next line)
(g1 = g + geom_boxplot())

#OR

ggplot() +
  geom_boxplot(data=bond, aes(x=Actor, y=Alcohol_Units)) # we need the data arg here, sinc we didnt gave it before

# Violin plot
# Kernel density plot (similar to boxplot but with a density deistribution to draw its  lateral contour)
# -> used by data scientists, rather then statiticians :P

g + geom_violin()

g + geom_violin() +
  geom_boxplot()

g + geom_violin() +
  geom_boxplot() +
  geom_point()

g + geom_boxplot(aes(fill=Actor))

g + geom_boxplot(aes(group=Actor))
# The group attribute:

g + geom_boxplot(aes(colour=Actor))

g + geom_boxplot(aes(colour=Actor, weight=Kills))
# The weight attribute:

ggplot(bond) + geom_bar(aes(x=Actor)) + coord_flip() # flip x and y axis

ggplot(bond, aes(Kills, Alcohol_Units)) + geom_point() + geom_text(aes(label=Actor)) # add text labels to points

install.packages("ggrepel") # better text labeling for points
library(ggrepel)
ggplot(bond, aes(Kills, Alcohol_Units)) + geom_point() +
  geom_text_repel(data=bond[bond$Actor=="Connery",], aes(label=Actor), colour="blue") # add text labels only to the "Connery" points

#OR

# not very good option to use subset
ggplot(bond, aes(Kills, Alcohol_Units)) + geom_point() +
  #p.s.: if you use geom_jitter, rahter then geom_point, mix a bit the positions so you can see better large sets of data
  geom_text_repel(data=subset(bond, Actor=="Connery",), aes(label=Actor), colour="blue") # add text labels only to the "Connery" points


# AESTHETICS ----

d = data.frame(x=1:50, y=1:50, z=0:9)
head(d)
tail(d)

g = ggplot(d, aes(x,y))

g +  geom_point()
g +  geom_point(aes(colour=z)) # the colors of the points is changing conditionally with the z value
g +  geom_point(aes(colour=as.character(z))) # discrete palette choice
g +  geom_point(aes(colour=factor(z))) # discrete palette choice

#################

# When I was at the Bank: ----

# stat_ function
ggplot(bond, aes(Alcohol_Units, Kills)) + 
  geom_point() + 
  stat_smooth(se = FALSE)

# Exercise
# change method = "lm"
ggplot(bond, aes(Alcohol_Units, Kills)) + 
  geom_point() +
  stat_smooth(method = "lm", se = FALSE) # lm -> linear model

# use colour within aes of stat_smooth
ggplot(bond, aes(Alcohol_Units, Kills)) + 
  geom_point(aes(colour = Nationality)) +
  stat_smooth(aes(colour = Nationality), se = FALSE) #draws a regression line for each nationality

# use colour within aes of stat_smooth; using method = "lm"
ggplot(bond, aes(Alcohol_Units, Kills)) + 
  geom_point(aes(colour = Nationality)) +
  stat_smooth(aes(colour = Nationality), method = "lm", se = FALSE) #draws a regression line for each nationality

#stat_summary()
ggplot(bond, aes(Actor, Alcohol_Units)) + 
  stat_summary(geom = "bar", fun.y = mean, fill = "cyan")

ggplot(bond, aes(Actor, Alcohol_Units)) + 
  stat_summary(geom = "point", fun.y = mean, fill = "cyan")

#using custom defined functions
std_err = function(i)
  dt(0.975, length(i) - 1) * sd(i) / sqrt(length(i))

ggplot(bond, aes(Actor, Alcohol_Units)) + ylim(c(0,20)) +
  stat_summary(fun.ymin = function(i) mean(i) - std_err(i),
               fun.ymax = function(i) mean(i) + std_err(i),
               colour = "steelblue", geom = "errorbar", 
               width = 0.2, lwd = 1)


