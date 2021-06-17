
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

------ Getting married now is with the next one

pred getMarried [p,q: Person, s,s': State] {
  -- Pre-condition : they must not be married
  no (p+q).spouse.s

  -- Post-condition : After marriage they are each other's spouses
  q in p.spouse.s'
  p in q.spouse.s'
}

run {linearOrder and some p,q : Person | some s : State | one s.successor and getMarried[p,q,s,s.successsor] } for exactly 2 Person, 2 State