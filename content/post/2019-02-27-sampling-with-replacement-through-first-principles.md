---
title: Sampling With Replacement Through First Principles
author: ~
date: '2019-02-27'
slug: sampling-with-replacement-through-first-principles
categories: ["programming", "statistics", "firstPrinciples"]
tags: ["programming", "statistics", "firstPrinciples"]
header:
  caption: ''
  image: ''
---

# Sampling with replacement

Hello! It's me once again attempting to explain things from first principles - a term popularized by Elon Musk. 

I will use some psudeo code - on sampling with replacement for weights - to aid my explanation. 

Earlier in the week, I attempted to write a simple function from scratch but I gave up after realising that it will take me more than 15 mins! Difficulties lies in the multiple switch statements in defining the intervals. Haven't figured that part out yet.

There're definitely packages out there that does sort of stuff but this forces me to understand the underlying theory from scratch.

So here is the idea, I've a dataset with 4 individuals, tagged to respective weights that corresponds to the population. And I wish to do a bootstrap i.e. sampling with replacement to get a sample size of N = 100

See Wikipedia page on advantages of Bootstrapping --> https://en.wikipedia.org/wiki/Bootstrapping_(statistics)

Here's what I will do. I will first line up the individuals and find the Probability Mass Function (PMF) for each individual accounting for its weight. Second, I will add up the PMF to obtain the Cumulative Density Function (cumulative proportion)

```
df
id weight PMF     CDF
1  2      20%    [0, 20]
2  3      30%    (20, 50]
3  3      30%    (50, 80]
4  2      20%    (80, 100]

```

Next, I will do a loop of 100 times. At the start of each loop I will obtain a float of between 0 to 1. If the value lies between a certain range, I will add that individual to the dataset. Given that num is random, it will lie between the various ranges without order, accouting for length of the interval.

Note that sampling with replacement means there's a chance that an individual may be represented more than once in the dataset.

```
for (i in 1:100){

  num = randint(0, 1)
  
  if(num < 0.2){
    add_to_new_dataset(id = 1)
  }else if (num between 0.2 to 0.5){
    add_to_new_dataset(id = 2)
  }else if (num between 0.5 to 0.8){
    add_to_new_dataset(id = 3)
  }else{
    add_to_new_dataset(id = 3)
  }
}

```

Of course! In R, you should avoid an explicit loop at all costs. The solution is to embed it in a function and use a lapply function.

```
bootstrap_weights = function(i){

num = randint(0, 1)

  if(num < 0.2){
    id = 1
  }else if (num between 0.2 to 0.5){
    id = 2 
  }else if (num between 0.5 to 0.8){
    id = 3
  }else{
    id = 4
  }
  
  data_row = data[id, ]
  return (data_row)
}

bootstrapped_data = rbind.fill(lapply(1: 100, bootstrap_weights))

```

I hope this is useful!

## Latest developments

Courtesy of this post here --> https://stackoverflow.com/questions/24766104/checking-if-value-in-vector-is-in-range-of-values-in-different-length-vector 

Here's the simple solution to link a value to an interval,

```
getValue <- function(x, data) {
  tmp <- data %>%
    filter(CDF1 <= x, x <= CDF2)
  return(tmp$id)
}

# Using rand function to get a list of numbers
rand_numbers <- c(0.1, 0.173, 0.235)
sapply(rand_numbers, getValue, data = df)
```

Cheers!









