#library(jsonlite)
library(meetupr)


library(httr)

# 1. Find OAuth settings for Meetup:
#    https://www.meetup.com/meetup_api/auth/
meetup <- oauth_endpoint(
  authorize = 'https://secure.meetup.com/oauth2/authorize',
  access    = 'https://secure.meetup.com/oauth2/access'
)

# 2. Register an application at https://secure.meetup.com/meetup_api/oauth_consumers
#    Make sure to register http://localhost:1410/ as the "redirect uri".
#    (the trailing slash is important!)
app <- oauth_app("meetup",
                 Sys.getenv("mkey"),
                 Sys.getenv("msecret"))

# 3. Get OAuth credentials
token <- oauth2.0_token(meetup, app)

print(token)

get_rladies <- function() {
#to use a signed url for r-ladies
#all_rladies_groups <- fromJSON("https://api.meetup.com/find/groups?text=r-ladies&sig_id=262147300&radius=global&sig=f9ca12a1587739f82b5df22fe88f913f91254941");
#selectedgroups <- data.frame(all_rladies_groups["name"],all_rladies_groups["country"])

#all_rladies_groups %>% select("name","link","city", "localized_country_name", "timezone")
  
meetup_api_key <- Sys.getenv("MEETUP_KEY")
all_rladies_groups <- meetupr::find_groups(text = "r-ladies", api_key = meetup_api_key)

# Cleanup
rladies_groups <- all_rladies_groups[grep(pattern = "rladies|r-ladies|r ladies",  x = all_rladies_groups$name, ignore.case = TRUE), ]
  
 # print(rladies_groups)
 # print(meetup_api_key)
  col_to_keep <- c("name", "city", "country", "members", "created","timezone")
  rladies_groups <- rladies_groups[col_to_keep]
  
write.csv(rladies_groups, "data/rladies.csv")
   #write.csv(selectedgroups, "rladies.csv")
}

get_rladies()
