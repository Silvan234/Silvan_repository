5+6
5*5^4-88*15
0/0
1/0
result1 <- 5+6
result1
4**2
seq(1,9,by=2)
seq(100)
p <- seq(100)
p
a <- c("A", 1:100)
plot(seq(100))
head(a)
summary(a)
prec_avg <- c(56,46,50,53,69,83,83,80,62,55,60,63)
plot(prec_avg)
plot(prec_avg,pch=8,cex=1.5,col="#FF573360") #pch means point shapes #cex= symbol size (default=1), col= html color code
# http://htmlcolorcodes.com/

?plot

#getData

install.packages("raster")     
library(raster)

#Construction Side  One Korea 

PKR <- getData("GADM", country="PRK", level=1)
PKR
plot(PKR)
KOR <- getData("GADM",country="KOR", level=1) 
plot(KOR) 

FK <- union(PKR, KOR) #KOREA IS ONE 
plot(FK)

     
prec <- getData("worldclim",var="prec",res=.5,lon=127,lat=38)
plot(prec)

FK_prec <- crop(prec,FK)
plot(FK_prec)

FK_prec1 <- mask(FK_prec,FK)
plot(FK_prec1)


#Germany
germany <- getData("GADM",country="DEU",level=2)
plot(germany)
prec <- getData("worldclim",var="prec",res=.5,lon=10,lat=51)

ls(prec)
str(prec)
summary(prec)
prec_ger1 <- crop(prec,germany)
plot(prec_ger1)
prec_ger2 <- mask(prec_ger1, germany)
x11() #plotting in second window
plot(prec_ger2)

prec_avg <- cellStats(prec_ger2, stat="mean")
plot(prec_avg)

#Belgium
prec_bel1 <-crop(prec,belgium)
plot(prec_bel1)
prec_bel2 <-mask(prec_bel1,belgium)
plot(prec_bel2)


#GGPLOT

install.packages(ggplot)
library(ggplot2)

x11()
x <- data.frame(x=1,y=1,label="ggplot introduction \n@EAGLE")
ggplot(data=x, aes(x=x,y=y)) + geom_text(aes(label=label),size=15)
x11(x)
?mpg
ggplot(mpg,aes(x=displ, y=hwy)) + geom_point()+geom_smooth()
x11()
ggplot(mpg, aes(displ,cty,colour=class))+geom_point()       
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  facet_wrap(~class)+
  geom_smooth()
ggplot(mpg, aes(class, displ))+
  geom_boxplot(alpha=.1,fill="green", colour = "#3366FF", outlier.colour="red") +
  geom_point(aes(color=hwy), alpha=.7, size=1.5, position=position_jitter(width= .25,height=0))
ggplot(mpg, aes(class,displ))+
  geom_boxplot(alpha=.5)+
  geom_point(aes(color=hwy),alpha=.7,size=1.5, position=position_jitter(width=.25,height=0))

myPlot <- ggplot(mpg, aes(x=displ, y=hwy))+geom_point()
plot(myPlot)             
myPlot+geom_smooth()
ggplot() + geom_point(data=mpg, aes(x=displ,y=hwy))
x11()
ggplot()+geom_point(data=mpg, aes(x=displ, y=hwy, colour=class))
ggplot(mpg,aes(drv,hwy))+
  geom_jitter()
ggplot(mpg, aes(drv,hwy))+
  geom_boxplot()
ggplot(mpg, aes(drv,hwy))+
  geom_violin()
ggplot(mpg,aes(drv,hwy))+
  geom_violin()+
  geom_jitter(aes(alpha=.7,size=2),colour="green")
a <-ggplot() + geom_point(data=mpg, aes(x=displ,y=hwy, colour=class))
a
a+theme_bw()
theme_set(theme_bw())
a+theme_light()
ggplot()+
  geom_point(data=mpg,aes(x=displ,y=hwy,colour=class))+
  facet_grid(manufacturer~drv)+
  ggtitle("EAGLE chart")+
  theme(plot.title=element_text(angle=0,size=22,colour="blue"))+
  scale_colour_discrete(name="type")


