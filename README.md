firefox
=======

I am doing research on providing hardware and software support for web browsing workloads.  Firefox is one of my target browsers.

This repo contains all the modifications that I made to Firefox for all sorts of purposes, including:
+ bootstraps, loads a webpage (without post-load js execution), and shuts down by itself
+ automatically downloads a webpage and its related resources and shuts down by itself
+ JavaScript profiling
 - time spent in interpreter/JIT
 - time spent in js engine/native execution
+ libpfm support
