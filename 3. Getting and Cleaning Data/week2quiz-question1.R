# Load the packages and libraries
library(httr)
library(jsonlite)
library(httpuv)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

<oauth_endpoint>
 authorize: https://github.com/login/oauth/authorize
 access:    https://github.com/login/oauth/access_token

# 2. To make your own application, register at
#    https://github.com/settings/developers. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url

#    Replace your app name, key and secret below.
myapp <- oauth_app("yourappname",
                   key = "yourkey",
                   secret = "yoursecret",
                   redirect_uri = "http://localhost:1410/"
)

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
  
  Waiting for authentication in browser...
  Press Esc/Ctrl + C to abort
  Authentication complete.

# 4. Use API
req <- GET("https://api.github.com/users/jtleek/repos", config(token = github_token))

stop_for_status(req)
 Warning messages:
 1: In is.na(output) || !is.character(output) :
  'length(x) = 3 > 1' in coercion to 'logical(1)'
 2: In more || nchar(output) > 80 :
  'length(x) = 3 > 1' in coercion to 'logical(1)'

output <- content(req)

# 5. Find “datasharing”

datashare <- which(sapply(output, FUN=function(X) "datasharing" %in% X))
datashare
[1] 24
                          
# 6. Find the time that the datasharing repo was created.

list(output[[24]]$name, output[[24]]$created_at)
[1] "datasharing"

[[2]]
[1] "2013-11-07T13:25:07Z"
