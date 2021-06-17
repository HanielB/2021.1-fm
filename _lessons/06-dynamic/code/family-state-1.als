
sig State {
--    successor : set State
    successor : one State
}

abstract sig Person {
  spouse: Person lone -> State,
  -- new
  children: set Person -> State,
  parents: Person set -> State,
  siblings: Person set -> State,
  alive: set State
}

sig Man, Woman extends Person {}

------------------ Auxiliary predicates ------------

-- Two persons are blood relatives at state s iff
-- they have a common ancestor at state s
pred BloodRelatives [p: Person, q: Person, s: State, ]  {
  some p.*(parents.s) & q.*(parents.s)
}

------------------ Constraints --------


fact invariants {
  -- Define the parents relation
  all s: State | parents.s = ~(children.s)

  -- A person P's siblings are those people with the same parents as P (excluding P)
  all s: State | all p: Person |
    p.siblings.s = { q: Person - p | some q.parents.s and
                                     p.parents.s = q.parents.s }

  -- No person can be their own ancestor
  all s: State | no p: Person | p in p.^(parents.s)

  -- No person can have more than one father or mother
  all s: State | all p: Person |
      lone (p.parents.s & Man) and
      lone (p.parents.s & Woman)

  -- Each married man (woman) has a wife (husband)
  all s: State | all p: Person |
        let s = p.spouse.s |
      (p in Man implies s in Woman) and
      (p in Woman implies s in Man)

  -- A spouse can't be a siblings
  all s: State | no p: Person |
           one p.spouse.s and p.spouse.s in p.siblings.s

  -- A person can't be married to a blood relative
  all s: State | no p: Person |
          one p.spouse.s and BloodRelatives [p, p.spouse.s, s]

  -- a person can't have children with a blood relative
  all s: State | all p, q: Person |
    (some p.children.s & q.children.s and p != q) implies
                not BloodRelatives [p, q, s]
}

run {#State > 1 and some p: Person | some p.children}  for 5