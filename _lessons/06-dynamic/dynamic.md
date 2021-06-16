---
layout: page
title: Dynamic systems
---

# Dynamic systems
{: .no_toc .mb-2 }

- TOC
{:toc}

## Readings

## A simple state machine and several properties:

A state machine is a directed graph that models how a system moves from State to
State as it executes. It has one or more marked Initial (or starting) states,
and edges connecting each state to its successor(s). An initial state can be the
successor of another state. Let's write the following predicates that describe
different properties of state machines:

- there is at least one initial state

- a deterministic machine, in which there is one initial state and each state
  has at most one successor

- a nondeterministic machine, in which there are multiple initial states, or
  where at least one state has more than one successor, or both

- a machine with at least one state that is unreachable from any initial state

- a machine where all states are reachable from some initial state (it need not
  be the same initial state for each one)

- a connected machine in which every state is reachable (along the successor
  relation) from every other state

- a machine with a deadlock: a machine with a state that is reachable from an
  initial state, but has no successors

- a machine with a livelock: a machine where there exists some cycle reachable
  from an initial state and a state (the “livelocked” state) reachable from the
  cycle that’s not part of the cycle. Note that this livelocked state cannot be
  reached at any point before reaching the cycle or in the cycle itself.

### Code

- Alloy anaylizer version:
  - [state_machine.als]({{ site.baseurl }}{% link _lessons/06-dynamic/code/state_machine.als %})
- Forge version:
  - [state_machine.rkt]({{ site.baseurl }}{% link _lessons/06-dynamic/code/state_machine.rkt %})

## Making the family model dynamic:

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

The above (together with an example run command) can be found [here]({{ site.baseurl }}{% link _lessons/06-dynamic/code/family-state.als %}).

## Acknowledgments

Thanks to Tim Nelson for sharing examples about the state machine model. Thanks for Cesare Tinelli for the family model material, itself based on the original Alloy model by Daniel Jackson.
