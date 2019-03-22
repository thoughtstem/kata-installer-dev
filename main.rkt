#lang racket

(provide pre-installer post-installer)

(require pkg-watcher 
         "./raco-util.rkt")


(define (pre-installer path)
  ;For some reason, we're running into issues with raco failing on some of our chromebooks.  I posted about it on the Racket mailing list.  When that happens, the pre-installer never runs. 

  ;Hack for now, remove all deps from kata-installer's info.rkt
  ;  Hopefully, that makes sure that we get here.

  (install-or-update!
     "tzinfo" 
     "gregor" 

     "https://github.com/thoughtstem/pkg-watcher.git#dev" 
     "https://github.com/thoughtstem/ratchet.git#dev"
     "https://github.com/thoughtstem/racket-chipmunk.git#dev"
     "https://github.com/thoughtstem/game-engine.git#dev"
     "https://github.com/thoughtstem/game-engine-rpg.git#dev"
     "https://github.com/thoughtstem/game-engine-demos.git?path=game-engine-demos-common#dev"
     "https://github.com/thoughtstem/TS-Languages.git?path=battlearena#dev"
     "https://github.com/thoughtstem/TS-Languages.git?path=battlearena-avengers#dev"
     "https://github.com/thoughtstem/TS-Languages.git?path=battlearena-fortnite#dev"
     "https://github.com/thoughtstem/TS-Languages.git?path=battlearena-starwars#dev"
     "https://github.com/thoughtstem/TS-Languages.git?path=fundamentals#dev"
     "https://github.com/thoughtstem/TS-Languages.git?path=k2#dev"
     "https://github.com/thoughtstem/TS-Languages.git?path=survival#dev"
     "https://github.com/thoughtstem/TS-Languages.git?path=survival-minecraft#dev"
     "https://github.com/thoughtstem/TS-Languages.git?path=survival-pokemon#dev"
     
     ))

;Gets called by raco automatically after setup
(define (post-installer path)
  (remove-callback! 'kata-installer/main) ;Old...
  (add-callback! 'kata-installer/update-backend) ;New...

  (priority-watch! 'pkg-watcher)    ;Meta, watch pkg-watcher itself
  (priority-watch! 'kata-installer) ;Meta, watch this very package too.

  (watch! 'ratchet)
  (watch! 'racket-chipmunk)
  (watch! 'game-engine)
  (watch! 'game-engine-rpg)
  (watch! 'game-engine-demos-common)

  (watch! 'battlearena-avengers)
  (watch! 'battlearena-fortnite)
  (watch! 'battlearena-starwars)
  (watch! 'battlearena)
  (watch! 'fundamentals)
  (watch! 'k2)
  (watch! 'survival-minecraft)
  (watch! 'survival-pokemon)
  (watch! 'survival))


