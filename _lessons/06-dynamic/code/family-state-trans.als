
sig State {
    successor : set State
}

one sig Initial extends State {}

abstract sig Person {
  spouse: Person lone -> State,
}

sig Man, Woman extends Person {}


------ guaranteeing that successor is a total order on states

pred linearOrder {
  -- initial state is the start
  no s : State | Initial in s.successor

  -- irreflexive
  all s : State | s not in s.successor

  -- transitive
  all s1, s2 : State | s2 in s1.successor implies s1 in s2.successor

  -- antisymmetric
  all s1, s2 : State | (s2 in s1.successor and s1 in s2.successor) implies s1 = s2
}

fun last: one State { State - (State.successor) }

------ Getting married now is with the next one

pred getMarried [p,q: Person, s,s': State] {
  -- Pre-condition : they must not be married
  no (p+q).spouse.s

  -- Post-condition : After marriage they are each other's spouses
  q in p.spouse.s'
  p in q.spouse.s'
}

----- Transition System

-- Initial conditions
pred init [s: State] {
  no spouse.s
}

-- Transition relation
pred transition [s, s' : State] {
  some p,q: Person | getMarried [p, q, s, s']
}

-- System: all possible executions of the system from a state
-- that satisfies the init condition
pred System {
   init [Initial]
   all s : State - (State - (State.successor))| transition [s, s.successor]
}

run {linearOrder and System } for exactly 2 Person, 2 State