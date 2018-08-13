
# THEMES ----

data(bond, package="jrGgplot2")
(g=ggplot(data=bond, aes(x=Alcohol_Units, y=Kills)) +
    geom_point(aes(colour=Actor)))

g + theme_bw()
g + theme_dark()
g + theme_void()
# etc, etc

# there are  severeal predef themes, but we can use the minimal theme to build our own

g + theme_minimal()

my_theme = theme_minimal()
my_theme$panel.grid.minor$colour = "red"
g + my_theme

# A goof one:

library(hrbrthemes)

g +
  scale_color_ipsum() +
  theme_ipsum_rc()

# great theme!!