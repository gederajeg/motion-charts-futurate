﻿library(reshape2)
#load the data table for "will + INF", convert it into a matrix with (as.matrix), and store it in a data called "will.matrix"
		will.data<-read.table(file="C:/Users/Primahadi Wijaya/Dropbox/_Primahadi's Research/2014 September - Motion Charts/Future Constructions/will_INF.txt", header=T, sep="\t", row.names=1, quote="", comment.char="")
		will.matrix<-as.matrix(will.data)
		
#load the data table for "BE going to + INF", convert it into a matrix with (as.matrix), and store it in a data called "go.matrix"
		go.data<-read.table(file="C:/Users/Primahadi Wijaya/Dropbox/_Primahadi's Research/2014 September - Motion Charts/Future Constructions/go_INF.txt", header=T, sep="\t", row.names=1, quote="", comment.char="")
		go.matrix<-as.matrix(go.data)
		
		names(attr(go.matrix, "dimnames"))[[2]]<-"decade" #naming dimension label
		names(attr(go.matrix, "dimnames"))[[1]]<-"collocate" #naming dimension label
		names(attr(will.matrix, "dimnames"))[[2]]<-"decade" #naming dimension label
		names(attr(will.matrix, "dimnames"))[[1]]<-"collocate" #naming dimension label
		
#extract the collocate label from the matrix and store it as a character vector into "coll.label.go" and "coll.label.will"
		coll.label.will<-attr(will.matrix, "dimnames")$"collocate"
		coll.label.go<-attr(go.matrix, "dimnames")$"collocate"

#replicate "in sequence" the collocate label to the total number of decades for each construction, i.e. 20 times for each collocate label, and store the label in a vector called "coll.index.go" & "coll.index.will".
		coll.index.go<-rep(coll.label.go, 20)
		coll.index.will<-rep(coll.label.will, 20)

#create the decade label vector into "decade.label"
		decade.label<-substr(attr(will.matrix,"dimnames")$"decade", 2, 5)
				
#replicate "each" of the decade label to the total number of collocate types for each construction, i.e. 200 times for each decade label, and store the label in a vector called "time.index".
		time.index<-rep(decade.label, each=200)

#create the construction labels vector into "will.label" & "go.to.label"
		cxn.will.label<-rep("will", 4000)
		cxn.go.label<-rep("BE going to", 4000)
		
#prepare an empty vector called "construction", "collocate", "decade" for the final storage of the vector for the data frame
		coll<-vector()
		decade<-vector()
		cxn<-vector()
		
#prepare an empty vector called "now.cxn", "now.coll", and "now.time" for storing temporary vector in the loop
#prepare progress index
		progress.index<-seq(from=200, to=4000, by=200)

#the loop
for (m in 1:4000) {
	now.go<-rep(coll.index.go[m], go.matrix[m])
	now.will<-rep(coll.index.will[m], will.matrix[m])
   	coll<-append(coll,now.go,after=length(coll))
	coll<-append(coll,now.will,after=length(coll))
	
   	now.t.go<-rep(time.index[m], go.matrix[m])
	now.t.will<-rep(time.index[m], will.matrix[m])
   	decade<-append(decade, now.t.go, after=length(decade))
	decade<-append(decade, now.t.will, after=length(decade))
	
	now.cxn.go<-rep(cxn.go.label[m], go.matrix[m])
	now.cxn.will<-rep(cxn.will.label[m], will.matrix[m])
	cxn<-append(cxn, now.cxn.go, after=length(cxn))
	cxn<-append(cxn, now.cxn.will, after=length(cxn))
	
	for (index in progress.index) {
		if (m==index) {
			cat("Processing the last data from the", time.index[index], "decade.", "\n")
		}
	}
}
futurate<-data.frame(cxn, coll, decade)
mytable<-xtabs(~coll+cxn+decade, data=futurate)
input.data<-dcast(futurate, decade+coll~cxn, fun.aggregate=length, value.var="cxn", drop=FALSE) #converting matrix/xtabs into a dataframe
write.table(input.data, file="C:/Users/Primahadi Wijaya/Dropbox/_Primahadi's Research/2014 September - Motion Charts/Future Constructions/input_data_motion_raw.txt", quote=FALSE, sep="\t", col.names=NA)

#creating a motion chart for FUTURATE Constructions
library(googleVis)
futurate<-read.table(file="C:/Users/Primahadi Wijaya/Dropbox/_Primahadi's Research/2014 September - Motion Charts/Future Constructions/input_data_motion_FUTURATE.txt", header=T, sep="\t", quote="", comment.char="")
futurateplot<-gvisMotionChart(futurate, idvar="coll", timevar="decade", xvar="BE.going.to_INF", yvar="will_INF", colorvar="Diff", sizevar="Joint.Freq")
plot(futurateplot)

#outputting the HTML code of the motion charts
futurate.html<-futurateplot$html$chart
cat(futurateplot$html$chart, file="C:/Users/Primahadi Wijaya/Dropbox/_Primahadi's Research/2014 September - Motion Charts/Future Constructions/futurate_HTML.txt", sep="\n")
#outputting html gvis object to play locally
cat(futurateplot$html$chart, file="C:/Users/Primahadi Wijaya/Dropbox/_Primahadi's Research/2014 September - Motion Charts/Future Constructions/future.html")

#example of setting the axes limit in GoogleVis
library(googleVis)
dat <- data.frame(x=LETTERS[1:10], y=c(0, 4, -2, 2, 4, 3, 8, 15, 10, 4))
area1 <- gvisAreaChart(xvar="x", yvar="y", data=dat, options=list(vAxes="[{viewWindowMode:'explicit', viewWindow:{min:0, max:10}}]", width=500, height=400, title="y-limits set from 0 to 10"), chartid="area1ylim")
plot(area1)