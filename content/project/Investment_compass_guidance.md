+++
title = "Investment compass"
date = 2018-08-09T21:30:46+08:00
draft = false

# Tags: can be used for filtering projects.
# Example: `tags = ["machine-learning", "deep-learning"]`
tags = ["investment", "finance", "dashboard"]

# Project summary to display on homepage.
summary = ""

# Optional image to display on homepage.
image_preview = "compass.jpg"

# Optional external URL for project (replaces project detail page).
external_link = ""

# Does the project detail page use math formatting?
math = false

# Does the project detail page use source code highlighting?
highlight = true

# Featured image
# Place your image in the `static/img/` folder and reference its filename below, e.g. `image = "example.jpg"`.
[header]
image = ""
caption = ""

+++
## Investment Compass (Kindly wait 10 seconds for the entire app to load. Best viewed in Desktop)

This serves as a compass for me to visualize the potential returns given the % fall from 52 week high. See my linkedin article <a href="https://www.linkedin.com/pulse/investment-compass-our-volatile-times-jirong-huang/">here</a> for further explanation on why I think this is a good indicator.

The app consists of 3 tabs. The 'Visualize' tab contains 3 graphs plotting % fall from 52 week high against the expected returns 1 to 3 years later. And the value boxes are simply the fitted values from the best fit lines.

The second tab contains the description of the indexes. For eg. ^STI refers to Straits Times Index. It will be useful for selection of the Index under Visualization tab.

The third tab is just a summary of the Linkedin article.

If you're interested in reading the codes, pls visit my github <a href="https://github.com/jironghuang/investment_compass">link</a>. At the moment, the lagging of indicators are done in a grossly inefficient way because I was just cobbling together some codes I did in the past. Will optimize it by using parallelized functions like mclapply in the future (used for crawling the stock process but not the computation).  

<iframe src="https://sef88.shinyapps.io/investment_compass/" width="1200" height="1500" style="border: none;"></iframe>
