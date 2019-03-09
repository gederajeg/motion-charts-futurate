# load the required packages
library(tidyverse)
library(googleVis)

# load the relevant datasets
will_data <- read_tsv("will_INF.txt")
go_data <- read_tsv("go_INF.txt")
coha_size <- read_tsv("coha_size.txt")

# gather the wide, matrix-style, co-occurrence data into long, tidy dataframe
will_data <- gather(will_data, key = "decade", value = "will", -collocate)
go_data <- gather(go_data, key = "decade", value = "going_to", -collocate)

# combine the two collocates data for *will* and *going_to*
will_gonna <- left_join(will_data, go_data)
will_gonna <- replace_na(will_gonna, replace = list(will = 0, going_to = 0))
will_gonna <- mutate(will_gonna, decade = as.numeric(decade))

# integrate the COHA size per decade for normalising collocates frequencies
will_gonna <- left_join(will_gonna, coha_size)

# normalising co-occurrence frequency per million words
will_gonna <- mutate(will_gonna, 
                     will = round((will * norm_freq)/size, 3), 
                     going_to = round((going_to * norm_freq)/size, 3), 
                     joint_freq = will + going_to, 
                     diff = will - going_to)

# remove the COHA size column and the base, normalising frequency column
will_gonna <- select(will_gonna, -size, -norm_freq)

# detect whether the collocates occur in all decades (cf. Levshina, 2015)
# this preprocessing is not included in the original publication when
# generating the motion chart (static and dynamic).
will_gonna <- group_by(will_gonna, collocate)
will_gonna <- mutate(will_gonna, 
                     n_verb = n_distinct(decade))
will_gonna <- ungroup(will_gonna)

# This is the code for following Levshina's (2015) procedure in excluding
# data from 1810, auxiliaries *be* and *have*, and keeping collocates that occur
# in all remaining decades (1820 - 2000). The resulting plot will then be different
# from the original publication in 2014. For the original publication, do not run
# the following codes. Go straight to the `code for the dynamic motion charts`
will_gonna <- filter(will_gonna, 
                     decade != 1810,
                     !collocate %in% c("be", "have"),
                     n_verb == 20) %>% 
  select(-n_verb)

# code for the dynamic motion charts
futurateplot <- gvisMotionChart(will_gonna, 
                                idvar = "collocate", 
                                timevar = "decade", 
                                xvar = "going_to", 
                                yvar = "will", 
                                colorvar = "diff", 
                                sizevar = "joint_freq")
plot(futurateplot)

# code for the static motion charts (with ggplot2 version)
df_labelled <- filter(will_gonna, collocate %in% c("become","go","kill",
                                                   "marry","say", "make", 
                                                   "happen","get","do","be","have"))
df_rest <- filter(will_gonna, !collocate %in% c("become","go","kill",
                                                "marry","say", "make", 
                                                "happen","get","do","be","have"))

# if you don't follow Levshina's preprocessing above (to capture the original processing of the plot), use the following code that log-transformed the x and y axes.
p <- ggplot(data = df_rest,
            aes(x = log(going_to+1), ## adding 1 to prevent infinite value from log zero
                y = log(will+1))) + 
  geom_point(aes(size = joint_freq), alpha = 1/8, show.legend = FALSE) +
  facet_wrap(~decade)

p <- p + geom_point(data = df_labelled,
                    aes(size = joint_freq),
                    alpha = 1/2, colour = "royalblue",
                    show.legend = FALSE) +
  geom_text(data = df_labelled,
            aes(label = collocate), size =2.5) +
  theme_bw()
p

# the following codes are the non-log version of the static motion charts (notice the difference when you follow Levshina's processing above and when you do not, which captures the original publication processing). You need to re-run the creation of `df_labelled` and `df_rest` if you turn from original processing to the one suggested by Levshina (2015)

p <- ggplot(data = df_rest,
            aes(x = going_to,
                y = will)) + 
  geom_point(aes(size = joint_freq), alpha = 1/8, show.legend = FALSE) +
  facet_wrap(~decade)

p <- p + geom_point(data = df_labelled,
                    aes(size = joint_freq),
                    alpha = 1/2, colour = "royalblue",
                    show.legend = FALSE) +
  geom_text(data = df_labelled,
            aes(label = collocate), size =2.5) +
  theme_bw()
p
