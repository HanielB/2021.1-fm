---
layout: page
title: Set up Alloy Analyzer
description: How to set up the Alloy Analyzer
---

# Installing the Analyzer

Theo Alloy Analyzer 4 is available [here](https://alloytools.org/download.html) as a jar file and requires that Java 6 or later be installed on your machine.

The easiest way to install the tool is simply to download the `alloy4.2.jar` file onto your Desktop and then launch it either by double clicking on its icon (Windows or Mac) or right-clicking the icon and then choosing "Open With java" (Linux).

**Note 1**: Mac users may want to install the Mac OS native version of the analyzer (`alloy4.2.dmg`).

**Note 2**: On Linux, Java might complain about not having enough space for the object heap. In that case, you will need to launch the Alloy Analyzer from a terminal window.

1. Open a terminal and move to the subdirectory that contains the file alloy4.2.jar.
2. At the terminal's prompt, type:

```
java -Xms512m -Xmx1024m -jar alloy4.2.jar &
```

# Using the Analyzer

Click on the Help menu in the Analyzer's top bar for a quick guide on how to use the tool.
