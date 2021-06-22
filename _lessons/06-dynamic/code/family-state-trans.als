
sig State {
    successor : set State,
    prev : set State
}

one sig Initial extends State {}

abstract sig Person {
  spouse: Person lone -> State,
  -- new
  children: set Person -> State,
  parents: Person set -> State,
  siblings: Person set -> State,
  alive: set State
}

sig Man, Woman extends Person {}

------------------ Linear order on State ------------

fact linearOrder {
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
    -- prev is symmetric of successor
    prev = ~successor
}

fun last: one State { State - (successor.State) }

------ Getting married now is with the next one

pred getMarried [p,q: Person, s,s': State] {
  -- Pre-condition : they must be alive, must not be married
  p+q in alive.s
  no (p+q).spouse.s

  -- Post-condition : After marriage they are each other's spouses
  q in p.spouse.s'
  p in q.spouse.s'
}

----- Transition System

-- Initial conditions
pred init [s: State] {
  no spouse.s
  #alive.s > 1
}

-- Transition relation
pred transition [s, s' : State] {
  some p,q: Person | getMarried [p, q, s, s']
}

-- System: all possible executions of the system from a state
-- that satisfies the init condition
pred System {
   init [Initial]
   all s : State - last | transition [s, s.successor]
}

run {System } for exactly 2 Person, exactly 2 State