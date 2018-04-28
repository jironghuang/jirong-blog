---
title: Testing embedding of Java JAR files in Websites/Intranet
author: ~
date: '2018-04-28'
slug: testing-embedding-of-java-jar-files-in-websites-intranet
categories: [programming]
tags: [java]
header:
  caption: ''
  image: ''
---
http://www.codejava.net/java-se/applet/how-to-show-java-applet-in-html-page
http://www.oxfordmathcenter.com/drupal7/node/37
https://stackoverflow.com/questions/8440840/java-applet-simply-not-displaying/8440896#8440896

<applet code="HelloWorld.class" width=300 height=200></applet>

<OBJECT codetype="application/java"
        classid="java:HelloWorld.class"
        width="500" height="200">
</OBJECT>

I'm figuring out how to embed Java applications into static pages...