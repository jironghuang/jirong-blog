library(blogdown)

setwd("/home/jirong/Desktop/github/jirong-blog")
# blogdown::new_site(theme = "gcushen/hugo-academic")
# blogdown::serve_site()

# blogdown::new_post("Test post")

hugo_server(host="192.168.1.9", port=3337)    #Need to hard code ip address for it work across computers
