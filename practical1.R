library(ggplot2)

#Installing jrGgplot2 (for the Beauty dataset)
install.packages("drat")
drat::addRepo("jr-packages")
install.packages("jrGgplot2", dependencies=TRUE)

library(jrGgplot2)
data(Beauty, package = "jrGgplot2")
