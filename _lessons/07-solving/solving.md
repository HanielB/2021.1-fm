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

- Writings on the board:
  - [Board for the overveiew of leveraging SAT solvers]({{ site.baseurl }}{% link _lessons/07-solving/alloy2sat.png %})
  - [Board for SAT solving]({{ site.baseurl }}{% link _lessons/07-solving/satSolving.png %})
  - [Board for Alloy encoding into SAT]({{ site.baseurl }}{% link _lessons/07-solving/alloy2sat-encoding.png %})

- State-of-the-art SAT solving:
  - [Slides by João Marques-Silva and Mikoláš Janota]({{ site.baseurl }}{% link _lessons/07-solving/Marques-Silva-sat-summerschool2013.pdf %})
  - [Slides by Marijn Heule]({{ site.baseurl }}{% link _lessons/07-solving/SCSC-Heule1.pdf %})

- [Automating Alloy solving]({{ site.baseurl }}{% link _lessons/07-solving/Jackson2000.pdf %}), paper by Daniel Jackson.

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

## Translating Alloy goals into SAT

Let's consider a specification of a pigeonhole problem in Alloy. First we model that we may have pigeons, holes and pigeons may be nested in holes.

```alloy
sig Hole {}
sig Pigeon {nest : set Hole}
```

The property to be respected is that no pigeon is in more than one hole and every pigeon is in a hole. The above formulation is not enough to guarantee this. We can check it:


``` alloy
check {no h : Hole | #nest.h > 1 and no p : Pigeon | no p.nest }
```

This check will produce counterexamples. To avoid this we can force the restrictions that every pigeon is exactly one hole and that all holes have at most one pigeon:

```alloy
fact {
  all p : Pigeon | one p.nest
  all h : Hole | lone nest.h
}
```

Now every execution of a `run` command will yield an instance respecting the
pigeonhole principle. All is well, but *how* are such instances found? We know
that Alloy solving is done via SAT solving. But *how*? What is the propositional
formula that is fed into a SAT solver and whose satisfying assignment can be
mapped back into the Alloy instance being searched?


