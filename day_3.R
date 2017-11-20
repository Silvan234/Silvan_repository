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
X
X[5]
X[4:10]
library(car)
X2 <- recode(X,"0:30=1;31:70=2;else=3")
X2
summary(X)
sum(X)
cumsum(X)
rev(X)
sample(X,10)

m1 <- matrix(c(4,7,3,8,9,2),nrow=2) #matrix with 6 values, 2 rows
m1
m2 <- matrix(
  c(2,4,3,1,5,7),
  nrow=2,
  ncol=3,
  byrow=T) #byrow=T = matrix filled by row, byrow=F = matrix filled by col
m2

m1[,2]#column 2
m1[2,]#row 2
m1[2,2] #col 2 row 2

numbers_1 <- rnorm(80,mean=0,sd=1)
numbers_1
mat_1 <- matrix(numbers_1,nrow=20,ncol=4)
mat_1

df_1 <- data.frame(mat_1)
df_1
names(df_1) <- c("var1","var2","var3","var4")
df_1 #now with var1, var2, var3 and var4

head(df_1)
summary(df_1)

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

summary(df)
str(df)
mode(df)
head(df)

df[,c('plot','measure1','measure2')]
df[66:115,c('plot','measure1','measure2')]
df[-1,c('plot','measure1','measure2')] #all but first value
df[1,c('plot','measure1','measure2')] #first value
df[66:70,c('plot','measure1','measure2')]

plot(df[,c('measure1','measure2')]) #plot of measure1 and measure2
plot(df[,c('measure1')]) #c is not necessary (works both ways)
boxplot(df[,c('measure1','measure2')])
hist(df[,('measure1')]) #histogram

df[df$value>3.0,]
df[df$value>3.2 | df$measure1>50,]
df[df$value>3.2 & df$measure1>50,]
df$new_col <- df$measure1*df$measure2
df$new_col

df[grep("a",df$ID, ignore.case = T),] # 'A' in ID
df[grep("a",df$ID, ignore.case = F),] #if FALSE, the pattern matching is case sensitive and if TRUE, case is ignored during matching

#further useful functions
ordered() #create an ordered group factor
rbinom() #create binominal values
# etc. siehe day3 p.44 (82)




library(raster)
germany <- getData("GADM",country="DEU",level=2)
plot(germany)
prec <- getData("worldclim",var="prec",res=.5,lon=10, lat=51)
plot(prec)
prec_ger1 <- crop(prec, germany)
plot(prec_ger1) #das geht auch!
spplot(prec_ger1) #so stehts im Script
prec_ger2 <- mask(prec_ger1,germany) #inverse=T führt zur Inversion
spplot(prec_ger2)

prec_avg <- cellStats(prec_ger2,stat="mean")
prec_avg
prec_avg[7]
plot(prec_avg[4:9])
prec_avg[2]-prec_avg[1]
sum(prec_avg)
cumsum(prec_avg)
max(prec_avg)
range(prec_avg)
which.min(prec_avg)
which.min(abs(prec_avg-50)) #what value is closest to 50
diff(prec_avg)

#p.45 bzw. 83
x1 <- rbinom(10,size=1,prob=0.5)
x1
x2 <- factor(x1,labels=c("man","woman"))
x2
summary(x2)
levels(x2)
as.character(x2)

library(car)
recode(x2,"'woman'='woman'; 'man'='guy'") #recode
ifelse(x2=="man","guy","woman") #same

coplot() #for plotting with 3 variables

#Raster
library(raster)
install.packages("raster")
install.packages("sp")
r1 <- raster(nrows=10, ncol=10)
r1
r1[] <- rnorm(100)
plot(r1)

library(sp)
poi1 <- cbind(c(rnorm(10)),c(rnorm(10))) #create 10 random coordinate pairs
poi1 #look at the output
poi1.sp <- SpatialPoints(poi1) #convert list of c. to a spatial object
plot(poi1.sp) #plot the spatial point data set

df <- data.frame(attr1=c("a","b","z","d","e","q","w","r","z","y"), atrr2=c(101:110)) #creating values
df
poi1.spdf <- SpatialPointsDataFrame(poi1.sp,df) #adding values to spatial point data set
plot(poi1.spdf)#plot the spatial points data set


install.packages("RStoolbox")
library(RStoolbox)
lsat
lsat[[1]]
plot(lsat[[1]]) #plot the first band
x <- lsat[[1]] #save band 1 in a new object
plot(lsat[[2:3]]) #plot band 2 and 3
x <- lsat[[2:3]] #save band 2 and 3 in a new object

qq <- x[x$B2_dn >18]
plot(qq)

plot(lsat$B1_dn)#plot band 1 option 2

install.packages("move")
library(move)
data(lsat) 
x <- lsat[1:10,] #values of rows 1 to 10
x <- lsat [] #all values
x <- getValues(lsat) #all values

x <- lsat[lsat$B1_dn > 10] #based on logical query
x

data(leroy)
env <- raster(leroy,vals=rnorm(100))
x <- extract(env, leroy)
x

poly <- readRDS(system.file("external/trainingPolygons.rds",package = "RStoolbox")) #get the vector data from the RStoolbox
env <- raster(poly, vals=rnorm(100)) #create a raster with the properties extent and projection of the vector
plot(env)

x <- extract(env, poly) #extract raster values based on vector
x


lsat[] <- rnorm(ncell(lsat))#populate all bands with normally distributed data, ncells =number of entries
lsat[]
lsat [lsat < 0] <- NA #set all values below 0 to NA
lsat[]

env[] <- 0 #all values in env set to 0 and poly areas to one
env[]
env[poly] <- 1
env[]
