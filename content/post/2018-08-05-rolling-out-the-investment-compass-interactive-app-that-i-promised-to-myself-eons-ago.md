---
title: Rolling out the Investment Compass interactive app that I promised eons ago
author: ~
date: '2018-08-05'
slug: rolling-out-the-investment-compass-interactive-app-that-i-promised-to-myself-eons-ago
categories: ["investment"]
tags: ["investment", "finance", "dashboard"]
header:
  caption: ''
  image: ''
---

Finally I had some time to sit down to work on the interactive app. From what was an hideous app to a somewhat Minimum Viable Product (MVP) version of an app. (Shhh...I'm not really a User Interface, UI person).

This serves as a compass for me to visualize the potential returns given the % fall from 52 week high. See my linkedin article <a href="https://www.linkedin.com/pulse/investment-compass-our-volatile-times-jirong-huang/">here</a> for further explanation on why I think this is a good indicator.

The app consists of 3 tabs. The 'Visualize' tab contains 3 graphs plotting % fall from 52 week high against the expected returns 1 to 3 years later. And the value boxes are simply the fitted values from the best fit lines.

The second tab contains the description of the indexes. For eg. ^STI refers to Straits Times Index. It will be useful for selection of the Index under Visualization tab.

The third tab is just a summary of the Linkedin article.

If you're interested in reading the codes, pls visit my github <a href="https://github.com/jironghuang/investment_compass">link</a>. At the moment, the lagging of indicators are done in a grossly inefficient way because I was just cobbling together some codes I did in the past. Will optimize it by using parallelized functions like mclapply in the future (used for crawling the stock process but not the computation).  

<iframe src="https://sef88.shinyapps.io/investment_compass/" width="1200" height="1500" style="border: none;"></iframe>

