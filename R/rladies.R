library(jsonlite)
#library(meetupr)

get_rladies <- function() {
#to use a signed url for r-ladies
all_rladies_groups <- fromJSON("https://api.meetup.com/find/groups?text=r-ladies&sig_id=262147300&radius=global&sig=f9ca12a1587739f82b5df22fe88f913f91254941");
#selectedgroups <- data.frame(all_rladies_groups["name"],all_rladies_groups["country"])

#all_rladies_groups %>% select("name","link","city", "localized_country_name", "timezone")
  
meetup_api_key <- Sys.getenv("MEETUP_KEY");
#all_rladies_groups <- find_groups(text = "r-ladies", api_key = meetup_api_key)

# Cleanup
rladies_groups <- all_rladies_groups[grep(pattern = "rladies|r-ladies|r ladies", 
                                          x = all_rladies_groups$name,
                                          ignore.case = TRUE), ]

write.csv(rladies_groups["name"], "data/rladies.csv")
  print("writing....")
 
  #write.csv(selectedgroups, "rladies.csv")
}

get_rladies()
