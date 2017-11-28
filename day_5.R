#day_5

a <- runif(199) #r-unif 
b <- c("aa","bb","cc","dd","ee")
c <- list(a,b)
c

c[2]
c[[2]]
c[[2]][1]

a <- list(obj_1=runif(100), obj_2= c("a","b"), obj_3=c(1,2,4))

a$obj_1
a[["obj_1"]]
a[[1]]

a <- list(m1=matrix(runif(50),nrow=5),v1=c(1,6,10),df1=data.frame(a=runif(100),b=rnorm(100)))
a$df1[,1]

list()

#additional slides on functions
#
#

myfunction <- function(x,y){
  x+y
}

myfunction(2,3)

img =brick("C:/Silvan/Silvan/Uni Wü Master/MB2_R/Sentinel_2_20160512.tif")

names(img)
ndvi_0 <- spectralIndices(img, red="Sentinel_2_20160512.3",nir="Sentinel_2_20160512.4",indices="NDVI")

x <- names(img)[4]
y <- names(img)[3]
ndvi_1 <- spectralIndices(img, red=y,nir= x,indices="NDVI")

ndvi_2 <- spectralIndices(img, red=names(img[[3]]),nir=names(img[[4]]),indices="NDVI")
plot(ndvi_2)

#Classification

library(RStoolbox)
uc <- unsuperClass(img,nClasses=5)
plot(uc$map)

plot(img)
img_kmeans <- kmeans(img[],5)
kmeansraster <- raster(img)
kmeansraster #add.
kmeansraster[] <- img_kmeans$cluster
plot(kmeansraster)

click(kmeansraster, n=3)
arg <- list(at=seq(1:5),labels=c("none","none","water","forest","defo")) #alternative: seq(1,5,1)
color <- c("white","white","blue","green","brown")
plot (kmeansraster,col=color, axis.arg=arg)


#ggplot2

library(ggplot2)
x11()
x <- data.frame(x=1,y=1,label="ggplot2 introduction\n@ EAGLE")
#ggplot2+ geom_text(aes(label=label),size=15)

install.packages("devtools")
library(devtools)
install_bitbucket("EAGLE_MSc/steigerwald", build_vignettes=TRUE)
library(steigerwald)
head(bio_data)

ggplot(bio_data$forest, aes(x=beech,y=ndvi))+geom_point()
ggplot(bio_data$forest,aes(beech,ndvi,colour=height)) +
  geom_point() +geom_smooth()

#hier fehlt was was nicht ging

a <- ggplot(bio_data$forest, aes(sub_basin,ndvi))+
  geom_boxplot(alpha=.5)+
  geom_point(aes(color=height), alpha=.7,size=1.5,position =position_jitter(width=.25,height=0))

ggplot()+ geom_point(data=bio_data$forest, aes(sub_basin,ndvi))
ggplot()+geom_point(data=bio_data$forest, aes(sub_basin,ndvi),colour="blue")

ggplot(bio_data$forest, aes(x=beech, y=ndvi)) +
  geom_jitter()

ggplot(bio_data$forest, aes(x=beech, y=ndvi)) +
  geom_boxplot()

ggplot(bio_data$forest, aes(x=beech, y=ndvi)) +
  geom_violin() + geom_jitter(aes(alpha=.7,size=2),colour="blue")

a <- ggplot() +geom_point(data=bio_data$forest, aes(sub_basin,ndvi, colour=height))

                          