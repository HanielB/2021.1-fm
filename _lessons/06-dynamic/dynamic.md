---
layout: page
title: Dynamic systems
---

# Dynamic systems
{: .no_toc .mb-2 }

- TOC
{:toc}

## Readings

## A simple state machine and several properties

A state machine is a directed graph that models how a system moves from State to
State as it executes. It has one or more marked Initial (or starting) states,
and edges connecting each state to its successor(s). An initial state can be the
successor of another state. Let's write the following predicates that describe
different properties of state machines:

- there is at least one initial state

- a *deterministic* machine, in which there is one initial state and each state
  has at most one successor

- a *nondeterministic* machine, in which there are multiple initial states, or
  where at least one state has more than one successor, or both

- a machine with at least one state that is *unreachable* from any initial state

- a machine where all states are *reachable* from some initial state (it need not
  be the same initial state for each one)

- a *connected* machine in which every state is reachable (along the successor
  relation) from every other state

- a machine with a *deadlock*: a machine with a state that is reachable from an
  initial state, but has no successors. For example,

  ![State0 is deadlocked]({{ site.baseurl }}{% link _lessons/06-dynamic/deadlock.png %})

  shows a state machine with `State0` deadlocked.

- a machine with a *livelock*: a machine where there exists some cycle reachable
  from an initial state and a state (the “livelocked” state) reachable from the
  cycle that’s not part of the cycle. Note that this livelocked state cannot be
  reached at any point before reaching the cycle or in the cycle itself. For example,

  ![State3 is livelocked by the cycle]({{ site.baseurl }}{% link _lessons/06-dynamic/livelock.png %})

  shows a state machine with `State3` livelocked by the cycle starting in `State0`.

### Code

- Alloy anaylizer version:
  - [state_machine.als]({{ site.baseurl }}{% link _lessons/06-dynamic/code/state_machine.als %})
- Forge version:
  - [state_machine.rkt]({{ site.baseurl }}{% link _lessons/06-dynamic/code/state_machine.rkt %})

## Making the family model dynamic

We can make the family model dynamic by associating relation with states. Let's
cosider a subset of the family model:

```alloy
abstract sig Person {
  spouse: lone Person,
}
sig Man, Woman extends Person {}
```

If we were to make the spouse relation to also consider states, we could
simulate that in one state people are married and another they are not. So the
above model would include `State` and have a different `spouse` relation:

```alloy
sig State {
    successor : set State
}
abstract sig Person {
  spouse: Person lone -> State,
}
sig Man, Woman extends Person {}
```

Now whether people are married is dependent on states: in state `s` people `p`
and `q` are married if `(p+q).spouse.s` is non-empty. With this condition we can
define an operation that simulates a *transition*, i.e., a change of states from
"these people are not married" to "these people are married":

```alloy
pred getMarried [p,q: Person, s,s': State] {
  -- Pre-condition: they must not be married
  no (p+q).spouse.s
  -- Post-condition: After marriage they are each other's spouses
  q in p.spouse.s'
  p in q.spouse.s'
}
```

The above (together with an example `run` command) can be found [here]({{ site.baseurl }}{% link _lessons/06-dynamic/code/family-state.als %}).

## Transition system

Relying on an [ordering]({{ site.baseurl }}{% link _lessons/06-dynamic/ordering.md %}) of the states we can proceed to specify transition systems. A transition system is defined in terms of:

- Initial conditions to be satisfied
- A transition relation than when satisfied changes the system to the next state

Modelling the family model as a transition system defined by the `getMarried` operation, we can define as initial conditions that nobody is married, i.e.

```alloy
pred init [s : State] {
  no spouse.s
}
```

and as transitien relation a predicate stating that two people get married, i.e.

```alloy
pred transition [s, s' : State] {
  some p, q : Person | getMarried[p,q, s, s']
}
```

and finally the transition system states that given that the initial conditions are met, at every state but the final a transition happens between a state and its successor:

``` alloy
pred system {
  init[first]
  all s : State - final | transition[s, s.successor]
}
```

The above specifies all possible executions of the system from a state that satisfies the init condition.

### Frame conditions

It's necessary to restrict operations to only change the relations they refer to. For example, people getting married should not affect the relations about people having children or about being alive. Doing so is called establishing "frame conditions", i.e. what exactly in the system can be affected by an operation.

Considering that the `Person` signature is now defined as

``` alloy
abstract sig Person {
  spouse: Person lone -> State,
  children: set Person -> State,
  alive: set State
}
```

we establish frame predicates for each of the relations:

``` alloy
pred noChildrenChangeExcept[ps : set Person, s, s' : State] {
  all p : Person - ps | p.children.s = p.children.s'
}

pred noSpouseChangeExcept[ps : set Person, s, s' : State] {
  all p : Person - ps | p.spouse.s = p.spouse.s'
}

pred noAliveChange[s, s' : State] {
  alive.s' = alive.s
}
```

and define operations which respect frame conditions:

``` alloy
pred getMarried [p,q : Person, s, s' : State] {
  -- pre-condition: not married yet
  no (p+q).spouse.s
  -- post-condition: they're married
  q in p.spouse.s'
  p in q.spouse.s'
  -- frame conditions
  noChildrenChangeExcept[none, s, s']
  noSpouseChangeExcept[p+q, s, s']
  noAliveChange[s, s']
}

pred isBornFromParents [p : Person, m : Man, w : Woman, s, s': State] {
  -- pre-condition :
  m+w in alive.s
  p not in alive.s
  -- post condition:
  alive.s' = alive.s + p

  m.children.s' = m.children.s + p
  w.children.s' = w.children.s + p
  --frame condition:
  noChildrenChangeExcept[m+w, s, s']
  noSpouseChangeExcept[none, s, s']
}
```

### Code

- Family model as transition system
  - [family-state-trans.als]({{ site.baseurl }}{% link _lessons/06-dynamic/code/family-state-trans.als %})


## Acknowledgments

Thanks to Tim Nelson for sharing examples about the state machine model. Thanks to Cesare Tinelli for the family model material, itself based on the original Alloy model by Daniel Jackson distributed with the Alloy Analyzer.
