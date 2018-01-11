#day_5

# LISTS

a <- runif(199) #r-unif 
b <- c("aa","bb","cc","dd","ee")
c <- list(a,b) #list from two vectors of different size
c

#indexing a list of two vectors:
c[2] #index the second object
c[[2]]#same as
c[[2]][1] #first entry of 2nd entry

#more complex list
a <- list(obj_1=runif(100), obj_2= c("a","b"), obj_3=c(1,2,4))

a$obj_1 #call the object name
a[["obj_1"]]#or
a[[1]]#or

#a list with matrix, vector and data frame of different sizes
a <- list(m1=matrix(runif(50),nrow=5),v1=c(1,6,10),df1=data.frame(a=runif(100),b=rnorm(100)))
a$df1[,1]#index a data frame or matrix as known

list()

#if-else-Statements

a <- 5
if (a>0) #if a is larger than o print
{
  print("it is a positive number")
}

a <- 5
if (a!=5)
{print("number is not equal 5")
}else {
    print("number is equal 5")
}

#additional slides on functions

myfunction <- function(x,y){
  x+y
}

myfunction(2,3)

#NDVI using spectralIndices in RStoolbox

img =brick("C:/Silvan/Silvan/Uni Wü Master/MB2_R/Sentinel_2_20160512.tif")

#1
names(img)
ndvi_0 <- spectralIndices(img, red="Sentinel_2_20160512.3",nir="Sentinel_2_20160512.4",indices="NDVI")

#2
x <- names(img)[4]
y <- names(img)[3]
ndvi_1 <- spectralIndices(img, red=y,nir= x,indices="NDVI")

#3 and best:
ndvi_2 <- spectralIndices(img, red=names(img[[3]]),nir=names(img[[4]]),indices="NDVI")
plot(ndvi_2)

#Classification

library(RStoolbox)
uc <- unsuperClass(img,nClasses=5) #unsupervised classification using img and 5 classes
plot(uc$map)

plot(img)
img_kmeans <- kmeans(img[],5) #kmeans clustering of img, 5 classes
kmeansraster <- raster(img) #copy raster attributes to new raster file
kmeansraster #add.
kmeansraster[] <- img_kmeans$cluster#populate empty raster file with cluster values from kmeans()
plot(kmeansraster)


click(kmeansraster, n=3)
arg <- list(at=seq(1:5),labels=c("none","none","water","forest","defo")) #alternative: seq(1,5,1)
color <- c("white","white","blue","green","brown")
plot (kmeansraster,col=color, axis.arg=arg)

# 
install.packages("cluster")
library(cluster)

img_kmean_pam <- pam(img[], 5) #mal mit Subset versuchen!
pam.r <- raster(img)
pam.r
pam.r[] <- img_kmean_pam$cluster
plot(pam)



#ggplot2

library(ggplot2)
x11()
x <- data.frame(x=1,y=1,label="ggplot2 introduction\n@ EAGLE")
ggplot(data=x, aes(x=x, y=y))+ geom_text(aes(label=label),size=15)

#Steigerwald
install.packages("devtools")
library(devtools)
install_bitbucket("EAGLE_MSc/steigerwald", build_vignettes=TRUE)

library(steigerwald)
head(bio_data)

ggplot(bio_data$forest, aes(x=beech,y=ndvi))+geom_point()

ggplot(bio_data$forest,aes(beech,ndvi,colour=height)) +
  geom_point() +geom_smooth()

ggplot(bio_data$forest,aes(beech,ndvi))+
  geom_point()+
  facet_wrap(~sub_basin)

ggplot(bio_data$forest,aes(beech,ndvi))+
  geom_point()+
  facet_wrap(~sub_basin)+geom_smooth()

ggplot(bio_data$forest, aes(sub_basin,ndvi))+
  geom_boxplot(alpha=.5)+
  geom_point(aes(color=height), alpha=.7,size=1.5,position =position_jitter(width=.25,height=0))

ggplot()+ geom_point(data=bio_data$forest, aes(sub_basin,ndvi))

ggplot()+ geom_point(data=bio_data$forest, aes(sub_basin,ndvi,colour=height))

ggplot()+geom_point(data=bio_data$forest, aes(sub_basin,ndvi),colour="blue")

ggplot(bio_data$forest, aes(x=beech, y=ndvi)) +
  geom_jitter()

ggplot(bio_data$forest, aes(x=beech, y=ndvi)) +
  geom_boxplot()

ggplot(bio_data$forest, aes(x=beech, y=ndvi)) +
  geom_violin() + geom_jitter(aes(alpha=.7,size=2),colour="blue")

#store plot
a <- ggplot() +geom_point(data=bio_data$forest, aes(sub_basin,ndvi, colour=height))

#call stored plot and add new options
a+theme_bw()

#for all further plots
theme_set(theme_bw())
a
a+theme_grey() #back to the the default, for this one only
a

#get the current theme
theme_get()
theme_update()
