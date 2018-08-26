+++
title = "Naming Conventions in R. Let's call it JR Notations"
date = 2018-08-26T14:09:02+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["coding", "programming"]
categories = ["coding", "programming"]

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
## Naming Conventions in R. Let's call it JR Notations.

'Naming conventions' is a huge thing in many programming languages and community. But it's noticeably absent in the R programming community.

With some inspiration from the Hungarian Notation, here's a blue-print that I came up with while working on a major R project over the last 2 months. Drumroll please...

### 1. Naming conventions for R scripts

- F_ for R scripts that contains functions.
- O_ for R scripts that contains classes.
- P_ for R scripts that runs the procedures.

### 2. Naming conventions for R functions. At the start of the function name,

- bf stands for a return in boolean value
- sf stands for a return in string value
- nf stands for a return in numeric value
- mf stands for a return in matrix values
- lf stands for a return in list values
- af stands for a return in array values
- df stands for a return in data frame
- vf stands for a void function. i.e. executing a function without returning a variable.
- gf stands for a return in graph value

### 3. Naming conventions for parameters in functions

- bp stands for boolean parameter
- sp stands for string parameter
- np stands for numeric parameter
- mp stands for matrix parameter
- lp stands for list parameter
- ap stands for array parameter
- dp stands for data frame parameter
- gp stands for a return in graph parameter

### 4. Naming conventions for R variables

- b stands for boolean variable
- s stands for string variable
- n stands for numeric variable
- m stands for matrix variable
- l stands for list variable
- a stands for array variable
- d stands for data frame variable
- g stands for graph variable

### 5. Naming conventions for R global variables
- bg stands for boolean global variable
- sg stands for string global variable
- ng stands for numeric global variable
- mg stands for matrix global variable
- lg stands for list global variable
- ag stands for array global variable
- dg stands for data frame global variable
- gg stands for global graph variable


