library(rvest)
library(tidyverse)
library(meetupr)
library(jsonlite)

#to use a signed url for r-ladies
all_rladies_groups <- fromJSON("https://api.meetup.com/find/groups?text=r-ladies&sig_id=262147300&radius=global&sig=f9ca12a1587739f82b5df22fe88f913f91254941");
selectedgroups <- all_rladies_groups %>% select("name","link","city", "localized_country_name", "timezone")

write.csv(selectedgroups, "rladies.csv")
