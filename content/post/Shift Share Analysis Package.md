+++
title = "Shift Share Analysis Package I developed"
date = 2018-09-22T12:23:28+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["programming"]
categories = ["programming"]

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
## Shift-share Analysis Package I developed

During my career, I often have to deal with compositional & within group effects. For instance, the employment rate fell by 3% across 2 period. How much of it is due to an increase in employment rate within the sub-group and how much of it is due to compositional shift (for example ageing population).

A formal way to explain these effects is known as shift-share analysis. It allows you to decompose percentage point change or absolute changes (WIP) into within group and across group effects. 

A package currently used in the R community is REAT, but it doesn't allow you to decompose the effects into finer categories. Hence, I hope this package developed here is able to fill up the gap.   

Some examples that you may use this tool are,

- Employment rate
- Demographics rate
- Basketball field goal % decomposed into 2 point vs 3 point 

To start using this package, you may first install the devtools package and execute the following command. install_github("jironghuang/shiftshare").

And if you are interested in the codes used to develop the package, you may visit the following link https://github.com/jironghuang/shiftshare

You may follow the example to better understand how this package works. Essentially, what the example does is to decomposte the 29.7% point change into 3 effects. Within effect == 68.8%,  Across_effect == -7.4% and Dynamic Effect == -31.8%  

### Quick example
```
emp1 = c(10, 20, 40, 50)
pop1 = c(40, 50, 60, 70)
emp2 = c(20, 30, 50, 60)
pop2 = c(50, 70, 20, 50)

ss_analysis <- shift_share(ap_grp_labels = c("grp1", "grp2", "grp3", "grp4"),
                           ap_numerator1 = emp1,
                           ap_numerator2 = emp2,
                           ap_denominator1 = pop1,
                           ap_denominator2 = pop2)
                           
> ss_analysis$get_effects()
  grp_labels     prop1     prop2     rate1     rate2 within_effect across_effect dynamic_effect overall_effect
1       grp1 0.1818182 0.2631579 0.2500000 0.4000000   0.027272727    0.02033493    0.012200957     0.05980861
2       grp2 0.2272727 0.3684211 0.4000000 0.4285714   0.006493506    0.05645933    0.004032809     0.06698565
3       grp3 0.2727273 0.1052632 0.6666667 2.5000000   0.500000000   -0.11164274   -0.307017544     0.08133971
4       grp4 0.3181818 0.2631579 0.7142857 1.2000000   0.154545455   -0.03930280   -0.026725906     0.08851675  

> ss_analysis$get_agg_effects()
         Description within_effect across_effect dynamic_effect overall_effect
1 aggregated_effects     0.6883117   -0.07415129     -0.3175097      0.2966507

```