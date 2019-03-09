#creating a motion chart for FUTURATE Constructions
library(googleVis)
futurate<-read.table(file="input_data_futurate.txt", header=T, sep="\t", quote="", comment.char="")

# NOTE! if you want to exclude data from 1810 and "be" and "have" auxiliaries,
# as in Levshina (2015), run the following codes:
futurate<-subset(futurate, decade!=1810 & !coll %in% c("be", "have"))

futurateplot<-gvisMotionChart(futurate, idvar="coll", timevar="decade", xvar="going_to_norm", yvar="will_norm", colorvar="diff", sizevar="joint_freq")
plot(futurateplot)

#outputting the HTML code of the motion charts
# futurate.html<-futurateplot$html$chart
# cat(futurateplot$html$chart, file="futurate_HTML.txt", sep="\n")
#outputting html gvis object to play locally
# cat(futurateplot$html$chart, file="future.html")

#example of setting the axes limit in GoogleVis
# library(googleVis)
# dat <- data.frame(x=LETTERS[1:10], y=c(0, 4, -2, 2, 4, 3, 8, 15, 10, 4))
# area1 <- gvisAreaChart(xvar="x", yvar="y", data=dat, options=list(vAxes="[{viewWindowMode:'explicit', viewWindow:{min:0, max:10}}]", width=500, height=400, title="y-limits set from 0 to 10"), chartid="area1ylim")
# plot(area1)