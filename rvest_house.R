#<https://rstudio-pubs-static.s3.amazonaws.com/221012_b0c842bd540f4ecdb5df02f2ae567be3.html>

# Let's load the packages
library(tidyverse) # clean and tidy the data
library(rvest)     # web scraping
library(xml2)      # read the html page

# Specifying the url
start <- 10  # where the page starts
end <- 700   # last page, depends on how many data that you want
links <- seq(start, end, by = 20) # it will return 20, 40, ... , 200

# Make an empty dataframe to store the data
data <- data.frame()

# Let's loop!
# we will process the links, one by one, that's why I used seq_along function
for(i in seq_along(links)) {
  Initial_page <- "https://www.daft.ie/property-for-rent/dublin/houses" # the very first page
  url <- paste0(Initial_page, "?pageSize=20&from=", links[i]) # construct the url by pasting
  page <- xml2::read_html(url) # read the html

  # Sys.sleep pauses R for two seconds to avoid the error message
  Sys.sleep(2)

  # right-click on page - inspect and you can use CSS Selector addins on Chrome
  # get job location CSS selector
  house_description <- page %>%
    rvest::html_nodes('.btTRFf') %>%
    rvest::html_text() %>%
    stringi::stri_trim_both()

  df <- data.frame(house_description)
  data <- rbind(data, df)
}


head(data)

# Subset the
#df_Dublin <- data %>%
#  dplyr::distinct() %>%
#  dplyr::mutate(city = "Dublin") # add column city = Dublin

# With some cleaning
# df_Dublin$job_description <- gsub("[\r\n]", "", df_Dublin$job_description)

# in case you want to save the dataset into a csv
# write.csv(df_Dublin,"df_Dublin.csv")

