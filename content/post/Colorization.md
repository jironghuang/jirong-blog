+++
title = "Colorization"
date = '2018-12-05'
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

## Colorization

The following is a high level project pipeline of my Computational Photography Colorization report. The project scope involves minimizing a quadratic cost function. An artist would only need to make a few colour scribble on a grey photograph and the algorithm will automatically populate the entire photograph with the associated colours.

1.Input: I first read in the image using imread function.

2.Find the difference: Next I compute the difference between the marked and grey scale image. This would feed into step 5.

3.Transform to YIQ space: Then I convert the grey image and the marked version from RGB space to YIQ space 2 & 3 . I wrote a function, rgbToyiq in color_space.py to convert rgb dimension to that of YIQ.

4.Compute weight matrix:

- The next step, also the most complicated one is to compute the weight matrix.
- I first initialize 3 matrices of size height X width X size of window (9): row indices (i, j count), colIndices and values (weights) to hold key information during the loop
- The algo will loop through each pixel. And it will compute the weights (using marked) according to formula below in a window of size 9 i.e. 9 pixels in a window (including the pixel).

5.Solve Ax = B: Once the weights are obtained, I proceed to obtain a least square solution.

6.Lastly, I transform the YIQ output back to RGB space.

Here are the photographs.

<img src="/post/img/baby.bmp" alt="/post/img/baby.bmp">
<img src="/post/img/baby_marked.bmp" alt="/post/img/baby_marked.bmp">
<img src="/post/img/baby_colorized.bmp" alt="/post/img/baby_colorized.bmp">







