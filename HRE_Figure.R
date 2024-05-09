
nchurches <-  read_csv("nchurches.csv")



library(tidyverse)

nchurches %>% 
  ggplot() +
  aes(decade, V1) + 
  geom_col() +
  geom_smooth(color = "black") +
  geom_vline(xintercept = 1346, # BM: to keep it managable, choose 1-2 point events to examine how building changing
             colour = "red") +
  geom_vline(xintercept = 1446,
             colour = "blue") +
  labs(x = "Year (AD)",
       y = "Number of Churches Built") +
  facet_wrap( ~ ctr2)

nchurches %>% 
  group_by(decade) %>% 
  summarise(sum_churches = sum(V1)) %>% 
  ggplot() +
  aes(decade, sum_churches) + 
  geom_line() +
  geom_vline(xintercept = c(768,
                            1000,
                            1140,
                            1348), # BM: to keep it managable, choose 1-2 point events to examine how building changing
             colour = "red")  +
  #theme_minimal() +
  ylab("Number of churches") +
  xlab("Year")

ggsave(...)

nchurches %>% 
  filter(ctr2 %in% c("de_south","nl","ch", "be")) %>%
  mutate(country = case_when(
    ctr2 == "de_south" ~ "South Germany",
    ctr2 == "nl" ~ "Netherlands",
    ctr2 == "ch" ~ "Switzerland",
    ctr2 == "be" ~ "Belgium"
  )) %>%
  ggplot() +
  aes(decade, V1) + 
  geom_line() +
  geom_vline(xintercept = c(
    1348), #BM: to keep it managable, choose 1-2 point events to examine how building changing
    colour = "red")  +
  #theme_minimal() +
  ylab("Number of churches") +
  xlab("Year") +
  facet_wrap(~ country, ncol = 2)