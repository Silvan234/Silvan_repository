install.packages("ctv")
library(ctv)
install.views("Spatial")


library(sp)

#Classes and Methods in R
#p.23 

pi * 10^2
"*"(pi, "^"(10, 2))
pi * (1:10)^2

#p.24

x <- pi + 10^2 #store result in x
print(x)
print(x, digits=12)   #define number of digits
class(x) #what class does x belong to?
typeof(x) #storage mode of x

#print, plot, summary are generic functions

#p.25

# standard data set cars that is an object of class data.frame, stored in a list, which is a vector whose components can be arbitrary objects

class(cars)
typeof(cars)
names(cars) #data frame with two variables
summary(cars)
str(cars)

#p.26

class(dist~speed) #formula
lm(dist ~ speed, data = cars) #lm = linear model 

cars$qspeed <- cut(cars$speed, breaks = quantile(cars$speed), include.lowest = TRUE)
is.factor(cars$qspeed)

plot(dist ~ speed, data = cars)
plot(dist ~ qspeed, data = cars)

lm(dist ~ qspeed, data = cars)

#Spatial Objects
#p.28

getClass("Spatial")

#p.29

getClass("CRS")

m <- matrix(c(0, 0, 1, 1), ncol = 2, dimnames = list(NULL,c("min", "max")))
m #additional 
plot(m) #additional 

crs <- CRS(projargs = as.character(NA))
crs

S <- Spatial(bbox = m, proj4string = crs)
S

bb <- matrix(c(350, 85, 370, 95), ncol = 2, dimnames = list(NULL, c("min", "max")))
bb #additional 
plot(bb)#additional 
Spatial(bb, proj4string = CRS("+proj=longlat")) #not like this in the book


#SpatialPoints
#p.30

getwd()

CRAN_df <- read.table(file=file.choose(), header = TRUE)
