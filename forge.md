---
layout: page
title: Set up Forge
description: How to set up Forge
---

[Forge](https://github.com/tnelson/Forge/tree/dev) is a tool and language heavily-based on [Alloy](https://alloytools.org/), whose development is led by Tim Nelson at Brown Univesity.

Forge will be our prefered method of studying Alloy, since it offers more features to our intended usage. It is possible however to also use the [Alloy Analyzer]({{ site.baseurl }}{% link alloy-analyzer.md %}). It is available as a jar file.

# Install Forge

Since Forge is written a domain specific language in Racket, it's necessary to install Racket 7.9 (this exact version), available [here](https://download.racket-lang.org/racket-v7.9.html). You will also need Java 8.

Once Racket is installed, do the following:

1. git clone https://github.com/tnelson/Forge
2. cd Forge/forge
3. raco pkg install

# Using Forge

To edit Forge code, it's recommended the usage of DrRacket, the default IDE for
Racket, which will be installed together with Racket. **Note**: it's best to
turn off debugging/profiling, which can significantly slow down DrRacket. Got
into the Language menu (Ctrl+L), then click on "Show details", then select the
Dynamic property "No debugging or profiling".

A Forge file must start with `#lang forge`, which will let Racket know it must
load the corresponding tooling for intepreting this language. Then one writes an
Alloy specification as we will learn in the course.

Using the "Run" (Ctrl+R) butten the file will be executed, which will trigger
the formal verification of the specification.

When a "run" command is given (in the specification) the vizualizer will be
automatically launched. Forge uses the
[Sterling](https://sterling-js.github.io/) vizualizer, which offers a number of
custom ways of visualizing results.
