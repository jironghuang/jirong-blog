+++
title = "How to Create a Python Environment in Ubuntu or any Debian-based system"
date = 2019-01-09T23:39:22+08:00
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
Often, certain projects or classes involving python require a set of modules/packages for the code to work.

1 solution is to create a Python Environment dedicated to that project. 

First set up a folder, and include a .yml file with the specific modules and environment that you wish to install. Here is an example (env.yml),

```
name: env
channels: !!python/tuple
- !!python/unicode 'defaults'
dependencies:
- nb_conda=2.2.0=py27_0
- python=2.7.13=0
- cycler=0.10.0
- functools32=3.2.3.2
- matplotlib=2.0.2
- numpy=1.13.1
- pandas=0.20.3
- py=1.4.34
- pyparsing=2.2.0
- pytest=3.2.1
- python-dateutil=2.6.1
- pytz=2017.2
- scipy=0.19.1
- six=1.10.0
- subprocess32=3.2.7
```

If you have anaconda installed, navigate to the folder with .yml; right click and select open in terminal. Then, type the following into bash 

```
conda env create -f env.yml
```

Once installed, type the following into bash to bring up the environment,

```
source activate env
```

If you wish to install a specific program in this environment - say spyder - you can install it directly. Example,

```
conda install spyder

```

To open spyder program, simply type spyder into terminal. And there you go!











