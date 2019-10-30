(define (problem lab2_problem) 
    (:domain lab2_domain)
(:objects 
    ; main characters in the game
    robot target - player
 
    ; Number of column or row (N)
    zero one two three   - coord  ; in this case N = 4

    ; time steps 
)

(:init 
    ; Initial conditions
    (not (catch robot target))
    
    (= (cost robot) 0)
    (at robot zero zero)       ; initial position robot


    (at target two two)    ; initial position target DEFINE THE MOOVEMENTS
    

    
    ; Columns or rows that they are adjacent and one unit greater
    (unit_greater three two)
    (unit_greater two one)
    (unit_greater one zero)
   
    ; Grid NXN 
    ; we impose which columns or rows are bigger than the others
    (bigger one zero) (bigger two zero) (bigger three zero) 
    (bigger two one) (bigger three one)                  
    (bigger three two)                               

)

(:metric minimize (cost robot))

; GOAL:
(:goal  ( or (and (at robot two two) (catch robot target)) ; the robot has caught the moving agent 
            (= (cost robot) 16 ))
)      

)