#day_4

getwd()
setwd("C:/Silvan/Silvan/Uni Wü Master/MB2_R")

a <- sqrt(9)
if (a*a != 9) #!= unequal / == equal
{
  print ("R is great!")
}

j <- 0
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

myfunction <- function(x,y){ #same without return
  x+y
}
myfunction(4,3) # same

test_function <- function(x,y,a){ #three arguments
  z <- x+y
  a <- x+y+z
  return(c(z,a))#return z and a
}
test_function(2,3,7)

band_1 <- raster(file.choose(), band=1)
band_2 <- raster(file.choose(), band=2)
band_3 <- raster(file.choose(), band=3)
band_4 <- raster(file.choose(), band=4)

plot(band_1)
plot(band_2)
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

stacked <- stack(c("file1.tif","file2.tif")) # stacking raster from different files
img
getwd()

x <- band_4-band_3 #first trial ndvi
y <- band_4+band_3
a <- x/y

ndvi <- (band_4-band_3)/(band_4+band_3) #more straight forward
plot(ndvi)


plot(a)
install.packages("ggplot2")
library(RStoolbox)
ggRGB(img,3,2,1,stretch="lin")

writeRaster(img,filename='new_Sentinel2',format="GTiff",overwrite=T)
KML(img,'new_Sentinel2',col=rainbow(255),maxpixels=100000)

plot(band_3)
ext <- drawExtent()
band_3_crop <- crop(band_3,ext) #or here: ext*2
plot(band_3_crop)
ext *2 #extent * 2

raster_sd <- calc(img,fun=sd)

fun <- function(x) {x/10} # all values divided by 10
raster_output1 <- calc(img, fun)

fun <- function(x) {x[is.na(x)] <- -999; return(x)} #if value eq na, set to -999
raster_output2 <- calc(img, fun)

raster_output3 <- calc(img, fun=function(x){x[1]+x[2]*x[3]})
plot(raster_output3)

raster12 <- stack(raster_output1,raster_output2)
fun <- function(x){lm(x[1:5]~x[6:10])$coefficients[2]} #lineare Regression
raster_output4 <- calc(raster12, fun)

raster_output5 <- calc(band_3_crop,fun) #doesnt work as only one band! need to crop img above!

plot(raster_output4)

calc(img, fun=sd, filename="new_Sentinel2_sd")

ndvi <- overlay(band_4, band_3, fun= function(nir,red){(nir-red)/(nir+red)})
plot(ndvi)

ndvi <- calc(img, fun=function(x) {(x[,4]-x[,3])/(x[,4]+x[,3])})
plot(ndvi)

savi <- overlay(band_4, band_3, fun=function(nir,red){(nir-red)/(nir+red+0.5)*(1+0.5)},
filename="savi.tif", format="GTiff") #sth wrong here
plot(savi)

msavi <- overlay(band_4, band_3,  <- function(2+nir+1-sqrt(2*) #continue here