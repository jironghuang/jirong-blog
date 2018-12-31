+++
title = "Translating Ernest Chan Kalman Filter Strategy Matlab and Python Code Into R"
date = 2019-01-01T00:15:53+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["algo", "trading", "programming"]
categories = ["algo", "trading", "programming"]

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
## Translating Ernest Chan Kalman Filter Strategy Matlab and Python Code Into R

I'm really intrigued by Ernest Chan's approach in Quant Trading.

Often in the retail trading space, what 'gurus' preach often sounds really dubious. But Ernest Chan is different. He's sincere, down-to-earth and earnest (meant to be a pun here).

In my first month of deploying algo trading strategies, I focus mainly on mean-reversion strategies - paricularly amongst pairs. What I learnt - with real capital - is that the hedge ratio is dynamic and will vary over time. In the early days, I fixed it through linear regression. But boy this doesn't work! It's not really market neutral because of the imbalance in values between pairs across time.

Then I chanced upon Kalman filter - something I learnt during my AI module in my Computer Science Degree days. I'll spare the Math here. It's a variant of the markov model, that uses a series of measurements over time (in this case, one of the pairs price), containing noise and produces estimates of unknown (here it's the hedge ratio and intercept). Hedge ratio is updated in each time step.

I saw the Python code online for EWA-EWC pair strategy that returns a sharpe ratio of 2.4. I tried to search for a R version but to no avail! 

Hence I decided to spend a day translating the python code into R code (for deployment purposes. Currently my algo trading stack is built around R). Thankfully I'm not translating the Matlab version because I do not have prior experience in that. And it would definitely take me more than a day for the translation.

I've since,

- Wrapped the code with a function
- Loop through a 40 choose 2 combinations of country pairs
- Triangulated with distance metrics like Correlation, Euclidean Distance and Manhattan Distance
- Filtered out long half life (i.e. # of days before reverting to the mean)
- Filtered by sharpe ratios, drawdown and average profits

And so far, this market-neutral strategy is really promising!

### Translated R code for EWA - EWC strategy
```
#Note: Try to put everything in a data-frame
lapply(c("zoo", "tidyr", "plyr", "dplyr",
         "gtools","googlesheets", "quantmod", 
         "urca", "PerformanceAnalytics", "parallel"), require, character.only = T)

source('util/calculateReturns.R')
source('util/calculateMaxDD.R')
source('util/backshift.R')
source('util/extract_stock_prices.R')
source('util/cointegration_pair.R')


#Reading in the data
df = read.csv('kalman_filter/inputData_EWA_EWC.csv')
df = subset(df, select = c("Date", "EWC", "EWA"))

# Augment x with ones to  accomodate possible offset in the regression between y vs x.
# df$EWA_ones = 1

# delta=1 gives fastest change in beta, delta=0.000....1 allows no change (like traditional linear regression).
delta = 0.0001 

#yhat=np.full(y.shape[0], np.nan) # measurement prediction
df$yhat = NA

#Initialize matrix
df$e = df$yhat # e = yhat.copy(), residuals
df$Q = df$yhat # Q = yhat.copy(), measurement variance

# For clarity, we denote R(t|t) by P(t). Initialize R, P and beta.
R = matrix(dat = rep(0, 4), nrow = 2, ncol = 2) #R = np.zeros((2,2))
P = R   #P = R.copy()

#Store beta in df and separately for computation
beta = matrix(dat = rep(NA, nrow(df) * 2), nrow = 2, ncol = nrow(df))
df$beta1 = NA; df$beta2 = NA  #beta = np.full((2, x.shape[0]), np.nan)

Vw = delta/(1-delta) * diag(2) #Vw=delta/(1-delta)*np.eye(2)
Ve = 0.001

# Initialize beta(:, 1) to zero
beta[, 1] = 0 #beta[:, 0]=0
df$beta1 = beta[1, 1]; df$beta2 = beta[2, 1]

#for t in range(len(y)):
for (t in 1:nrow(df)){
 
  if(t > 1){
    #Update matrix
    beta[, t] = beta[, t-1]
    R = P + Vw
    
    #Update df
    df$beta1[t] = beta[1, t]
    df$beta2[t] = beta[2, t]
  }
  
  # yhat[t, ] = as.matrix(x[t, ]) %*% as.matrix(beta[, t])    #yhat[t]=np.dot(x[t, :], beta[:, t])
  df$yhat[t] = as.matrix(data.frame(df$EWA[t], 1)) %*% as.matrix(beta[, t]) 
  
  # Q[t, ] = (as.matrix(x[t, ]) %*% R) %*% t(as.matrix(x[t, ])) + Ve  #Q[t] = np.dot(np.dot(x[t, :], R), x[t, :].T)+Ve
  df$Q[t] = (as.matrix(data.frame(df$EWA[t], 1)) %*% R) %*% t(as.matrix(data.frame(df$EWA[t], 1))) + Ve
  
  # e[t, ] = y[t, ] - yhat[t, ] #e[t]=y[t]-yhat[t] # measurement prediction error
  df$e[t] = df$EWC[t] - df$yhat[t]
  
  K = R %*% t(as.matrix(data.frame(df$EWA[t], 1))) / df$Q[t]  #K = np.dot(R, x[t, :].T)/Q[t] #  Kalman gain
  beta[, t] = beta[, t] + K %*% as.matrix(df$e[t]) #beta[:, t]=beta[:, t]+np.dot(K, e[t]) #  State update. Equation 3.11
  
  #Update df
  df$beta1[t] = beta[1, t]
  df$beta2[t] = beta[2, t]
  
  # State covariance update. Euqation 3.12
  P = R - ((K %*% as.matrix(data.frame(df$EWA[t], 1))) %*% R) #P = R-np.dot(np.dot(K, x[t, :]), R) 
}

#Generated signals
df$Q_root = df$Q ^ 0.5
df$longs <- df$e <= -df$Q ^ 0.5 # buy spread when its value drops below 2 standard deviations.
df$shorts <- df$e >= df$Q ^ 0.5  # short spread when its value rises above 2 standard deviations.  Short EWC

df$longExits  <- df$e > 0 
df$shortExits <- df$e < 0

# initialize to 0
df$numUnitsLong = NA
df$numUnitsShort = NA
df$numUnitsLong[0]=0.
df$numUnitsShort[0]=0.

df$numUnitsLong[df$longs]=1.
df$numUnitsLong[df$longsExit]=0
df$numUnitsLong = ifelse(is.na(df$numUnitsLong), 0, df$numUnitsLong)

df$numUnitsShort[df$shorts]=-1.
df$numUnitsShort[df$shortsExit]=0
df$numUnitsShort = ifelse(is.na(df$numUnitsShort), 0, df$numUnitsShort)

df$numUnits = df$numUnitsLong + df$numUnitsShort 

df$position1 = 0; df$position2 = 0 

df$position1 = ifelse(df$numUnits == -1, -1, df$position1)   #short EWC, Long EWA --> df$e[t] = df$EWC[t] - df$yhat[t]
df$position2 = ifelse(df$numUnits == -1, 1, df$position2)  #short EWC, Long EWA 

df$position1 = ifelse(df$numUnits == 1, 1, df$position1)   #long EWC, short EWA 
df$position2 = ifelse(df$numUnits == 1, -1, df$position2)  #long EWC, short EWA 

# df$positions = data.frame(df$numUnits, df$numUnits) * (data.frame(-df$beta1, 1)) * data.frame(df$EWA, df$EWC)   #Adjusted price
df$positions = data.frame(df$numUnits, df$numUnits) * (data.frame(1, -df$beta1)) * data.frame(df$EWC, df$EWA)   #Adjusted price

#Returns
df$dailyret1 <- c(NA, (df$EWC[2: nrow(df)] - df$EWC[1: (nrow(df) - 1)])/df$EWC[1: (nrow(df) - 1)])
df$dailyret2 <- c(NA, (df$EWA[2: nrow(df)] - df$EWA[1: (nrow(df) - 1)])/df$EWA[1: (nrow(df) - 1)])

#Daily returns
# lag(df$position1, 1)
# lag(df$position2, 1) * df$beta1
df$pnl = lag(df$positions$df.numUnits, 1) * df$dailyret1  + lag(df$positions$df.numUnits.1, 1) * df$dailyret2

df$ret = (df$pnl)/lag((df$positions$df.numUnits + df$positions$df.numUnits.1), 1)
df$ret = ifelse(is.na(df$ret), 0, df$ret)
df$ret[2] = 0

#Sharpe ratio
sqrt(252)*mean(df$pnl, na.rm = TRUE)/sd(df$pnl, na.rm = TRUE)
```

