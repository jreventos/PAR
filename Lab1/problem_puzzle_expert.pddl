(define (problem puzzle_expert) 
    (:domain lunar_lockout_game)
(:objects 
    ; the red spacecraft & helper spacecrafts
    red orange yellow green blue purple - spacecraft
 
    ; Number of column or row
    s1 s2 s3 s4 s5  - locations

)

(:init 
    ; PUZZLE expert level
    (spacecraft_at red s5 s5) ; initial position red spacecraft
    (spacecraft_at orange s1 s1) (spacecraft_at yellow s1 s3) (spacecraft_at green s3 s1) (spacecraft_at purple s5 s1) (spacecraft_at blue s1 s5) ; initial position helpers

    ; Columns or rows that they are adjacent and one unit greater
    (adj_unit_greater s5 s4)
    (adj_unit_greater s4 s3)
    (adj_unit_greater s3 s2)
    (adj_unit_greater s2 s1)
    
    ; Grid 5x5
    ; we impose which columns or rows are bigger than the others
    (bigger s2 s1) (bigger s3 s1) (bigger s4 s1) (bigger s5 s1)    ; for the s1 
    (bigger s3 s2) (bigger s4 s2) (bigger s5 s2)                   ; for the s2
    (bigger s4 s3) (bigger s5 s3)                                  ; for the s3 
    (bigger s5 s4)                                                 ; for the s4
                                                                

    ; we impose which columns or rows are lower than the others
    (lower s1 s2) (lower s1 s3) (lower s1 s4) (lower s1 s5)        ; for the s1 
    (lower s2 s3) (lower s2 s4) (lower s2 s5)                      ; for the s2
    (lower s3 s4) (lower s3 s5)                                    ; for the s3 
    (lower s4 s5)                                                  ; for the s4


    (= (total_moves) 0)
)

(:metric minimize(total_moves))

; GOAL: the red spacecraft on the middle square  
(:goal (and (spacecraft_at red s3 s3)))
)