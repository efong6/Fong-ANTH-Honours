library("tidyverse")

source("code/my-useful-function.R")
mm_itnorth <- prepare_the_regional_data("it_north", 800, 1000)

# Use these slope values for interpretation of the period
# slope is -0.864 slope max 0.391 and slope min -1.752
#stationary with components of random and directional
library(ggbeeswarm)

ggplot(data.frame(mm_itnorth$bootresultd[[2]])) +
  aes(0.25, 
      slope) +
  geom_boxplot() +
  geom_quasirandom(alpha = 0.1) +
  annotate("segment",
           y =      mm_itnorth$slope_max,
           yend =   mm_itnorth$slope_max,
           x = 0,
           xend = 0.5,
           colour = "red") +
  annotate("segment",
           y =     mm_itnorth$slope_min,
           yend =  mm_itnorth$slope_min,
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
  scale_y_continuous(limits = c(-1.75, 0))

ggsave("mm_it-north_before.pdf")
