install.packages("fortunes")
library(fortunes)
fortune()
fortune("memory")
install.packages("cowsay")
library(cowsay)
say("Hello world!")
someone_say_hello <- function(){
  animal <- sample(names(animals),1)
  say(paste("Hello,I'm a",animal, ".", collapse=""),by =animal)
}
someone_say_hello()

someone_say_my_fortune <- function(x){
  animal <- animal <- sample(names(animals),1)
  say(paste(fortune(),collapse = "\n"),by = animal)
}
someone_say_my_fortune()

install.packages("ggplot2")
install.packages("ggmap")
install.packages("ggalt")

library(ggplot2)
library(ggmap)
library(ggalt)

wue <- geocode("Würzburg")
wue_ggl_hybrid_map <- qmap("wue",zoom=12,source="google",maptype="hybrid")
wue_places <- c("Zellerau","Sanderau","Randersacker","Gerbrunn","Rottendorf","Estenfeld") #g d Uhrzeigersinn in richtiger Reihenfolge
places_loc <- geocode(wue_places)

wue_ggl_hybrid_map +geom_point(aes(x=lon, y=lat),
data= places_loc,
alpha=0.7,
size=7,
color="tomato")+
geom_encircle(aes(x=lon,y=lat),
data=places_loc,size=2,color="yellow")


#
library(RStoolbox)
library(raster)
img =brick(file.choose())

ggRGB(img, 3,2,1,stretch = "lin")
ggR(img, layer = 4,maxpixels = 1e6, stretch = "hist")
ggR(img, layer=1, stretch = "lin",geom_raster=T)+scale_fill_gradient(low="blue",high="green")

#
getwd()
setwd("E:/Save/Silvan/Uni Wü Master/MB2_R")

td <- rgdal::readOGR("Training Data.shp")
sc <- superClass(img, trainData=td, responseCol = "id") #model=rf is default
plot(sc$map)

sc2 <- superClass(img, model="mlc", trainData=td, responseCol = "id") #mlc
plot(sc2$map)

install.packages("caret")
library(caret)

names(getModelInfo())


#SVM!!!

#strange thing
re <- RStoolbox::rasterEntropy(stack(sc$map,sc2$map))
ggR(re, geom_raster = T)

## SC in detail

library(maptools)
library(randomForest)
library(raster)
library(rgdal)

vec <- readOGR("Training Data.shp")
satImage <- brick(file.choose())

numsamps <- 100
attName <- 'ID'
outImage <- 'classif_result.tif'

uniqueAtt <- unique(vec[[attName]])
for (x in 1:length(uniqueAtt)){
  class_data <- vec[vec[[attName]]==uniqueAtt[x],]
  classpts <- spsample(class_data,type="random",n=numsamps)
  
  if (x==1){
    xy <- classpts 
  } else {
    xy <- rbind(xy, classpts)
  }
}

pdf("training_points.pdf")
    image(satImage,1)
    points(xy)
dev.off()

temp <- over(x=xy, y=vec)
response <- factor(temp[[attName]])
traininvals <- cbind(response,extract(satImage,xy))

print("Starting to calculate random forest object")
randfor <- randomForest(as.factor(response)~.,
          data=trainvals,
          na.action=na.omit,
          confusion=T)

print("Starting predictions")
predict(satImage,randfor,filename=outImage,
        progress='text',format='GTiff',
        datatype='INT1U',type='response',
        overwrite=T)

#Validation

sc <- superClass(img,trainData =td, 
      responseCol = "id", trainPartition = 0.7)

sc3 <- superClass(img, trainData = td,
                  valData = validationPolygons,
                  responseCol = "id")

sc$validation$performance


cat(c("\u4D\u65\u72\u72\u79\u20\u43\u68\u72\u69\u73\u74\u6D\u61\u73\u0A\u74\u6F\u20\u61\u6c\u6c\u20\u45\u41\u47\u4C\u45\u20\u73\u74\u75\u64\u65\u6E\u74\u73\u21\u0A\u0A",unlist(lapply(c(1:17*2-1,rep(3,6)),function(x)
  cat(rep("\u20",(37-x)/2),".",rep("\u23", x), ".\n", sep="")))))
