
# e.g. prepare_the_regional_data("it_south", 1140, 1340)

prepare_the_regional_data <- function(region, start_year, end_year){
  
  regions <- read.csv("data/eutotal_by_region_with_n.csv")
  
  result1 <- 
    regions %>% 
    filter(between(decade, start_year, end_year)) %>%
    filter(ctr2 == region) %>% 
    select(decade,
           mean,
           sd,
           V1)
  
  result2 <- 
    roev::DataPrep(result1)
  
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
  bootresultd = roev::TriPanelBC(result2,     # idrx matrix
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
  
  return(list(bootresultd = bootresultd,
              slope_max = slope_max,
              slope_med = slope_med,
              slope_min = slope_min))