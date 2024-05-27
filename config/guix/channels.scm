(define-module (channels)
  #:use-module (guix channels))

(define saayix
  (channel
    (name 'saayix)
    (branch "main")
    (url "https://codeberg.org/look/saayix")
    (introduction
     (make-channel-introduction "12540f593092e9a177eb8a974a57bb4892327752"
                                (openpgp-fingerprint
                                 "3FFA 7335 973E 0A49 47FC  0A8C 38D5 96BE 07D3 34AB")))))

(define-public channels
  (cons* saayix %default-channels))

channels
