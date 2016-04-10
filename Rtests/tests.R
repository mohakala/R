####### Thursday

#comment
# [1]  402 ... [1] means the first vector
runif(100) # random numbers
x <- c(6.7, 9.6, -100000)
y <- c(1,2,3,4,5,6)
z <- -c(2,2,2,2,2)
x+y # note: R recycles the vectors in the calculation if needed

week1 <- c(1133, 2097, 2211, 2592, 2370, 1926, 941)
week2 <- c(2811, 2670, 2879, 2543, 1845, 1227, 1128)
both <- week1 + week2
increase <- week2 - week1
length(week1)
sum(week1)
summary(week1) # this is also a vector
somemissing <- c(1,2,NA,10)
length(somemissing)
mean(somemissing,na.rm=TRUE)

friday <- week1[5]
sum(week1[c(1,4,5)]) # is used to pick the 1.,4.,5.:th elements

over2k <- week1 > 2000
xxyyzz=19.9
rm(xxyyzz) # remove variable

daynames <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday","Sunday")
names(week1) <- daynames
names(week2) <- daynames
week1["Friday"]
names(week1)

# Activity 3
prop=c(0,0)
prop[1]=sum(week1[6:7])/sum(week1)
prop[2]=sum(week2[6:7])/sum(week2)
totalave=sum(week1+week2)/14
allweeks <- c(week1,week2)
allweeks > totalave

length(allweeks[allweeks > totalave])
names(allweeks[allweeks > totalave])

#names(week3) <- daynames

avg1 <- mean(week1)
week1.overarvg <- week1[week1>avg1]
length(week1.overarvg)  # Note: True=1, False=0 ???
# another way
sum(week1>avg1)


which.max(week1)

mean(c(week1,week2))

as.numeric(week1 > avg1)
week1>avg1
sum(week1>avg1)

# Moving to next example: Dataframes

data(iris)
summary(iris)
iris$Sepal.Length
iris$Species   # These are factors! Not character vectors.

#test1 <- iris$Species
test1 <- iris$Sepal.Length
print(iris[1:10,1:3])
print(iris[4,])   # row 4, all columns

# Activity 4
data("ToothGrowth")
?ToothGrowth
#View(ToothGrowth)
is(ToothGrowth)
is(ToothGrowth$len)

df <- ToothGrowth
summary(df)

# Summarize the properties of a subgroup
# Use subset command
tootoj0.5 <- subset(df,supp=='OJ' & dose==0.5) 
summary(subset(df,supp=='OJ' & dose==0.5))

# Alternative for filtering
library(dplyr)
tootoj0.5f <- filter(df,supp=="OJ",dose==0.5) 

## Tehdään uusi faktorikolumni
#df$newfactor <- factor(df$dose)
#levels(df$newfactor)

# How to know the types of the df? Simply do summary(df)
is.numeric(df$len)
is.factor(df$len)
is(df$supp)

# Tehdään uusi faktorikolumni
df$newfactor2 <- as.factor(df$dose)
levels(df$newfactor)

aggregate(len~supp+newfactor2,df,mean)

# Coffee break
# Final part of Thursday
trainTitanic <- read.csv("//atkk/home/m/mohakala/Documents/RandomForest/trainTitanic.csv")
#View(trainTitanic)

#weatherkumpula <- read.csv("C:\\Users\\mohakala\\AppData\\Local\\Temp\\RtmpohWtxC\\data251830aa82b")
#weatherkumpula <- read.csv("C:\\ATKK\\home\\m\\mohakala\\Documents\\RcourseApril2016\\weather-kumpula.csv")
weatherkumpula <- read.csv("RcourseApril2016\\weather-kumpula.csv")
#View(weatherkumpula)
df <- weatherkumpula

library(dplyr)
#df <- mutate(df,newvar=rmm+wdir)
#df2 <- trans  (df,newvar=rmm+wdir)

## complete.cases() tällä testataan mitkä rivit täydellisiä


####### Friday

# How help pages work
?read.csv
example(read.csv)
test1 <- c(1:5, "6,7", "8,9,10")

# Activity 5 create a Lotto

# 5.1 Create a lotto row
sample(1:39,7)
# also works as sample(39,7)

# 5.2 Toss a coin
# Version 1
sample(0:1,1)
i <- 0
tossed <- 0
while (i<11) {
  i <- i+1
  val <- sample(0:1,1)
  tossed[i] <- val 
    print(val)
}
# Version 2, better version
sample(0:1,10,replace=TRUE)


# 5.3 Select random subsample of size 20 from iris
nrows <- nrow(iris)
randlist <- sample(1:nrows,20)
irissample <- iris[randlist,]
# Other version
iris$rand <- sample(nrows)
irissample2 <- subset(iris,rand<21)


# 5.4 Optional activity
SL <- iris$Sepal.Length
SL5=SL[1:5]
mean(SL5)
mean(iris$Sepal.Length[1:5])

# 4 Basic data analysis
# 4.1 plot() function
plot(iris$Species)
plot(iris$Sepal.Length,iris$Sepal.Width)
# formulas always describe some kind of structure
# Tilde --> means there is a formula
plot(Sepal.Width~Sepal.Length,iris)
plot(Sepal.Width~Sepal.Length,iris,subset=Species=="setosa")
plot(Sepal.Width~Species,iris)
?boxplot
#example(pch)

# 4.4 Package ggplot2
library(ggplot2)
ggplot(iris,aes(Sepal.Length,Sepal.Width))+geom_point()
ggplot(subset(iris,Species=="setosa"),aes(Sepal.Length,Sepal.Width))+geom_point()
ggplot(iris,aes(Sepal.Length,Sepal.Width))+geom_point(aes(color=Species))
# ggplot works with only one dataframe at a time 

plot(Sepal.Width~Sepal.Length,iris,subset=Species=="setosa",xlim=c(3,6))

# lista == järjestetty kokoelma mitä tahansa


# 4.6 Fitting linear models
plot(Sepal.Width~Sepal.Length,iris)
fit <- lm(Sepal.Width~Sepal.Length,iris)
abline(fit)
summary(fit)

plot(Sepal.Width~Species,iris)
fit2 <- lm(Sepal.Width~Species,iris)
summary(fit2)
anova(fit2)

ggplot(iris,aes(Sepal.Length,Sepal.Width))+geom_point()+stat_smooth(method="lm")

t.test(Sepal.Width~Species, data=iris, subset=Species!="setosa")


# Activity 8
# How air pressure affects T? 
# Is it different in winter and summer times?

# Weather all months
plot(t~p,weatherkumpula)
fit <- lm(t~p,weatherkumpula)
abline(fit)
summary(fit)

# Weather talvi
talvi <- subset(weatherkumpula, (month > 10 | month < 4))
plot(t~p,talvi,main='talvi')
fittalvi <- lm(t~p,talvi)
abline(fittalvi)
ggplot(talvi,aes(p,t))+geom_point()+stat_smooth(method="lm")

# Weather kesä
kesa <- subset(weatherkumpula, (month < 9 & month > 5))
plot(t~p,kesa,main='kesa')
fitkesa <- lm(t~p,kesa)
abline(fitkesa)

## test a function
x <- 3.0
y <- myfunction(x)
print(y)

# study merging
df1 <- data.frame(CustomerId = c(1:6), Product = c(rep("Toaster", 3), rep("Radio", 3)))
df2 <- data.frame(CustomerId = c(2, 4, 6), State = c(rep("Alabama", 2), rep("Ohio", 1)))

# Inner
dfnew <- merge(x = df1, y = df2, by = "CustomerId")
print(dfnew)
# Outer
dfnew <- merge(x = df1, y = df2, by = "CustomerId", all = TRUE)
print(dfnew)
# Left
dfnew <- merge(x = df1, y = df2, by = "CustomerId", all.x = TRUE)
print(dfnew)
# Right
dfnew <-  merge(x = df1, y = df2, by = "CustomerId", all.y = TRUE)
print(dfnew)
# Cross join 
dfnew <- merge(x = df1, y = df2, by = NULL)
print(dfnew)


# Study datasets 
# http://www.statmethods.net/advstats/timeseries.html
data(AirPassengers)
myts <- AirPassengers
plot(myts)

# Seasonal decomposition
fit <- stl(myts, s.window="period")
plot(fit)

# additional plots
monthplot(myts)
library(forecast)
seasonplot(myts) 

# simple exponential - models level
fit <- HoltWinters(myts, beta=FALSE, gamma=FALSE)
plot(fit)
# double exponential - models level and trend
fit <- HoltWinters(myts, gamma=FALSE)
plot(fit)
# triple exponential - models level, trend, and seasonal components
fit <- HoltWinters(myts)
plot(fit)

# predictive accuracy
accuracy(fit)

# predict next three future values
forecast(fit, 3)
plot(forecast(fit, 3)) 


## ARIMA
# fit an ARIMA model of order P, D, Q
#fit <- arima(myts, order=c(p, d, q))
             
# predictive accuracy
#library(forecast)
#accuracy(fit)
             
# predict next 5 observations
#forecast(fit, 5)
#plot(forecast(fit, 5)) 


## Automated forecasting

# Automated forecasting using an exponential model
fit <- ets(myts)
accuracy(fit)
forecast(fit, 5)
plot(forecast(fit, 5)) 
plot(forecast(fit, 5),xlim=c(1960,1962))

# Automated forecasting using an ARIMA model
fit <- auto.arima(myts)
accuracy(fit)
forecast(fit, 5)
plot(forecast(fit, 5)) 
plot(forecast(fit, 5),xlim=c(1960,1962))

# More timeseries, by Seija
# google: R help convert time series to data.frame
data(Nile)
summary(Nile)
is(Nile)
tmp <- as.numeric(Nile)
tmp
time(Nile)
Niledf <- data.frame(year=time(Nile),flow=as.numeric(Nile))
summary(Niledf)
?Nile

# JSON tests
library(rjson)
url2='http://avoindata.prh.fi:80/bis/v1?totalResults=false&maxResults=10&resultsFrom=0&companyRegistrationFrom=2014-02-28'
#jsontest <- fromJSON(readLines(url2))

# Print list in the list
jsontest[[8]][[1]]

# Print company from list in the list
jsontest[[8]][[1]][2]


# More, Seija 
data(ChickWeight)
painot <- do.call(rbind,by(data = ChickWeight,INDICES = ChickWeight$Chick,FUN=function(d)
  {
  with(d,data.frame(Chick=Chick[1],painoero=weight[which.max(Time)]-weight[which.min(Time)])) 
  }))
print(painot)























