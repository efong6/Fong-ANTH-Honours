library("tidyverse")
regions <- read.csv("data/eutotal_by_region_with_n.csv")

## prepping data
# first four cols of the input data frame 
# must be time-mean-sd-n, in that order
x_mod <- subset(x, select = -c(im3y20))
idrx1 <- roev::DataPrep(x_mod)


# how to get a subset of the church data between two dates
bd_belgium_after <- 
  regions %>% 
  filter(between(decade, 1310, 1340)) %>%
  filter(ctr2 == "be")

bd_belgium_after_prepped <- roev::DataPrep(bd_belgium_after)

plot(c(-10, 16),   # set up plot 
     c(-5, 12), # some trial and error required here       
     type = 'n',
     xaxt = 'n',
     yaxt = 'n',
     axes = FALSE,
     ann = FALSE,
     asp = 1)       # aspect ratio (y/x))

# odd looking plot, but it seems to work, let's focus on the
# slope parameters 
bootresultd = roev::TriPanelBC(bd_belgium_after,     # idrx matrix
                               "r",       # mode (diff/rate)
                               -3,        # panel placement coordinate x
                               3,         # panel placement coordinate y
                               1000,      # number of bootstrap replications
                               "all",     # 'mode' as "medians","all","mixed"
                               1.5,       # circle size for points (1.5 or 2)
                               "normal")  # 'equation' position as "normal","lower","none"

slope_max <- round(bootresultd[[1]][1], 3)
slope_med <- round(bootresultd[[1]][2], 3)
slope_min <- round(bootresultd[[1]][3], 3)

# Use these slope values for interpretation of the period
# slope is -0.864 slope max 0.391 and slope min -1.752
#stationary with components of random and directional
library(ggbeeswarm)

ggplot(data.frame(bootresultd[[2]])) +
  aes(0.25, 
      slope) +
  geom_boxplot() +
  geom_quasirandom(alpha = 0.1) +
  annotate("segment",
           y =     slope_max,
           yend =  slope_max,
           x = 0,
           xend = 0.5,
           colour = "red") +
  annotate("segment",
           y =     slope_min,
           yend =  slope_min,
           x =    0,
           xend = 0.5,
           colour = "red") +
  annotate("text",
           x = -0.5,
           y =  0,
           label = "Directional\n(slope at or near 0)") +
  annotate("text",
           x = -0.5,
           y = -0.5,
           label = "Random\n(slope at or near -0.5)") +
  annotate("text",
           x = -0.5,
           y = -1,
           label = "Stationary\n(slope at or near -1)") +
  theme_minimal() +
  theme(axis.ticks.x = element_blank(),
        axis.text.x = element_blank(),
        axis.title.x = element_blank()) +
  scale_x_continuous(limits = c(-0.8, 1)) +
  scale_y_continuous(limits = c(-1.5, 0.5))

ggsave("Black-Death_Belgium_200-Before.pdf")
