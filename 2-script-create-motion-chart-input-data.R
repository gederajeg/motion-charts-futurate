# load the input data with raw token frequency of the infinitives
futurate<-read.table(file="input_data_raw.txt", header=TRUE, 
                     sep="\t", comment.char="", quote="", row.names=NULL)

# load the coha size per decade and the normalising base frequency (1 Mill.)
coha_size<-read.table(file="coha_size.txt", header=TRUE,
                      sep="\t", comment.char="", quote="")

# merge the two data frames
futurate<-merge(futurate, coha_size, by = "decade")
colnames(futurate)[3]<-"going_to"

# create frequency per mill. words for the infinitival collocates
futurate$going_to_norm<-(futurate$going_to*as.double(futurate$norm_freq))/as.double(futurate$size) # use as.double to prevent integer overflow warning
futurate$will_norm<-(futurate$will*as.double(futurate$norm_freq))/as.double(futurate$size) # use as.double to prevent integer overflow warning

# get the joint freq. of the infinitives and difference score for colouring
futurate$joint_freq<-futurate$going_to_norm+futurate$will_norm
futurate$diff<-futurate$going_to_norm-futurate$will_norm

# get the relevant columns and save the file
futurate<-futurate[, c(-3:-6)]
write.table(futurate, file="input_data_futurate.txt", quote=FALSE, sep="\t", row.names=FALSE)
