+++
title = "Updated ETF Watchlist Codes"
date = 2018-07-07T01:37:53+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["investment"]
categories = ["investment"]

# Featured image
# Place your image in the `static/img/` folder and reference its filename below, e.g. `image = "example.jpg"`.
# Use `caption` to display an image caption.
#   Markdown linking is allowed, e.g. `caption = "[Image credit](http://example.org)"`.
# Set `preview` to `false` to disable the thumbnail in listings.
[header]
image = ""
caption = ""
preview = true

+++
## Updated ETF watchlist project

While watching a world cup match today, I updated my ETF watchlist project (you may click <a href="/project/watch_list">here</a> if you haven't seen it yet)

You may find the github code <a href="/project/watch_list">https://github.com/jironghuang/ETF_watchlist</a>. In the revision, I parallelized the crawling - essentially tapping on all the cores in my machines.

To create your own watchlist. Follow these steps,

- Install R and R studio.
- In Mac or Linux, type the following in command line git clone https://github.com/jironghuang/ETF_watchlist . In windows, you may visit the link and download it as zipped folder
- Open the .Rproj
- Tweak the input file to change your watchlist. Ticker symbol should follow yahoo ticker naming convention (e.g. VWRD.L for the ETF listed on stock exchange)
- Ctrl + A and Ctrl + Enter. Or just click the run button in the top right hand of Rstudio

Note: For the auth.r section, you may comment it out if you do not wish to upload the crawled data in googlesheet.

<iframe src="https://docs.google.com/spreadsheets/d/e/2PACX-1vQtSJfzakpUWRkryIoXaqJm7szd-g6R1SHr-aAXAlHNOFEDXYGhCBNC9UeYEYv8cYf8krgsS6LPpED9/pubhtml?gid=0&single=true" width="900" height="780" style="border: none;"></iframe>
