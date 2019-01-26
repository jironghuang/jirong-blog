+++
title = "Martingale Strategy - Double Down"
date = 2019-01-26T11:46:49+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["betting", "simulation", "programming", "risk"]
categories = ["betting", "simulation", "programming", "risk"]

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

## Martingale Strategy

In this post, I will simulate a martingale strategy in Roulette's context to highlight the potential risks associate with this strategy.

Double down! That's essentially the essence of it.

Here's a simple explanation of the strategy,

- The croupier spins the ball. If it's red you win the amount you bet, black you lose the same amount 
- If you win, you continue to bet the same amount (same as your 1st bet amount)
- If you lose, you double your bet amount
- And if your accumulated winnings hits a certain amount, you stop and leave the casino

So how would the strategy turn out? To explain, I will use Monte Carlo with a Bernoulli distribution for each roulette spin (X ~ B(1, 0.48)).

### Simulate strategy 10 runs/ times

Here, I simulate the strategy of 10 times. Think of it in this way, there're 10 alternate universes which you exist and you play the same game 10 times. Or you can just simply treat this as going back to the casino on 10 separate days.

In the chart below, you will notice that for some runs; because of a sequence of bad luck, the losses quick spiralled!

<img src="/post/img/10_simulations.png" alt="/post/img/10_simulations.png">


### Simulate strategy 1000 runs/ times and compute the mean

Next, for a more robust interpretation, I went on to simulate this strategy 1000 times and computed the mean and standard deviation. You will notice that the strategy eventually converges to a desired terminal value. In this case, it's $80. So essentially, out of 1000 simulations, all of them reaches my profit target!

However the the risk is enormous. Near the average 120th run, the standard deviation sky-rocketed to 120,000. I'm unsure if anyone could stomach this loss at any one point of time. The journey matters!

<img src="/post/img/1000_simulations.png" alt="/post/img/1000_simulations.png">

<img src="/post/img/simulation_sd.png" alt="/post/img/simulation_sd.png">

### Insights from this strategy

Martingale strategy - to put it simply - is a win small, lose potentially huge strategy.

In this strategy, you will win 100% of the time. 

But the question is, do you have the money (or infinite bankroll) to tide through tough times?
