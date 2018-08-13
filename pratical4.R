
data(movies, package = "ggplot2movies")

# AXIS SCALES ----

# Canvas and limits

g = ggplot(subset(movies, budget>0), aes(y=length)) +
  ylim(0,500)

g + geom_point(aes(x=budget), alpha=0.2)

g + geom_point(aes(x=log10(budget)), alpha=0.2)

g + geom_point(aes(x=budget), alpha=0.2) + scale_x_log10()

g + geom_point(aes(x=budget), alpha=0.2) + scale_y_log10()

g + geom_point(aes(x=budget), alpha=0.2) + scale_x_log10() + scale_y_log10()

g + geom_point(aes(x=budget), alpha=0.2) + scale_alpha_continuous()

g + geom_point(aes(x=budget), alpha=0.2) +
  scale_x_log10() +
  scale_y_continuous(breaks=seq(0,500,100),
                     minor_breaks = seq(0,500,25),
                     limits=c(0,500),
                     labels = c(0, "", "", "", "", 500),
                     name = "Movie Length")

# Pallettes of colours ----

data(bond, package="jrGgplot2")
(g=ggplot(data=bond, aes(x=Alcohol_Units, y=Kills)) +
    geom_point(aes(colour=Actor)))

g + scale_colour_grey()

g + scale_colour_viridis_d() #colorblind friendly

g + scale_colour_brewer(palette = "PuOr", type = "div")

# Colours for amusement rather than clarity
g + scale_colour_manual(values = c(
  "Brosnan" = rgb(192,192,192, maxColorValue = 255), #silver
  "Connery" = "Gold",
  "Craig" = rgb(205, 127, 50, maxColorValue = 255), #Bronze
  "Dalton" = "tomato1",
  "Lazenby" = "tomato2",
  "Moore" = "tomato3"))

# Websites: colorbrewer2.org
#           IwantHue.com ?

# MULTIPLE PLOTS ----

# usual command for multiple graphs at the same page:
par(mfrow=c(2,2))

# using ggplot2:
library("grid")
vplayout = function(x, y)
  viewport(layout.pos.row = x, layout.pos.col = y)

grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 2)))

print(g1, vp = vplayout(1, 1:2))
print(g2, vp = vplayout(2, 1))
print(g3, vp = vplayout(2, 2))

library("gridExtra")
grid.arrange(g1, g2, g3, g4, nrow=2)


