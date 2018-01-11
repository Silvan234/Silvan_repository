#unsupervised Classification

library(RStoolbox)
img =brick("C:/Silvan/Silvan/Uni Wü Master/MB2_R/Sentinel_2_20160512.tif")
uc <- unsuperClass(img,nClasses = 5)# uc is a list
plot(uc$map)

#using kmeans
img_kmeans <- kmeans(img[],5) #kmeans clustering of img, 5 classes
kmeansraster <- raster(img) #copy raster attributes to new raster file
kmeansraster #add.
kmeansraster[] <- img_kmeans$cluster#populate empty raster file with cluster values from kmeans()
plot(kmeansraster)

#dealing with missing values
#see page 30(or 39 day_6)

plot(kmeansraster)
click(kmeansraster, n=3) #if classes cannot be identified

#create a list of labels corresponding to the class values
#first create a seq from 1:5 in steps by i and label them
arg <- list(at=seq(1:5),labels=c("none","none","water","forest","defo")) #alternative: seq(1,5,1)

#set the coloring of the landscape classes, colors need to correspond to class order
color <- c("white","white","blue","green","brown")

#plot the classification with predefined colors and legend names
plot (kmeansraster,col=color, axis.arg=arg)



#ggplot

help.search("geom_",package="ggplot2")

library(ggplot2)

# dataset:
data=data.frame(value=rnorm(10000))

# Basic histogram
ggplot(data, aes(x=value)) + geom_histogram()

# Custom Binning. I can just give the size of the bin
ggplot(data, aes(x=value)) + geom_histogram(binwidth = 0.05)


#new ggplot example p.46
install.packages("RCurl")
library(RCurl)
x <- read.csv(textConnection(getURL("https://docs.google.com/spreadsheets/d/e/2PACX-1vTbXxJqjfY-voU-9UWgWsLW09z4dzWsv9c549qxvVYxYkwbZ9RhGE4wnEY89j4jzR_dZNeiWECW9LyW/pub?gid=0&single=true&output=csv")))
x
summary(x)
str(x)
names(x)

install.packages("reshape")
library(reshape)
x2 <- melt(data=x)#reformat the data to suit ggplot needs if names should be on xaxis and time on y axis;
#look at data to see changes
x2

library(ggplot2)
ggplot(x2, aes(x=variable, y=value))+geom_boxplot()


#we compute the cummulative sum and add it with the names to
#new data frame. CumSUm is in the last row and we index that

x.cs <- data.frame(variable=names(x),cs=t(cumsum(x)[nrow(x),]))
x.cs
names(x.cs)
names(x.cs) <- c("variable","cumsum")

x2 <- melt(data=x)
x2


x3 <- merge(x.cs, x2, by.x="variable", all=T)
x3
ggplot(x3, aes(x=variable,y=value,color=cumsum))+geom_point()

ggplot(x3, aes(x=variable, y=value, color=cumsum))+geom_boxplot(alpha=.5)
+geom_point(alpha=.7, size=1.5, position=position_jitter(width=.25,height=.5))


cumsum(x)

install.packages("gender")
library(gender)
x.g <- gender(names(x))
1
colnames(x.g)[1] <- "variable"
x4 <- merge(x3, x.g, by.x="variable",all=T)
x4
a <- ggplot(x4, aes(x=variable, y=value, color=cumsum))+geom_boxplot()+facet_wrap(~gender)
a #can hardly be read

#option 1:
a+coord_flip()

#option 2:
a +theme(axis.text.x = element_text(angle=45, vjust=1,hjust=1))

install.packages("reshape2")
library(reshape2)

fielddata_wide <- read.table(header=T, text ='
plot_id name Cover LAI DBH
1 Sophie 79 2.3 1.7
2 Achmed 63 0.6 1.1                             
3 Achmed 95 3.1 1.8
4 Sophie 11 3.4 1.9
')

fielddata_wide
#make sure the plot id is a factor
fielddata_wide$plot_id <- factor(fielddata_wide$plot_id)
fielddata_wide

melt(fielddata_wide, id.vars =c("plot_id", "name")) #not reslut as depicted
melt(fielddata_wide,id.vars=c("plot_id")) #fails


fielddata_long <- melt(fielddata_wide, 
                  id.vars=c("plot_id", "name"), 
                  measure.vars =c("Cover", "LAI","DBH"),
                  variable.name ="method",
                  value_names="measurement"
                  ) #measurementand method are not taken

fielddata_long #still not working as it is supposed to do

#lets assume you created your field data differently:

fielddata_long <- read.table(header = T, text='
plot_id name sample measurement
  1 Ahmed training 7.9
  1 Ahmed valid1 12.3
  1 Sophie valid2 10.7
  2 Sophie training 6.3
  2 Sophie valid1 10.6
  2 Sophie valid2 11.1
  3 Sophie training 9.5
  3 Sophie valid1 13.1
  3 Sophie valid2 13.8
  4 Ahmed training 11.5
  4 Ahmed valid1 13.4
  4 Ahmed valid2 12.9
  ')

fielddata_long$plot_id <- factor(fielddata_long$plot_id)

data_wide <- dcast(fielddata_long, 
plot_id+name~sample, value.var="measurement") #error

data_wide






#spatial ggplot / geofaceting

library(ggmap)
library(mapproj)
map.wue <- get_map("Wurzburg", zoom=15, maptype = "satellite") #define zoom here: max zoom is 18, maptype
ggmap(map.wue)


map <- get_map("Deutschland", zoom=6) #Deutschland
ggmap(map)    

map <- get_map("Bayern", zoom=7) #Bayern
ggmap(map)    

#ggplot2 syntax for spatial data

install.packages("reshape2")
library(reshape2)
library(ggplot2)
library(raster)
library(RStoolbox)

lsat.df <- data.frame(coordinates(lsat), getValues(lsat))

#lsat.df <- lsat.df[lsat.df$band1!=0,]
ggplot(lsat.df) + geom_raster(aes(x=x, y=y, fill=B3_dn))
+ scale_fill_gradient(na.value=NA)+coord_equal()

#adding another coloring scheme
ggplot(lsat.df) +
         geom_raster(aes(x=x,y=y, fill=B3_dn))+
         scale_fill_gradient(low="black", high="white", na.value = NA) + coord_equal()

#same plot as before but stored in "a"
a <- ggplot(lsat.df) +
  geom_raster(aes(x=x,y=y, fill=B3_dn))+
  scale_fill_gradient(low="black", high="white", na.value = NA) + coord_equal()

a #call 'a'   

#get a spatial vector from the RStoolbox package
poly <- readRDS(system.file("external/trainingPolygons.rds", package="RStoolbox"))

#extract the coordinates
plots <- as.data.frame(coordinates(poly))

names(plots)
#plot the previously stored plot plus the vector data
a+guides(fill=guide_colorbar())+geom_point(data=plots, aes(x=V1, y=V2), shape=3, colour="yellow")+
  theme(axis.title.x =element_blank())+coord_equal()

#limit the extent if you like to plot only a certain part odr data
#in case other data sets cover a larger area:

#get the extent of lsat
lim <- extent(lsat)

#use stored plot plus new plotting commands
a+
  guides(fill=guide_colorbar())+
  geom_point(data=plots, aes(x=V1, y=V2),shape=3, colour="yellow")+
  theme(axis.title.x=element_blank())+
  scale_x_continuous(limits=c(lim@xmin, lim@xmax))+
  ylim(c(lim@ymin, lim@ymax))

#define your own theme: p. 66 /90  