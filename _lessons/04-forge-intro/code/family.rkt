#lang forge

---------------- Signatures ----------------

abstract sig Person {
  children: set Person,
  siblings: set Person,
  parents : set Person,
  spouse  : set Person
}

sig Man, Woman extends Person {}

pred married [p : Person] { some p.spouse }

---------------- Facts ----------------

-- parents is symmetric of children
pred parentsSymmChidren { parents = ~children }

-- No person can be their own ancestor
pred noOwnAncestor { no p: Person | p in p.^parents }

-- No person can have more than one father or mother
pred noMultParents { all p: Person | (lone (p.parents & Man)) and (lone (p.parents & Woman)) }

-- A person P's siblings are those people with the same parentss as P (excluding P)
pred defineSiblings {  all p: Person | p.siblings = {q: Person | p.parents = q.parents} - p }

-- Each married man (woman) has a wife (husband)
pred heterossexualMarriage
{  all p: Person | let s = p.spouse |
     married[p] implies
       ((p in Man implies s in Woman) and
        (p in Woman implies s in Man))}

-- A spouse can't be a siblings
pred noIncest { no p: Person | married[p] and p.spouse in p.siblings}

pred invariants {
  parentsSymmChidren and noOwnAncestor and
  noMultParents and defineSiblings and
  heterossexualMarriage and noIncest
}

--run {invariants and some spouse}

inst myInst {
             Person = M1 + M2 + W1 + W2
             Man = M1 + M2
             Woman = W1 + W2
             spouse = M1->W1 + M2->W2
             siblings = M1->M2
             }

example myTest is {no p : Person | married[p] and p.spouse in p.siblings } for myInst



--run { some p : Person | p.spouse in p.siblings} for myInst
