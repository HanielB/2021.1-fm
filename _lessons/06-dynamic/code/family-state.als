
sig State {
    successor : set State
}

abstract sig Person {
  spouse: Person lone -> State,
}

sig Man, Woman extends Person {}

pred getMarried [p,q: Person, s,s': State] {
  -- Pre-condition
   -- they must not be married
  no (p+q).spouse.s
  -- Post-condition
   -- After marriage they are each other's spouses
  q in p.spouse.s'
  p in q.spouse.s'
}

run {some p,q : Person | some s,s' : State | getMarried[p,q,s,s'] }

-- run {some p,q : Person | some s,s' : State | getMarried[p,q,s,s'] and no s : State | s in s.successor} for exactly 2 Person, 2 State