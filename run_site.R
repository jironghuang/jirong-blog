library(blogdown)

setwd("/home/jirong/Desktop/github/jirong-blog")
# blogdown::new_site(theme = "gcushen/hugo-academic")
blogdown::serve_site()

# blogdown::new_post("Test post")

hugo_server(host="10.120.1.111", port=3335)    #Need to hard code ip address for it work across computers
