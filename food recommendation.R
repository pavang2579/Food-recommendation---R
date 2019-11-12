## Installation of the library and packages

install.packages("rvest") # library used for webscrapping 
library("tidyverse")
library("rvest")


url= ("https://www.zomato.com/bangalore/restaurants") # url for webscrapping
webpage = read_html(url) # assigning the read html to the variable
webpage #checking the results

# extracting the required data from the webage
webpage %>% 
  html_nodes(".fontsize0") %>% 
  html_attr("title") %>%
  stringr::str_split(pattern = ',') -> listing
#creating the data frame of the  by listing into a respective columns
webpage_df <- do.call(rbind.data.frame, listing)
names(webpage_df) <- c("Name","Place") # giving column names of the data set
webpage_df
webpage_df$Price <- webpage %>% 
  html_nodes("div.res-cost > span.pl0") %>% 
  html_text() %>% 
  parse_number()
webpage_df
webpage_df$Rate <- webpage %>%
  html_nodes(".visible") %>%
  html_text()


head(webpage_df)
zom_df
zom_df %>% 
  ggplot() + geom_line(aes(Name,Price,group = 1)) +
  theme_minimal() +
  coord_flip() +
  labs(title = "Top Zomato Buffet Restaurants",
       caption = "Data: Zomato.com")