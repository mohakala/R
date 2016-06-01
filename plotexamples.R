l1 <- c(161,186,222,308,384,401)
l2 <- c(72,78,89,137,146,180)
l3 <- c(60,66,77,82,107,125)
l4 <- c(49,60,72,83, 89, 102)

ll1 <- l1/l1[1]
ll2 <- l2/l2[1]
ll3 <- l3/l3[1]
ll4 <- l4/l4[1]

vuosi <- 2011:2016

plot(vuosi,l1,ylim=c(0,410))
points(vuosi,l2,col=2)
points(vuosi,l3,col=3)
points(vuosi,l4,col=4)

df <- data.frame(vuosi,ll1,ll2,ll3,ll4)
summary(df)


# Go to ggplot
# http://stackoverflow.com/questions/2564258/plot-two-graphs-in-same-plot-in-r

require(ggplot2)

# | One way to plot 
# http://stackoverflow.com/questions/8592585/combine-points-with-lines-with-ggplot2
require(reshape2)
dat <- melt(df,id.vars="vuosi")
ggplot(aes(x = vuosi, y = value, color = variable), data = dat) + geom_point() + geom_line()


# | Another way to plot
g <- ggplot(df, aes(vuosi))
g <- g + geom_point(aes(y=ll1), colour="red")
g <- g + geom_point(aes(y=ll2), colour="green")
g <- g + geom_point(aes(y=ll3), colour="blue")
g <- g + geom_point(aes(y=ll4), colour="black")
g <- g + geom_line(aes(y=ll1), colour="red")
g <- g + ylab("suhteellinen muutos")
g


