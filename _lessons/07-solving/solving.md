---
layout: page
title: Constraint solving for Alloy
---

# Constraint solving for Alloy
{: .no_toc .mb-2 }

- TOC
{:toc}

## Readings
{: .no_toc .mb-2 }

- [Drawing in class]({{ site.baseurl }}{% link _lessons/07-solving/alloy2sat.png %})
- [State of the art SAT solving]({{ site.baseurl }}{% link _lessons/07-solving/SCSC-Heule1.pdf %}), by Marijn Heule.

### Recommended readings
{: .no_toc .mb-2 }

- [Kodkod: A Relational Model Finder]({{ site.baseurl }}{% link _lessons/07-solving/Torlak2007.pdf %})
- [Alloy*: A General-Purpose Higher-Order Relational Constraint Solver]({{ site.baseurl }}{% link _lessons/07-solving/Milisevic2015.pdf %})

## From Alloy to SAT

Determining if an Alloy specification has an instance (within the given bounds) that respects the established restrictions is encoded as a SAT problem (see below). If this problem is *satisfiable*, the corresponding solution is decoded into an Alloy instance and exhibited.

Similarly, checking whether an assertion is valid (i.e., it is always true within the given bounds) is also encoded *negatively* as a SAT problem. If this SAT problem is *unsatisfiable*, then the assertion is valid (within the bounds), otherwise the problem is satisfiable and the corresponding is decoded into an Alloy counterexample.

## The SAT problem

The satisfiability problem consists of determining if there exists a valuation
to the variables of a propositional formula (i.e., a formula in propositional
logic).

### Encoding Sudoku as SAT

- [Sudoku as a SAT problem]({{ site.baseurl }}{% link _lessons/07-solving/sudoku_sat.pdf %})

- SAT problems can be solved with SAT solvers

- [Solving via Minisat](https://github.com/daviddimic/mini-SAT-sudoku-solver):
  This requires having `Minisat` installed. This python program takes a file containing a sudoku problem like

```
0 0 5 0 0 0 8 7 0
3 0 6 0 7 8 4 0 0
8 7 0 0 0 0 0 9 6
0 1 0 3 0 7 0 0 0
0 2 0 0 0 0 0 3 0
0 0 0 8 0 6 0 1 0
5 3 0 0 0 0 0 4 9
0 0 9 4 5 0 1 0 7
0 8 7 0 0 0 3 0 0
```

and producing another file containing the problem solved (where each 0 will be replaced by a number between 1 and 9 following the sudoku rules).

## SAT solving

SAT solvers implement the *conflict-driven clause learning* (CDCL) calculus.
