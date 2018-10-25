+++
title = "Seam Carving"
date = 2018-10-25T13:23:23+08:00
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
## Snippet of my Seam Carving Report from my Msc Computer Science Georgia Tech's Computational Photography module 

Besides removing of streams, we can also add streams. We identify k streams for removal and duplicate by averaging the left and right neighbours. The computation of these averages is done by convolving the following matrix with the images’ colour channels.

    kernel = np.array([[0, 0, 0],
             [0.5, 0, 0.5],
             [0, 0, 0]])

In the implementation of my scaling_up algorithm, I first remove k streams (depending on ratio set by user) and recorded the coordinates and cumulative energy values of the original picture in each removal. 

Then I reverse the whole process by adding the stream back together with the averaged values of neighbours 

I implemented this scaling_up algorithn for the dolphin pictures.

- 8(a) is the original picture 
- 8(c) Enlarged picture with added streams: python main.py fig8 u c 1.5 y  
- 8(d) Enalrged picture without added streams: python main.py fig8 u c 1.5 n  
- 8(f) Enlarged picture with scaling up algorithm implemented twice: python main.py fig8_processed u c 1.5 n  

Figure 8(a), 8(c), 8(d), (f)

<img src="/post/img/seam_carving.img.png" alt="/post/img/seam_carving.img.png">


