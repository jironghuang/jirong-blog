+++
title = "Prototype Pair Trading Strategy for Silver ETFs"
date = 2018-12-18T13:03:44+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["finance", "trading"]
categories = ["finance", "trading"]

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
In these 2 weeks, I'll deploy my pair trading algo strategy into my server.

I modified the code below from a renowned quant trader, Ernest Chan. The basic idea is to find z-scores through moving average & moving SD of spread. If it's more than absolute of z-score, I will either short or long the spread depending on the polarity.

In the backtesting below (using a pair of silver ETFs as an example), I assumed a hypothetical amount of 10,000 dollars per trade.

Results are pretty good with a healthy sharpe ratio of 2.7 in the training set and 1.6 in the testing set of data. Annualized return is approximately 26% (translates to 2600 dollars) for the test set.

<img src="/post/img/equity_curve.png" alt="/post/img/equity_curve.png">
<img src="/post/img/summary_stats.png" alt="/post/img/summary_stats.png">

```
rm(list=ls()) # clear workspace

library('zoo')
library("tidyr")
library("dplyr")
require("quantmod")
require("urca")
require("PerformanceAnalytics")
source('R/util/calculateReturns.R')
source('R/util/calculateMaxDD.R')
source('R/util/backshift.R')
source('R/util/extract_stock_prices.R')

#List of silver etfs, SIVR, USV, SLV, DBS
stock1 = "SIVR"
stock2 = "USV"

start_date = "2014-12-30"
end_date = "2018-12-30"

prop_train = 0.65
enter_z_score = 2     #Can use nlmb to vary
exit_z_score = 1     #Can use nlmb to vary

trade_amount = 10000
finance_rates = 2.5/100

data1 = df_crawl_time_series(stock1, start_date, end_date)
data1 = subset(data1, select = c("Date", "Open", "Close"))
data1$Date = as.Date(data1$Date)

data2 = df_crawl_time_series(stock2, start_date, end_date)
data2 = subset(data2, select = c("Date", "Open", "Close"))
data2$Date = as.Date(data2$Date)

data1 = xts(data1[, -1], order.by = data1[, 1])
data2 = xts(data2[, -1], order.by = data2[, 1])

data = merge(data1, data2)
data = as.data.frame(data)
data = subset(data, !is.na(data$Close) & !is.na(data$Close.1))

#  define indices for training and test sets
trainset <- 1:as.integer(nrow(data) * prop_train)
testset <- (length(trainset)+1):nrow(data)

#Cointegration test-->See if test of r<=1 > threshold. If more cointegrating
jotest=ca.jo(data.frame(data$Close[trainset], data$Close.1[trainset]), type="trace", K=2, ecdet="none", spec="longrun")
summary(jotest)

is_coint = jotest@teststat[1] > jotest@cval[1,3]
if(is_coint){
  print("This pair's training set is cointegrating")
}else{
  print("This pair's training set is not cointegrating")  
}

#Hedge ratio
result <- lm(data$Close[trainset] ~ 0 + data$Close.1[trainset])
hedgeRatio <- coef(result) # 1.631

#Spread
data$spread <- data$Close - hedgeRatio * data$Close.1

##########################Calculate half life#############################
# Calculate half life of mean reversion (residuals)
# Calculate yt-1 and (yt-1-yt)
# pull residuals to a vector
spread_train = data$spread[trainset]
y.lag <- c(spread_train[2:length(spread_train)], 0) # Set vector to lag -1 day
y.lag <- y.lag[1:length(y.lag)-1] # As shifted vector by -1, remove anomalous element at end of vector
spread_train <- spread_train[1:length(spread_train)-1] # Make vector same length as vector y.lag
y.diff <- spread_train - y.lag # Subtract todays close from yesterdays close
y.diff <- y.diff [1:length(y.diff)-1] # Make vector same length as vector y.lag
prev.y.mean <- y.lag - mean(y.lag, na.rm = T) # Subtract yesterdays close from the mean of lagged differences
prev.y.mean <- prev.y.mean [1:length(prev.y.mean )-1] # Make vector same length as vector y.lag
final.df <- data.frame(y.diff,prev.y.mean) # Create final data frame

# Linear Regression With Intercept
result <- lm(y.diff ~ prev.y.mean, data = final.df)
half_life <- -log(2)/coef(result)[2]   #Looking at this to 

if(half_life < 3){
  half_life = 14
}

######################MA of Spread#################################
#Change this to half life for lookback-->https://flare9xblog.com/2017/11/02/pairs-trading-testing-for-conintergration-adf-johansen-test-half-life-of-mean-reversion/
#Try EMA too
data$spread = zoo::na.locf(data$spread)
data$spreadMean <- SMA(data$spread, round(half_life))
data$spreadStd <- runSD(data$spread, n = round(half_life), sample = TRUE, cumulative = FALSE)

# data$spreadMean <- mean(data$spread[trainset], na.rm = T)
# data$spreadStd <- sd(data$spread[trainset], na.rm = T)

data$zscore = (data$spread - data$spreadMean)/data$spreadStd

data$longs <- data$zscore <= -enter_z_score # buy spread when its value drops below 2 standard deviations.
data$shorts <- data$zscore >= enter_z_score # short spread when its value rises above 2 standard deviations.

#  exit any spread position when its value is within 1 standard deviation of its mean.
data$longExits   <- data$zscore >= -exit_z_score 
data$shortExits <- data$zscore <= exit_z_score 

#Signal
data$posL1 = NA
data$posL2 = NA
data$posS1 = NA
data$posS2 = NA

# initialize to 0
data$posL1[1] <- 0; data$posL2[1] <- 0
data$posS1[1] <- 0; data$posS2[1] <- 0

data$posL1[data$longs] <- 1
data$posL2[data$longs] <- -1

data$posS1[data$shorts] <- -1
data$posS2[data$shorts] <- 1

data$posL1[data$longExits] <- 0
data$posL2[data$longExits] <- 0
data$posS1[data$shortExits] <- 0
data$posS2[data$shortExits] <- 0

#positions
data$posL1 <- zoo::na.locf(data$posL1); data$posL2 <- zoo::na.locf(data$posL2)
data$posS1 <- zoo::na.locf(data$posS1); data$posS2 <- zoo::na.locf(data$posS2)
data$position1 <- data$posL1 + data$posS1
# data$position1 = -data$position1    #Don't know why. It should be flipped!!!

data$position2 <- data$posL2 + data$posS2
# data$position2 = -data$position2    #Don't know why. It should be flipped!!!

#Returns
data$dailyret1 <- ROC(data$Close) #  last row is [385,] -0.0122636689 -0.0140365802
data$dailyret2 <- ROC(data$Close.1) #  last row is [385,] -0.0122636689 -0.0140365802

#Backshifting here. But signal is for following day returns!. So can still use latest Z-score
data$date = as.Date(row.names(data))
data = xts(data[,-which(names(data) == "date")], order.by = data[, which(names(data) == "date")])

data$pnl = lag(data$position1, 1) * data$dailyret1  + lag(data$position2, 1) * data$dailyret2

#Sharpe ratio
sharpeRatioTrainset <- sqrt(252)*mean(data$pnl[trainset], na.rm = TRUE)/sd(data$pnl[trainset], na.rm = TRUE)
sharpeRatioTrainset

sharpeRatioTestset <- sqrt(252)*mean(data$pnl[testset], na.rm = TRUE)/sd(data$pnl[testset], na.rm = TRUE)
sharpeRatioTestset 

#Performance analytics
charts.PerformanceSummary(data$pnl[testset])
table.Drawdowns(data$pnl[testset])
table.DownsideRisk(data$pnl[testset])
table.AnnualizedReturns(data$pnl[testset])

#Number of days not in the market
sum(data$pnl == 0, na.rm = T)/length(data$pnl)

#Putting a trade indicator
data$trade_indicator = lag(ifelse(data$position2 != 0 & !is.na(data$position2), 1, 0))

#Putting a unique id
count = 0
data$trade_id = NA

for(i in 2:nrow(data)){ 
  if(as.numeric(data$trade_indicator[i-1]) == 0 & as.numeric(data$trade_indicator[i]) != 0){
    count = count + 1
    data$trade_id[i] = count
  }else if(as.numeric(data$trade_indicator[i-1]) != 0 & as.numeric(data$trade_indicator[i]) != 0){
    data$trade_id[i] = count
  }
}

#Simple trade statistics
data$test = 0; data$test[testset] = 1 
data$pnl_add1 = data$pnl + 1
data_trade = as.data.frame(data)
data_trade_stats = data_trade %>%
  group_by(trade_id, test) %>%
  summarize(trade_duration = n(),
            cum_pnl = prod(pnl_add1, na.rm = T))

data_trade_stats$cum_pnl = data_trade_stats$cum_pnl - 1
data_trade_stats$profit_per_trade = data_trade_stats$cum_pnl * trade_amount

#Financing charges -->Depends on length of days
data_trade_stats$finance_fees =  trade_amount * finance_rates * (data_trade_stats$trade_duration/365)

#Commission fees
data_trade_stats$comm_fess = 4  #2 for 1 pair

#Net profit
data_trade_stats$profit_per_trade_less_comms = data_trade_stats$profit_per_trade - data_trade_stats$finance_fees - data_trade_stats$comm_fess

#Average loss
data_trade_stats = data_trade_stats[-which(is.na(data_trade_stats)), ]

data_trade_stats %>%
  group_by(test) %>%
  summarize(sum_profits = sum(profit_per_trade_less_comms), 
            mean_profits = mean(profit_per_trade_less_comms),
            na.rm = T)

sum(data_trade_stats$profit_per_trade_less_comms < 0)/ nrow(data_trade_stats)

summary(data_trade_stats$profit_per_trade_less_comms)

```

