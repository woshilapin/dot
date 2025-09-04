(define-module (channels)
  #:use-module (guix channels))

(define saayix
  (channel
    (name 'saayix)
    (branch "main")
    (url "https://codeberg.org/look/saayix.git")
    (introduction
     (make-channel-introduction "12540f593092e9a177eb8a974a57bb4892327752"
                                (openpgp-fingerprint
                                 "3FFA 7335 973E 0A49 47FC  0A8C 38D5 96BE 07D3 34AB")))))

;; The channel needs to be updated to the new Rust packaging model
(define tuziwo
  (channel
    (name 'tuziwo)
    (branch "main")
    (url "https://gitlab.com/woshilapin/tuziwo-channel")
    (introduction
     (make-channel-introduction "0deff2a94032f2d96e82f93edeb61f35da879987"
                                (openpgp-fingerprint
                                 "5554 54E7 6611 9F60 80F1  2F63 B041 63DC 7020 116A")))))

(define-public channels
  (cons* saayix %default-channels))

channels
