# load the futurate database
input.all<-read.table(file="input_data_futurate.txt", header=T, sep="\t",
                      comment.char="", quote="")

# If you want to exclude data for 1810 and frequent auxiliaries 'be' and 'have' 
# as in Levshina (2015), run the following codes:
input.all<-subset(input.all, decade!=1810 & !coll %in% c("be", "have"))


#script for all decades plot
labels.all<-c("be","do","become","go","have","think","kill") 

labels.all<-c("be","do","become","go","have","marry","say", "make", "happen")

decade.lab<-labels(table(input.all[,1]))[[1]] # creating character vector containing decade labels
dframe.label<-subset(input.all, input.all[,2] %in% labels.all) # subset all-decades data frame on the basis of selected collocate labels vector for all decades

dframe.label[,2]<-as.character(dframe.label[,2])

part<-split(input.all,input.all[,1]) # splitting the whole data frame into list
part.labALL<-split(dframe.label, dframe.label[,1]) # splitting the selected data frame into list of data frame based on decade for the ease of indexing in "for-loop" for automatic plotting and selective labelling for all decades

png("future-motion-chart.png", res=500, width=8.5*500, height=8.5*500) # setting up a png file for the resulting plot, including the plot's resolution and sizes
par(mfrow=c(5,4), cex=0.45, mar=c(2.5,2,1,1), mgp=c(3,0.75,0), tck=-0.025, las=1)

# small program script for plotting all of the twenty decades
for (i in seq_along(unique(input.all$decade))){ # indexing sequence for looping is set to the total number of decades included
  
  plot(log(part[[i]][,3]+1),
       log(part[[i]][,4]+1), 
       ylim=c(-0.5,7.5), 
       xlim=c(-0.5,4.75),
       xaxt="n", yaxt="n", type="n", ann=F)
  
  axis(side=2, at=c(0,2,4,6,8), labels=c(0,2, 4,6,8), tick=T) # adding major y-axis
  axis(side=1, at=c(0,2,4,6), labels=c(0,2,4,6), tick=T) # adding major x-axis
  axis(side=1, at=c(1,3), labels=F, tcl=-0.2) # adding minor x-axis
  abline(h=c(0,2,4,6,8), 
         v=c(0,2,4,6), 
         col="gray", lty=3) # adding gridlines onto the plot
  
  text(3.5, 1, labels=decade.lab[i], 
       col="grey80", cex=3.5, 
       font=2, family="sans") # adding the decade labels onto the plot
  
  symbols(log(part[[i]][,3]+1),
          log(part[[i]][,4]+1), 
          inches=0.175, 
          fg="grey95", bg="grey80", 
          circles=sqrt(part[[i]][,5]/pi), 
          add=T) # plotting bubble points
  
  symbols(log(part.labALL[[i]][,3]+1),
          log(part.labALL[[i]][,4]+1), 
          inches=0.175, 
          fg="white", bg="grey75", 
          circles=sqrt(part.labALL[[i]][,5]/pi), 
          add=T) # plotting bubble points
  
  text(log(part.labALL[[i]][,3]+1),
       log(part.labALL[[i]][,4]+1), 
       labels=part.labALL[[i]][,2], 
       cex=1.25, family="sans") # adding selected labels onto the plot
}
dev.off() # closing the active graphic device