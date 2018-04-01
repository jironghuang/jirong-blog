#crawl google prices
library("quantmod")

# setwd("/home/jirong/Dropbox/macro analysis")

scrape_google_fin_latest = function(ticker){
  
  price = NA
  
  tryCatch({
  
    start = Sys.Date()-4
    end = Sys.Date()
    
    getSymbols(ticker,from = start, to = end)
    stock_price = as.data.frame(get(ticker))  
  
    stock_price$ticker_symbol = ticker 
    stock_price$Date = row.names(stock_price)
    
    names(stock_price) = c("Open","High","Low", "Close", "Volume", "ticker_symbol", "Date")
    
    price = stock_price$Close[nrow(stock_price)] 
  
  }, error=function(e){})
  
  return(price)
}

#Starting price-->From start of 2017
scrape_google_fin_start = function(ticker){
  
  price = NA
  
  tryCatch({
    
    start = "2017-01-01"
    end = "2017-01-04"
    
    ticker = getSymbols(ticker,from = start, to = end)
    # getSymbols(ticker,from = start, to = end)
    stock_price = as.data.frame(get(ticker))  
    
    stock_price$ticker_symbol = ticker 
    stock_price$Date = row.names(stock_price)
    
    names(stock_price) = c("Open","High","Low", "Close", "Volume", "ticker_symbol", "Date")
    
    price = stock_price$Close[nrow(stock_price)] 
    
  }, error=function(e){})
  
  return(price)
}

#Starting price-->For end of 2017
scrape_google_fin_end17 = function(ticker){
  
  price = NA
  
  tryCatch({
    
    start = "2017-12-28"
    end = "2017-12-31"
    
    ticker = getSymbols(ticker,from = start, to = end)
    # getSymbols(ticker,from = start, to = end)
    stock_price = as.data.frame(get(ticker))  
    
    stock_price$ticker_symbol = ticker 
    stock_price$Date = row.names(stock_price)
    
    names(stock_price) = c("Open","High","Low", "Close", "Volume", "ticker_symbol", "Date")
    
    price = stock_price$Close[nrow(stock_price)] 
    
  }, error=function(e){})
  
  return(price)
}
