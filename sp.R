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

CRAN_df <- read.table(file.choose(), header = TRUE) #read data using file.choose() CRAN51001a.txt
CRAN_mat <- cbind(CRAN_df$long, CRAN_df$lat) #combining longitude and latitude in CRAN_mat
CRAN_mat #additional to check result
row.names(CRAN_mat) <- 1:nrow(CRAN_mat) #rownames
row.names((CRAN_mat)) #additional to check result
str(CRAN_mat)

getClass("SpatialPoints") #get class definition of "SpatialPoints"

#p.31

llCRS <- CRS("+proj=longlat +ellps=WGS84")
CRAN_sp <- SpatialPoints(CRAN_mat, proj4string = llCRS)
CRAN_sp #additional
plot(CRAN_sp) #additional
summary(CRAN_sp)

#SpatialPoints: Methods

bbox(CRAN_sp) #bounding box 

proj4string(CRAN_sp) #show crs
proj4string(CRAN_sp) <- CRS(as.character(NA)) #set crs to na
proj4string(CRAN_sp) #show crs
proj4string(CRAN_sp) <- llCRS #assign crs
proj4string(CRAN_sp) #show crs

brazil <- which(CRAN_df$loc == "Brazil")
brazil

coordinates(CRAN_sp)[brazil, ]

summary(CRAN_sp[brazil, ])

#p.33

south_of_equator <- which(coordinates(CRAN_sp)[, 2] <0)
summary(CRAN_sp[-south_of_equator, ])

#SpatialPoints: Data Frames for Spatial Point Data

str(row.names(CRAN_df)) #data frames are containers for data

#p.34

CRAN_spdf1 <- SpatialPointsDataFrame(CRAN_mat, CRAN_df,proj4string = llCRS, match.ID = TRUE)
CRAN_spdf1 #additional
CRAN_spdf1[4, ]

str(CRAN_spdf1$loc)
str(CRAN_spdf1[["loc"]])

s <- sample(nrow(CRAN_df)) #random samples of CRAN_df assigned to s
CRAN_spdf2 <- SpatialPointsDataFrame(CRAN_mat, CRAN_df[s,], proj4string = llCRS, match.ID = TRUE)
all.equal(CRAN_spdf2, CRAN_spdf1)
CRAN_spdf2[4, ]

# But if we have non-matching ID values, created by pasting pairs of letters
#together and sampling an appropriate number of them, the result is an error:

CRAN_df1 <- CRAN_df
row.names(CRAN_df1) <- sample(c(outer(letters, letters,paste, sep = "")), nrow(CRAN_df1)) #outer() =outer product of arrays 
CRAN_spdf3 <- SpatialPointsDataFrame(CRAN_mat, CRAN_df1,proj4string = llCRS, match.ID = TRUE)

#p.35

getClass("SpatialPointsDataFrame")
names(CRAN_spdf1)

str(model.frame(lat ~ long, data = CRAN_spdf1), give.attr = FALSE)

#p.36
CRAN_spdf4 <- SpatialPointsDataFrame(CRAN_sp, CRAN_df)
all.equal(CRAN_spdf4, CRAN_spdf2)

CRAN_df0 <- CRAN_df
coordinates(CRAN_df0) <- CRAN_mat
proj4string(CRAN_df0) <- llCRS
all.equal(CRAN_df0, CRAN_spdf2)

str(CRAN_df0, max.level = 2) #max.level	=
#maximal level of nesting which is applied for displaying nested structures, e.g., a list containing sub lists. Default NA: Display all nesting levels.

CRAN_df1 <- CRAN_df
CRAN_df1 #additional
names(CRAN_df1)

coordinates(CRAN_df1) <- c("long", "lat")
proj4string(CRAN_df1) <- llCRS
str(CRAN_df1, max.level = 2)

#p.37

turtle_df <- read.csv(file.choose()) #seamap105_mod.csv
summary(turtle_df)

timestamp <- as.POSIXlt(strptime(as.character(turtle_df$obs_date),"%m/%d/%Y %H:%M:%S"), "GMT")
turtle_df1 <- data.frame(turtle_df, timestamp = timestamp)
turtle_df1$lon <- ifelse(turtle_df1$lon < 0, turtle_df1$lon +360, turtle_df1$lon)
turtle_sp <- turtle_df1[order(turtle_df1$timestamp), ]

coordinates(turtle_sp) <- c("lon", "lat")
proj4string(turtle_sp) <- CRS("+proj=longlat +ellps=WGS84")

#SpatialLines
#p.38

getClass("Line")
getClass("Lines")

#p.39

getClass("SpatialLines")

install.packages("maps")
install.packages("maptools")

library(maps)
library(maptools)

japan <- map("world", "japan", plot = FALSE) #alternatively: set plot to T and get map of japan
p4s <- CRS("+proj=longlat +ellps=WGS84")

SLjapan <- map2SpatialLines(japan, proj4string = p4s)
str(SLjapan, max.level = 2)

#p.40

# The command used here can be read as follows: return the length of the Lines slot - how many Line objects it
# contains - of each Lines object in the list in the lines slot of SLjapan,
# simplifying the result to a numeric vector. If lapply was used, the result
# would have been a list.

Lines_len <- sapply(slot(SLjapan, "lines"), function(x) length(slot(x,"Lines")))
table(Lines_len)

Lines_len <- lapply(slot(SLjapan, "lines"), function(x) length(slot(x,"Lines")))
table(Lines_len)

# converting data returned by the base graphics function contourLines
# into a SpatialLinesDataFrame object

volcano_sl <- ContourLines2SLDF(contourLines(volcano))
t(slot(volcano_sl, "data"))

#p.41

llCRS <- CRS("+proj=longlat +ellps=WGS84")
auck_shore <- MapGen2SL(file.choose(), llCRS) #auckland_mapgen.dat
summary(auck_shore)

#maps, RArcInfo, maptools and rgeos : further packages for line changing

#SpatialPolygons

lns <- slot(auck_shore, "lines")
table(sapply(lns, function(x) length(slot(x, "Lines"))))

islands_auck <- sapply(lns, function(x) {
crds <- slot(slot(x, "Lines")[[1]], "coords")
identical(crds[1, ], crds[nrow(crds), ]) })

table(islands_auck)

#p.42

getClass("Polygon")

#p.43

getClass("Polygons")
getClass("SpatialPolygons")

#p.44
islands_sl <- auck_shore[islands_auck]

list_of_Lines <- slot(islands_sl, "lines")

islands_sp <- SpatialPolygons(lapply(list_of_Lines, function(x) {
Polygons(list(Polygon(slot(slot(x, "Lines")[[1]],
"coords"))), ID = slot(x, "ID"))
}), proj4string = CRS("+proj=longlat +ellps=WGS84"))

summary(islands_sp)

slot(islands_sp, "plotOrder")

order(sapply(slot(islands_sp, "polygons"), function(x) slot(x,"area")), decreasing = TRUE)

