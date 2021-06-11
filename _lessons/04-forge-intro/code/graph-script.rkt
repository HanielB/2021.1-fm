#lang forge/core

(set-option! 'solver 'MiniSatProver)
(set-option! 'logtranslation 1)
(set-option! 'coregranularity 1)
(set-option! 'core_minimization 'rce) ; try 'hybrid if slow

(require "graph.rkt")

(define bostonNeighbors (+ Boston Prov NYC))

(run findSource
     #:preds[(some ([v Vertex])
                   (source v))
             (= (join Boston edges) bostonNeighbors)
             (in (-> Boston Worc) edges)]
     #:scope[(Vertex 5 5)])

(is-sat? findSource)
