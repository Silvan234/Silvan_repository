#day_4

getwd()
setwd("C:/Silvan/Silvan/Uni Wü Master/MB2_R")

r1 <- raster(nrows=10,ncols=10)
r1
plot(r1) #plot the empty data
r1[] <- rnorm(100) #fil empty raster with 100 random values
r1
plot(r1)

library(sp)
poi1 <- cbind(c(rnorm(10)),c(rnorm(10)))
poi1
poi1.sp <- SpatialPoints(poi1)
plot(poi1.sp,col ="#2fdc4e")
df <- data.frame(attr1=c("a","b","z","d","e","q","w","r","z","y"),
attr2=c(101:110))

poi1.spdf <- SpatialPointsDataFrame(poi1.sp,df)
plot(poi1.spdf)


#a <- sqrt(9)
if (a*a != 9) #!= unequal / == equal
{
  print ("R is great!")
}


j <- 0 #j eq 0, while j<1, do j+0.1 and print j
while (j<1)
{
  j<-j+0.1 ; print (j)
}

myfunctions <- function(arg1, arg2, ...){ #theoretical structure of function
  statements
  return(object)
}

myfunction <- function(x,y){ #own function with x and y
  z<-x+y # z equals sum of x and y
  return(z) #return z
}
myfunction(4,3)# function with x=4 and y=3

#
myfunction <- function(x,y){
  z<-x+y
  return(z)
}

myfunction(4,3)

#
myfunction <- function(x,y){ #same without return
  x+y
}
myfunction(4,3) # same

#
test_function <- function(x,y,z){ #three arguments
  a <- x+y
  b <- x+y+z
  return(c(a,b))#return z and a
}
test_function(2,3,7)

#
band_1 <- raster(file.choose(), band=1)
band_2 <- raster(file.choose(), band=2)
band_3 <- raster(file.choose(), band=3)
band_4 <- raster(file.choose(), band=4)

plot(band_1)
plot(band_4)
plot(band_3)
allbands <- stack(band_1, band_2)
plot(allbands)


img =brick("C:/Silvan/Silvan/Uni Wü Master/MB2_R/Sentinel_2_20160512.tif")
plot(img[[1]]) #plot band 1
plot(img)# plot all bands

plotRGB(img, 4,3,2, stretch='lin') #plotRGB of img, 3,2,1, linear stretch

raster() #single-layer raster
brick() #multi-layer raster from one file
stack() #multi-layer raster from separate files (same extent/resolution)

#brick imports all bands of a file
allbands <- brick(file.choose())

#stack images or drop one
allPlus <- stack(allbands, band_3)

#or
allPlus <- addLayer(allbands, band_3)

#or removing one layer
allWithout <- dropLayer(allbands, index_position_of_layer)

stacked <- stack(c("file1.tif","file2.tif")) # stacking raster from different files
img
getwd()

x <- band_4-band_3 #first trial ndvi
y <- band_4+band_3
a <- x/y
plot(a)

o=img[[4]]-img[[3]]# or this way 
u=img[[4]]+img[[3]]
e=o/u
plot(e)

ndvi <- (band_4-band_3)/(band_4+band_3) #more straight forward
plot(ndvi)

ndvi <- img[[4]]-img[[3]]/img[[4]]+img[[3]]#same
plot(ndvi)

plotRGB(img, 4,3,2) #very dark without stretch
plotRGB(img, 4,3,2, stretch='lin') #plotRGB of img, 4,3,2, linear stretch


install.packages("ggplot2")
library(RStoolbox)
library(ggplot2)
ggRGB(img,4,3,2,stretch="lin")

#single layer greyscale
ggR(img, layer = 4, maxpixels=1e6,stretch = "hist")

#single layer map to user defined legend
ggR(img, layer=1, stretch = "lin",geom_raster = T) +
  scale_fill_gradient(low="blue", high="green")

#for raster, neither save() nor save.image() nor saveRDS() works
writeRaster(img,filename='new_Sentinel2',format="GTiff",overwrite=T)

#export a picture to GoogleEarth
#only works for geographic coordinates, lat long
KML(img,'new_Sentinel2',col=rainbow(255),maxpixels=100000) 


#crop data to a smaller rectangular extent
plot(band_3)
ext <- drawExtent()#draw extent on monitor
band_3_crop <- crop(band_3,ext) #or here: ext*2 #crop
plot(band_3_crop)
ext *2 #grows extent in all 4 dir by 2


#RASTER CALCULATION USING CALC()

raster_sd <- calc(img,fun=sd)#sd is a standard deviation function

#adding a calculation into a function
fun <- function(x) {x/10} # all values divided by 10
raster_output1 <- calc(img, fun)
plot(raster_output1)

fun <- function(x) {x[is.na(x)] <- -999; return(x)} #if value eq na, set to -999
raster_output2 <- calc(img, fun)

raster_output3 <- calc(img, fun=function(x){x[1]+x[2]*x[3]}) #REDO THIS
plot(raster_output3)

raster12 <- stack(raster_output1,raster_output2)
fun <- function(x){lm(x[1:5]~x[6:10])$coefficients[2]} #lineare Regression #REDO THIS
raster_output4 <- calc(raster12, fun)

raster_output5 <- calc(band_3_crop,fun) #doesnt work as only one band! need to crop img above!

plot(raster_output4)

#write your permanent results directly to disk 
#when calculating them
calc(img, fun=sd, filename="new_Sentinel2_sd")

#RASTER CALCULATION USING OVERLAY()
#WITH TWO OR MORE RASTER

raster_output <- overlay(raster_output1, raster_output2, fun=function(x,y){return(x+y)})

#output <- overlay(input1,input2, fun=function(x1_pointing_to_input_1,
#x2_pointing_to_input_2){(x1-x2)})

#overlay(raster1,raster2, fun=functionX, filename
#raster_output <- overlay(raster_1,raster_2,raster_3,fun=function(x,y,z){return(x*y*z)})

#
#TRANSFORMING RASTER DATA
#REPROJECT RESAMPLE
#P.60 IN DAY_4
#

ndvi <- overlay(band_4, band_3, fun= function(nir,red){(nir-red)/(nir+red)})
plot(ndvi)

ndvi <- calc(img, fun=function(x) {(x[,4]-x[,3])/(x[,4]+x[,3])})
plot(ndvi)

savi <- overlay(band_4, band_3, fun=function(nir,red){(nir-red)/(nir+red+0.5)*(1+0.5)},
filename="savi.tif", format="GTiff", overwrite=T) #added overwrite here 
plot(savi)

#NDVI calculation - combine it with a function
fun_ndvi <- function(nir, red){(nir-red)/(nir+red)}
#old:
ndvi <- overlay(band_4, band_3, fun=function(nir,red){(nir-red)/(nir+red)})
#new:
ndvi <- overlay(band_4, band_3, fun=fun_ndvi)


#MSAVI

NIR <- img[[4]]
RED <- img[[3]]

img_MSAVI <- (2*NIR+1-sqrt((2*NIR+1)^2-8*(NIR-RED)))/2
img_MSAVI
plot(img_MSAVI)

#Better do:

img =brick(file.choose())

fun_msavi <- function(NIR,RED){(2*NIR+1-sqrt((2*NIR+1)^2-8*(NIR-RED)))/2}
plot(fun_msavi(img[[4]],img[[3]]))

library(RStoolbox)

ndvi <- spectralIndices(img, red=names(img[[3]]),nir=names(img[[4]]),indices = "NDVI")

