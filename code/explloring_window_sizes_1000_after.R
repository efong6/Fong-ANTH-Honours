
our_set_of_years <- seq(100, 200, 20)

exploring_window_size_output <- 
  vector("list", length = length(our_set_of_years))

for(i in 1:length(our_set_of_years)) {
  print(i)
  exploring_window_size_output[[i]] <- 
    exploring_window_size(1000, our_set_of_years[i])
  
}

# wait for this to finish, then

# set names to help interpret
names(exploring_window_size_output) <- our_set_of_years


# take a look
exploring_window_size_output

exploring_window_size_output_df <- 
  bind_rows(exploring_window_size_output,
            .id = "years") 

ggplot(exploring_window_size_output_df) +
  aes(years, 
      slope_med,
      colour = region_codes,
      group = region_codes) +
  geom_point() +
  geom_line()

ggsave("exploring_window_size_1000_after.pdf")