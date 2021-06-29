---
layout: page
title: Alloy Introduction
---

# Alloy Introduction
{: .no_toc .mb-2 }

- TOC
{:toc}

## Readings

- [Recorded lectures](https://youtube.com/playlist?list=PLeIbBi3CwMZxRUSUJbwyeerfCptuP19Br)
- [Class notes on set theory recap]({{ site.baseurl }}{% link _lessons/02-set-theory-recap/slides.pdf %})
- Class notes on an introduction to Alloy [[part 1]({{ site.baseurl }}{% link _lessons/03-alloy-intro/alloy-intro-1.pdf %}), [part 2]({{ site.baseurl }}{% link _lessons/03-alloy-intro/alloy-intro-2.pdf %})]

### Recommended readings

- Alloy [FAQ](http://alloytools.org/faq/faq.html)
- Lecture notes on first-order logic
  - [by Cesare Tinelli]({{ site.baseurl }}{% link _lessons/03-alloy-intro/fol-cesare.pdf %})
  - [by Mario S. Alvim]({{ site.baseurl }}{% link _lessons/03-alloy-intro/fol-mario.pdf %})
- Alloy Analyzer tutorial, notes by Greg Dennis and Rob Seater [[part 1]({{ site.baseurl }}{% link _lessons/03-alloy-intro/alloy-tutorial-1.pdf %}), [part 2]({{ site.baseurl }}{% link _lessons/03-alloy-intro/alloy-tutorial-2.pdf %})]
- [A hands-on introduction to Alloy](https://blackmesatech.com/2013/07/alloy/), by Michael Sperberg-McQueen

- Automatic generation of security exploits with Alloy, by Caroline Trippel et al. [[paper 1]({{ site.baseurl }}{% link _lessons/03-alloy-intro/trippel2018-checkmate.pdf %}), [paper 2]({{ site.baseurl }}{% link _lessons/03-alloy-intro/trippel2018.pdf %})]

## Topics covered

- Set theory recap

- Modeling general software systems.
  - Introduction to the Alloy modeling language.
  - Alloy's foundadions.
  - Signatures, fields, and multiplicity constrainst.

- Modeling simple domains in Alloy.
  - Generating and analyzing model instances.

- Relations and operations on them.
  - Formulas, Boolean operators and quantifiers.
  - Expressing constraints on relations using Alloy formulas.

- Functions and predicates.

## Resources

- A simple family model for the Alloy Analyzer: [family-1.als]({{ site.baseurl }}{% link _lessons/03-alloy-intro/code/family-1.als %})
- A simple family model *with facts* for the Alloy Analyzer: [family-2.als]({{ site.baseurl }}{% link _lessons/03-alloy-intro/code/family-2.als %})
- A simple family model with facts *and different run configurations* for the Alloy Analyzer: [family-3.als]({{ site.baseurl }}{% link _lessons/03-alloy-intro/code/family-3.als %})
- A simple family model with facts, different run configurations *and assertions* for the Alloy Analyzer: [family-4.als]({{ site.baseurl }}{% link _lessons/03-alloy-intro/code/family-4.als %})
