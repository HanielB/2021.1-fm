---
layout: page
title: Ordering
---

# Ordering
{: .no_toc .mb-2 }

A common property we can enforce to sets is that their elements are
ordered. This notion can be useful in many scenarios, but particularly so when
we are interesting in specifying dynamic states, where it is paramount to
capture that systems transition between states in an ordered fashion.

We discuss here how to specify that a given set of states is ordered.

## Linear order

Let's consider a simple state machine:

```alloy
sig State {
    successor : set State
}

one sig Initial extends State {}
```

How do we enforce that its states are *strictly linearly totally* ordered, i.e. its `successor`
relation starts on the `Initial` state, ends on a state that has no successors,
there are no self successors, and every state is not a successor of another?

``` alloy
pred linearOrder {
    -- no cycles, each state has at most one successor
    all s: State {
        lone s.successor
        s not in s.^successor
    }
    -- there is one final state
    one s: State | no s.successor
    -- there is one initial state, which is Initial
    one s: State | no successor.s
    no s : State - Initial | some s.successor & Initial
    -- no self loops
    no iden & successor
}
```

## Final state

Given Alloy's restriction to finite models, our orders have final states. How do
we refer to it?

An alternative is to define a new signature extending `State`, i.e.

``` alloy
one sig Final extends State {}
```

which we restrict, in the `linearOrder` predicate, to be *the* final state:

``` alloy
-- the final state is Final
no s : State - Final | s in Final.successor
```

This alternative has the downside of forcing `Final` to be different from
`Initial`. An alternative is to define a function which yields the final state
that is guaranteed to exist by the regular definition of `linearOrder`:

``` alloy
fun final : one State { { s : State | no s.successor } }
```

Note that this definition is equivalent to

``` alloy
fun final : one State { State - successor.State }
```

## Initial state as a function

The above reasoning can be applied to the initial state as well. Since
`linearOrder` forces the existence of an initial state we can define a function
which produces precisely it:

``` alloy
fun first : one State { State - State.successor }
```

## An ordered simple state machine

``` alloy
sig State {
    successor : set State,
    prev : set State
}

fact linearOrder {
    -- no cycles, each state has at most one successor
    all s: State {
        lone s.successor
        s not in s.^successor
    }
    -- there is one final state
    one s: State | no s.successor
    -- there is one initial state
    one s: State | no successor.s
    -- no self loops
    no iden & successor
    -- prev is symmetric of successor
    prev = ~successor
}

fun first : one State { State - State.successor }
fun final : one State { State - successor.State }

```
