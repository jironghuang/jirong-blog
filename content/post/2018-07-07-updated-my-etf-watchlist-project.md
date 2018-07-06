---
title: Updated my ETF watchlist project
author: ~
date: 2018-07-07
slug: updated-my-etf-watchlist-project
categories: ["investment"]
tags: ["investment", "finance"]
header:
  caption: ''
  image: ''
---

While watching a world cup match, I updated my ETF watchlist project (you may click <a href="/project/watch_list">here</a> if you haven't seen the project)

You may find the github code <a href="/project/watch_list">https://github.com/jironghuang/ETF_watchlist</a>. In the revision, I parallelized the crawling - essentially tapping on all the cores in my machines.

To create your own watchlist. Follow these steps,

- Install R and R studio.
- In Mac or Linux, type the following in command line git clone https://github.com/jironghuang/ETF_watchlist . In windows, you may visit the link and download it as zipped folder
- Open the .Rproj
- Tweak the input file to change your watchlist. Ticker symbol should follow yahoo ticker naming convention (e.g. VWRD.L for the ETF listed on stock exchange)
- Ctrl + A and Ctrl + Enter. Or just click the run button in the top right hand of Rstudio

Note: For the auth.r section, you may comment it out if you do not wish to upload the crawled data in googlesheet.

<iframe src="https://docs.google.com/spreadsheets/d/e/2PACX-1vQtSJfzakpUWRkryIoXaqJm7szd-g6R1SHr-aAXAlHNOFEDXYGhCBNC9UeYEYv8cYf8krgsS6LPpED9/pubhtml?gid=0&single=true" width="900" height="780" style="border: none;"></iframe>