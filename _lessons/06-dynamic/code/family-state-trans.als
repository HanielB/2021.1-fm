sig State {
    successor : set State,
    prev : set State
}

abstract sig Person {
  spouse: Person lone -> State,
  children: set Person -> State,
  alive: set State
}

sig Man, Woman extends Person {}

fun parents [s : State] : Person -> Person {~(children.s)}

fun siblings [p: Person, s: State]: Person {
  { q : Person - p | some q.(parents[s]) and p.(parents[s]) = q.(parents[s]) }
}

------------------ Linear order on State ------------

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

-- Auxiliary

pred BloodRelatives [p: Person, q: Person, s: State, ]  {
  some a: Person | p+q in a.*(children.s)
}

-- frame condition predicates

pred noChildrenChangeExcept[ps : set Person, s, s' : State] {
  all p : Person - ps | p.children.s = p.children.s'
}

pred noSpouseChangeExcept[ps : set Person, s, s' : State] {
  all p : Person - ps | p.spouse.s = p.spouse.s'
}

pred noAliveChange[s, s' : State] {
  alive.s' = alive.s
}

-- operations
pred getDivorced [p,q : Person, s, s' : State] {
  -- pre-condition: not married yet
  q in p.spouse.s
  p in q.spouse.s
  -- post-condition: they're married
  no (p+q).spouse.s'
  -- frame conditions
  noChildrenChangeExcept[none, s, s']
  noSpouseChangeExcept[p+q, s, s']
  noAliveChange[s, s']
}

pred getMarried [p,q : Person, s, s' : State] {
  -- pre-condition: not married yet, they're alive, not blood relatives
  no (p+q).spouse.s
  p+q in alive.s
  not BloodRelatives[p,q,s]
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

pred dies [p: Person, s,s': State] {
  -- Pre-condition
     p in alive.s
  -- Post-condition
     no p.spouse.s'

  -- Post-condition and frame condition
     alive.s' = alive.s - p
     all sp: p.spouse.s | sp.spouse.s' = sp.spouse.s - p

  -- Frame condition
     noChildrenChangeExcept [none, s, s']
     noSpouseChangeExcept [p + p.spouse.s, s, s']
}

-- Transition System

-- Initial conditions
pred init [s : State] {
  no spouse.s
  no children.s
  #alive.s > 2
  #Person = #alive.s
}

-- Transition relation
pred transition [s, s' : State] {
  (some p, q : Person | getMarried[p,q, s, s'])
  or
  (some p, q : Person | getDivorced[p,q,s,s'])
  or
  (some p: Person, m: Man, w: Woman | isBornFromParents [p, m, w, s, s'])
  or
  (some p : Person | dies[p,s,s'])
}

-- System: all possible executions of the system from a state that satisfies the init condition
pred system {
  init[first]
  all s : State - final | transition[s, s.successor]
}

pred marriedAndDivorced {
  some s1,s2 : State - first | some p,q : Person |
      s2 in s1.^successor and p !in q.spouse.s2 and q !in p.spouse.s2 and p in q.spouse.s1 and q in p.spouse.s1
}

-- run {system and marriedAndDivorced}

-- Only living people can be married
assert a0 {
  system => all s: State | all p: Person |
             (some p.spouse.s) => p in alive.s
}
check a0 for 10 but 6 State

-- Only living people can have children
assert a1 {
  system => all s: State | all p: Person |
             (some p.children.s) => p in alive.s
}
check a1 for 10 but 6 State

-- No person can be their own ancestor
assert a2 {
  system => all s: State | no p: Person | p in p.^(parents[s])
}
check a2 for 10 but 6 State
