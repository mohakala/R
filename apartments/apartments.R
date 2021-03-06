#A Get the data
#B Exploratory analysis 
#C Data munging 
#D Random Forest

# Links
# http://stackoverflow.com/questions/17479632/random-forests-does-it-make-any-difference-if-the-test-set-is-also-labeled
# http://nthturn.com/2015/02/22/prediction-using-random-forests-in-r-an-example/
# http://trevorstephens.com/post/73770963794/titanic-getting-started-with-r-part-5-random
# http://www.r-bloggers.com/part-4a-modelling-predicting-the-amount-of-rain/
  

#A Get the data

df <- read.csv("C:\\Python34/datasets/nurmijarvi_asunnot_250316.csv")
#View(df)

#B Exploratory analysis 
summary(df)

#C Data munging 
# http://stackoverflow.com/questions/12763890/exclude-blank-and-na-in-r
df[df==""] <- NA
sapply(df,function(x) sum(is.na(x)))

df$Kunto <- NULL
df$Huoneisto <- NULL
df$Krs <- NULL
df$X <- NULL

# Omit rows with NA values
df <- na.omit(df)

plot(df$Rv,df$Neliohinta)

# Prepare train and test sets
train <- df[c(1:250),]
test <- df[c(251:309),-3]  # remove Talotiedot
test2 <- df[c(309:309),-3]  # remove Talotiedot

#D Random Forest

library(randomForest)
my_formula <- factor(df$Talotiedot) ~ df$Kaupunginosa + df$Huoneet + df$m2 + df$Vh + df$Neliohinta + df$Rv + df$Hissi 
my_forest <- randomForest(my_formula, data = df, ntree = 400, mtry = 3, importance = TRUE )
my_forest
varImpPlot(my_forest)


#E Predictions

r <- randomForest(Talotiedot ~., data=train, importance=TRUE, do.trace=100)
predict(r, test)
predict(r, test2)

# Create own test set
# http://www.dummies.com/how-to/content/how-to-create-a-data-frame-from-scratch-in-r.html
Kaupunginosa=c('Klaukkala','KirkonkylÃ¤')
Huoneet=c(3,3)
m2=c(86,92)
Vh=c(170000,180000)
Neliohinta=c(2000,2100)
Rv=c(1986,1991)
Hissi=c('ei','on')
testdf=data.frame(Kaupunginosa,Huoneet,m2,Vh,Neliohinta,Rv,Hissi)
levels(testdf$Kaupunginosa) <- levels(train$Kaupunginosa)  # Same levels must be found in test and train
testdf[, c(2,4:6)] <- sapply(testdf[, c(2,4:6)], as.integer) # Needed to change type to int
str(testdf)
#

print(predict(r, testdf))





                
