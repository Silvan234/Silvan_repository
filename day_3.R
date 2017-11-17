my_table <- read.csv(file=file.choose(),header=T, sep=",")

my_table
head(my_table)
summary(my_table)

c<- rnorm(10)
c
table(cut(c, breaks=-2:2))

c <-c(2,3,5)
x
c
x <-c("aa","bb","cc","dd")
x
d <-c(c,x)
d

X <- seq(1,100,by=2.5)
library(car)
X2 <- recode(X,"0:30=1;31:70=2;else=3")
X2
summary(X)
sum(X)
cumsum(X)
rev(X)
sample(X,10)

m1 <- matrix(c(4,7,3,8,9,2),nrow=2)
m1
m2 <- matrix(
  c(2,4,3,1,5,7),
  nrow=2,
  ncol=3,
  byrow=F)
m2

numbers_1 <- rnorm(80,mean=0,sd=1)
mat_1 <- matrix(numbers_1,nrow=20,ncol=4)
mat_1
df_2

x1 <- rbinom(10,size=1,prob=0.5)
x1
x2 <- factor(x1,labels=c("man","woman"))
summary(x2)
levels(x2)
as.character(x2)

library(car)
recode(x2,"'woman'='woman'; 'man'='guy'")
x2

ifelse(x2=="man","guy","woman")

coplot() #for plotting with 3 variables

library(raster)
install.packages("raster")
install.packages("sp")
r1 <- raster(nrows=10, ncol=10)
r1
r1[] <- rnorm(100)
plot(r1)

library(sp)
poi1 <- cbind(c(rnorm(10)),c(rnorm(10)))
poi1
poi1.sp <- SpatialPoints(poi1)
plot(poi1.sp)

df <- data.frame(attr1=c("a","b","z","d","e","q","w","r","z","y"), atrr2=c(101:110))
df
poi1.spdf <- SpatialPointsDataFrame(poi1.sp,df)
plot(poi1.spdf)


install.packages("RStoolbox")
lsat
library(RStoolbox)
lsat[[1]]
plot(lsat[[1]])
x <- lsat[[2:3]]
x
plot(x)
qq <- x[x$B2_dn >18]
plot(qq)

install.packages("move")
library(move)
data(lsat) 
x <- lsat[1:10,]
x <- lsat []
x <- getValues(lsat)
x <- lsat[lsat == 10]

data(leroy)
env <- raster(leroy,vals=rnorm(100))
x <- extract(env, leroy)
x

lsat[] <- rnorm(ncell(lsat))
lsat[]
lsat [lsat < 0] <- NA
lsat[]

env[] <- 0
env[]
env[leroy] <- 1
env[leroy]
