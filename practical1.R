# Loading ggplot2: enhanced graphics with Grammar of Graphics
library(ggplot2)

#Installing jrGgplot2 (for the Beauty dataset)
install.packages("drat")
drat::addRepo("jr-packages")
install.packages("jrGgplot2", dependencies=TRUE)

library(jrGgplot2)
data(Beauty, package = "jrGgplot2")

#This data set is from a study where researchers were interested in
#whether a lecturers’ attractiveness affected their course evaluation.

g = ggplot(data=Beauty)
head(Beauty)
colnames(Beauty)
dim(Beauty)

# ggplot objects:
# ARGUMENTTS: data (only data.frame, njot vectors or lists),  aesthetics

# SCATTER PLOTS ----

g1 = g + geom_point(aes(x=age, y=beauty))
g1

g + geom_point(aes(x=age, y=beauty, colour=gender))

g + geom_point(aes(x=age,
                   y=beauty,
                   alpha=evaluation, # coulour transparency based on evaluation value
                   colour=gender)) # colour based on gender

g + geom_point(aes(x=age,
                   y=beauty,
                   shape=factor(tenured),
                   # shape based on tenured value (it was a continue one, so it need to be discretized by the factor function)
                   colour=gender)) # colour based on gender

g + geom_point(aes(x=age,
                   y=beauty,
                   colour="blue")) # THIS DOES NOT WORK: blue appears as a key label

g + geom_point(aes(x=age,
               y=beauty),
               colour="blue") # THIS WORKS: all point blue

g + geom_point(aes(x=age,
                   y=beauty,
                   colour=4)) # THIS DOES NOT WORK WELL
g + geom_point(aes(x=age,
                   y=beauty),
               colour=6) # all point have the colour with code 6 (pink)

# BOX PLOTS ----

# aes: x, y , colour, fill, linetype, weight, size, alpha
g + geom_boxplot(aes(x=gender,
                     y=beauty))

g + geom_boxplot(aes(x=gender,
                     y=beauty,
                     colour=factor(tenured)))

g + geom_boxplot(aes(x=gender,
                     y=beauty,
                     shape=factor(tenured)))

# COMBINIG PLOTS ----

#Layering!
g + geom_boxplot(aes(x=gender,
                     y=beauty,
                     colour=factor(tenured))) +
  geom_point(aes(x=gender, y=beauty))

g + geom_point(aes(x=gender, y=beauty)) +
  geom_boxplot(aes(x=gender,
                   y=beauty,
                   colour=factor(tenured))) # different layers order giving the same outcome

g + geom_point(aes(x=gender, y=beauty)) +
  geom_boxplot(aes(x=gender,
                   y=beauty,
                   colour=tenured)) # DOES NOT WORK WITHOUT THE FACTOR FUNCTION

#The jitter geom is a convenient shortcut for geom_point(position = "jitter").
#It adds a small amount of random variation to the location of each point,
#and is a useful way of handling overplotting caused by discreteness in smaller datasets.
g + geom_jitter(aes(x=gender, y=beauty)) + # geom_jitter 
  geom_boxplot(aes(x=gender,
                   y=beauty,
                   colour=factor(tenured))) # different order giving the same outcome

# BAR PLOTS ----

#aes: x, colour, fill, size, linetype, weight, alpha
g + geom_bar(aes(x=factor(tenured)))

g + geom_bar(aes(x=factor(tenured),  colour=gender))

g + geom_bar(aes(x=factor(tenured),  fill=gender))

g + geom_bar(aes(x=factor(tenured),  fill=factor(minority))) # minority also needs to be discretized with FACTOR function

# Let`s round ages to the neaest decade`
Beauty$dec = factor(signif(Beauty$age, 1)) # 1 significant digit for rounding
head(Beauty)

g = ggplot(data=Beauty)
g + geom_bar(aes(x=gender, fill=dec))

# Adjusting the layout of the bar plot
g + geom_bar(aes(x=gender, fill=dec),
             position="stack")

g + geom_bar(aes(x=gender, fill=dec),
             position="dodge")

g + geom_bar(aes(x=gender, fill=dec),
             position="fill")

g + geom_bar(aes(x=gender, fill=dec),
             position="identify")

g + geom_bar(aes(x=gender, fill=dec),
             position="jitter")
