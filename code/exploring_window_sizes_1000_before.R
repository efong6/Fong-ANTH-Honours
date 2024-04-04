end_point <- 1000
our_set_of_years <- seq(100, 200, 10)
start_date <- end_point - our_set_of_years

exploring_window_size_output <- 
  vector("list", length = length(our_set_of_years))

for(i in 1:length(our_set_of_years)) {
  print(i)
  exploring_window_size_output[[i]] <- 
    exploring_window_size(start_date[i], 
                          end_point)
  
}


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
