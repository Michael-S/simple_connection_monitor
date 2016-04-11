#!/usr/bin/guile -s
!#

; Copyright Mike Swierczek, 2016
; released under the GNU Public License v3 or any later version of the GNU Public License
; A copy of the license should be included in a LICENSE.txt file

; This is a simple script to run as root and reconnect your wifi connection
; if it detects a drop.  Just change the line starting with (system "nmcli...
; to modify it to your needs. 

(use-modules (srfi srfi-19))
(display "Connection monitor started. ")
(display (date->string (current-date) "~c"))
(newline)
(define (check-con)
    (let ((status (system "ping -c 1 -W 2 192.168.1.1 > /dev/null")))
        (if (= 0 status)
            (sleep 5)
            (begin
               (display "Loss of connection at ")
               (display (date->string (current-date) "~c"))
               (newline)
               (display "Attempting reconnect.")
               (newline)
               (system "nmcli --ask c up ifname wlp3s0 ap 'guywalksintoabar'")
               (display "Hopefully the reconnect succeeded.")
               (newline))))
    (check-con))

; this catch block didn't work
;(catch #t (check-con) 
;    ; error/exception handler
;    (begin
;       (display "Exception or interruption.  Exiting.")
;       (newline)
;       (quit)))
(define (exiting-notification x) 
     (display "Exception or interruption. Signal ")
     (display x)
     (display ". Exiting.")
     (newline)
     (quit))

; signal 2 is SIGINT (interrupt)
(sigaction 2 exiting-notification)
; signal 3 is SIGQUIT (another quit signal, not sure how often it's used)
(sigaction 3 exiting-notification)
; signal 15 is SIGTERM. I think that is the usual Ctrl-C signal
(sigaction 15 exiting-notification)
(check-con)
 



