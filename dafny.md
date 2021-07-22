---
layout: page
title: Set up Dafny
description: How to set up Dafny
---

# Installing Dafny

The Dafny verifier is [available on-line](https://rise4fun.com/dafny/Hello). For faster responses and a smoother user experience, however, Dafny is best used as an extension for Visual Studio Code.

To install Dafny in Visual Studio Code, you need first to download and install Visual Studio Code if you do not have it already. On Linux and Mac Os you will also need the latest version of Mono.

Once you have Visual Studio Code, you can install the Dafny extension for Visual
Studio Code following [these
instructions](https://marketplace.visualstudio.com/items?itemName=correctnessLab.dafny-vscode). This
extension contains everything you need, including its own copy of Dafny.

**Note**: you need to have .NET installed. Only the runtime one is necessary. If you want to install it on Ubuntu, for example, you can follow [these instructions](https://docs.microsoft.com/en-us/dotnet/core/install/linux-ubuntu), or likewise look for similar instructions for your environment.

# Using Dafny

Opening a Dafny file (with a `.dfy` extension) with Visual Studio or Visual Studio Code will allow you to see syntax highlighting as well as any errors, as underlined text, in the code or specification. Dafny is reinvoked automatically as you edit the text.
