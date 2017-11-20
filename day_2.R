getwd()
ino <- read.table("C:/Silvan/Silvan/Uni Wü Master/MB2_R/bio_data_forest.csv")
read.csv("C:/Silvan/Silvan/Uni Wü Master/MB2_R/bio_data_forest.csv")
summary(ino)
plot(ino)

X <- matrix(c(4,7,3,8,9,2),nrow=2) #or ncol
X
X[2,2]
X[,2]

X[1,1]
numbers_1 <- rnorm(80,mean=0,sd=1)
mat_1 <- matrix(numbers_1,nrow=20,ncol=4)
mat_1
df_1 <- data.frame(mat_1)
names(df_1) <- c("var1","var_2","var3","var")
head(df_1)
names(df_1)
df_1[,1]
df_1[1,]
df_1$var1
df_1$var1[1:3]
df_1[3:4,]
df_1[2:3,3:4]

X <- seq(1,100,by=2.5)
X
X[5]
X[4:10]
X[length(X)]
X[length(X)-1]
X[-2]
X>2
(X <= 10)|(X>=30)
X[X<10 | X>30]

idx <- c(1,4,6)
X[idx]
X[-idx]

X2 <- numeric(length(X))
X2
X2[X<=30] <- 1
X2[(X>30)&(X<70)] <- 2
X2[X>70] <- 3
X2

install.packages("car")
library(car)
X2 <- recode(X, "0:30=1;30:70=2;else=3")
X2

summary(X)
sum(X)
cumsum(X)

rev(X) #revert order
sort(X, decreasing=TRUE) #same
sample(X,10) #sample 10 values out of X

test <- data.frame(A=c(1,2,3),B=c("aB1","aB2","aB3"))
test
test[,1] # first col
test[,"A"] #first col, referred to as A
test$A #same
test$B #second col

df_1 <- data.frame(plot="location_name_1", measure1=runif(100)*1000, measure2=round(runif(100)*100),value=rnorm(100,2,1),ID=rep(LETTERS,100))
df_1
df_2 <- data.frame(plot="location_name_2",measure1=runif(50)*100, measure2=round(runif(50)*10),value=rnorm(50),ID=rep(LETTERS,50))
df_2 
df <- rbind(df_1,df_2)
df
q <- length(df[,1])
q
a <- df[,c('measure1','measure2')]
a
plot(a)

b <- df[,c('value','measure1')]
b
plot(b)
boxplot(b)
hist(b$value)
hist(b$measure1)

summary(df)
str(df)
mode(df)
head(df)
df[df$value>3.0 & df$measure1>50,]
df$new_col<- df$measure1 * df$measure2
df$new_col
prec_avg[7]

##############################

difftime(("2017-12-15"),Sys.Date(),units="mins")
library(raster)
germany <- getData("GADM",country="DEU",level=2)
plot(germany)
prec <- getData("worldclim",var="prec",res=.5,lon=10, lat=51)

plot(prec)
prec_ger1 <- crop(prec, germany)
plot(prec_ger1) #das geht auch!
spplot(prec_ger1)
prec_ger2 <- mask(prec_ger1,germany, inverse=TRUE)
spplot(prec_ger2)

file <- read.csv(file.choose(),header=TRUE)
file
