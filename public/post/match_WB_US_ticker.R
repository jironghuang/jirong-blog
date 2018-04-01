#setting directory
# setwd("/home/jirong/Dropbox/macro analysis")

source("crawl_google_ind.R")

#Matching contries in World Bankl list to Google Ticker Symbol
wb_ticker = as.data.frame(mkt_cap_wide$country)
names(wb_ticker)[1] = "country"

wb_ticker$ticker = NA
wb_ticker$ticker[which(wb_ticker$country == "Arab World")] = "MES" 
wb_ticker$ticker[which(wb_ticker$country == "Argentina")] = "ARGT" 
wb_ticker$ticker[which(wb_ticker$country == "Australia")] = "EWA" 
wb_ticker$ticker[which(wb_ticker$country == "Austria")] = "EWO" 
wb_ticker$ticker[which(wb_ticker$country == "Belgium")] = "EWK" 
wb_ticker$ticker[which(wb_ticker$country == "Brazil")] = "EWZ" 
wb_ticker$ticker[which(wb_ticker$country == "Canada")] = "EWC" 
wb_ticker$ticker[which(wb_ticker$country == "Chile")] = "ECH" 
wb_ticker$ticker[which(wb_ticker$country == "China")] = "MCHI" 
wb_ticker$ticker[which(wb_ticker$country == "Colombia")] = "ICOL" 
# wb_ticker$ticker[which(wb_ticker$country == "Denmark")] = "EDEN"    #Something wrong with this
wb_ticker$ticker[which(wb_ticker$country == "Euro area")] = "IEV" 
wb_ticker$ticker[which(wb_ticker$country == "European Union")] = "EZU"
wb_ticker$ticker[which(wb_ticker$country == "France")] = "EWQ"
wb_ticker$ticker[which(wb_ticker$country == "Germany")] = "EWG"
wb_ticker$ticker[which(wb_ticker$country == "Greece")] = "GREK"
wb_ticker$ticker[which(wb_ticker$country == "Hong Kong SAR, China")] = "EWH"
wb_ticker$ticker[which(wb_ticker$country == "India")] = "INDA"
wb_ticker$ticker[which(wb_ticker$country == "Indonesia")] = "EIDO"
wb_ticker$ticker[which(wb_ticker$country == "Ireland")] = "EIRL"
wb_ticker$ticker[which(wb_ticker$country == "Israel")] = "EIS"
wb_ticker$ticker[which(wb_ticker$country == "Italy")] = "EWI"
wb_ticker$ticker[which(wb_ticker$country == "Japan")] = "EWJ"
wb_ticker$ticker[which(wb_ticker$country == "Ireland")] = "EIRL"
wb_ticker$ticker[which(wb_ticker$country == "Korea, Rep.")] = "EWY"
wb_ticker$ticker[which(wb_ticker$country == "Malaysia")] = "EWM"
wb_ticker$ticker[which(wb_ticker$country == "Ireland")] = "EIRL"
wb_ticker$ticker[which(wb_ticker$country == "Meixco")] = "EWW"
wb_ticker$ticker[which(wb_ticker$country == "Netherlands")] = "EWN"
wb_ticker$ticker[which(wb_ticker$country == "New Zealand")] = "ENZL"
wb_ticker$ticker[which(wb_ticker$country == "Nigeria")] = "NGE"
wb_ticker$ticker[which(wb_ticker$country == "Netherlands")] = "EWN"
wb_ticker$ticker[which(wb_ticker$country == "Netherlands")] = "EWN"
wb_ticker$ticker[which(wb_ticker$country == "Norway")] = "ENOR"
wb_ticker$ticker[which(wb_ticker$country == "Peru")] = "EPU"
wb_ticker$ticker[which(wb_ticker$country == "Philippines")] = "EPHE"
wb_ticker$ticker[which(wb_ticker$country == "Poland")] = "EPOL"
wb_ticker$ticker[which(wb_ticker$country == "Portugal")] = "PGAL"
wb_ticker$ticker[which(wb_ticker$country == "Qatar")] = "QAT"
wb_ticker$ticker[which(wb_ticker$country == "Portugal")] = "PGAL"
wb_ticker$ticker[which(wb_ticker$country == "Russian Federation")] = "ERUS"
wb_ticker$ticker[which(wb_ticker$country == "Saudi Arabia")] = "KSA"
wb_ticker$ticker[which(wb_ticker$country == "Singapore")] = "EWS"
wb_ticker$ticker[which(wb_ticker$country == "South Africa")] = "EZA"
wb_ticker$ticker[which(wb_ticker$country == "Spain")] = "EWP"
wb_ticker$ticker[which(wb_ticker$country == "Sweden")] = "EWD"
wb_ticker$ticker[which(wb_ticker$country == "Switzerland")] = "EWL"
wb_ticker$ticker[which(wb_ticker$country == "Thailand")] = "THD"
wb_ticker$ticker[which(wb_ticker$country == "Turkey")] = "TUR"
wb_ticker$ticker[which(wb_ticker$country == "United Kingdom")] = "EWU"
wb_ticker$ticker[which(wb_ticker$country == "United States")] = "VTI"
wb_ticker$ticker[which(wb_ticker$country == "Vietnam")] = "VNM"
wb_ticker$ticker[which(wb_ticker$country == "World")] = "VT"

wb_ticker = subset(wb_ticker,!is.na(wb_ticker$ticker))

wb_ticker$start_price = as.numeric(lapply(wb_ticker$ticker,scrape_google_fin_start))
wb_ticker$price_2017 = as.numeric(lapply(wb_ticker$ticker,scrape_google_fin_end17))
wb_ticker$latest_price = as.numeric(lapply(wb_ticker$ticker,scrape_google_fin_latest))
# coy$ticker = lapply(coy$html,ticker_symbol)

wb_ticker$returns = (wb_ticker$latest_price - wb_ticker$start_price)/wb_ticker$start_price
wb_ticker$returns_17 = (wb_ticker$price_2017 - wb_ticker$start_price)/wb_ticker$start_price


wb_ticker = subset(wb_ticker,!is.na(wb_ticker$returns),select = c("country","returns","returns_17"))










