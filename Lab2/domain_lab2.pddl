;HOMWORK 2

(define (domain lab2_domain)
    (:requirements :strips :typing :adl :fluents)
   
    (:types coord player step 

    )

; PREDICATES 
(:predicates 
            (at ?player - player ?col - coord ?row -coord)
            (bigger ?colrow1 - coord ?colrrow2 - coord)                           ; col/row 1 is bigger than col/row 2
            (unit_greater ?colrow1 - coord ?colrow2 -coord)                       ; col/row 1 is adjacent & 1 unit greater than col/row 2
            (catch ?robot - player ?target - player)
) 

(:functions 
            (cost ?player - player)
            (next_step ?player - player ?col - coord ?row -coord)
            
)

; ACTIONS


(:action move_up
    :parameters ( ?player - player
                 ?col ?from_r ?to_r  - coord)
    
    :precondition (and
                       (at ?player ?col ?from_r)
                       (bigger  ?from_r ?to_r)
                       (unit_greater ?from_r ?to_r))
                                
    :effect(and (at ?player ?col ?to_r)
                (increase (cost ?player) 1))
)


(:action move_down
    :parameters ( ?player - player
                 ?col ?from_r ?to_r  - coord)
    
    :precondition (and
                       (at ?player ?col ?from_r)
                       (bigger  ?to_r ?from_r)
                       (unit_greater ?to_r ?from_r))
                                
    :effect(and (at ?player ?col ?to_r)
                (increase (cost ?player) 1))
)  
                                

(:action move_left                                                             
    :parameters (?player - player                            
                ?row ?from_c ?to_c - coord) 

    :precondition (and
                       (at ?player ?from_c ?row)
                       (bigger ?to_c ?from_c)
                       (unit_greater ?to_c ?from_c))

    :effect(and (at ?player ?to_c? ?row) 
                (increase (cost ?player)1))
)

(:action move_right                                                             
    :parameters (?player - player                            
                ?row ?from_c ?to_c - coord) 

    
    :precondition (and
                       (at ?player ?from_c ?row)
                       (bigger ?from_c ?to_c)
                       (unit_greater ?from_c ?to_c))

    :effect(and (at ?player ?to_c? ?row) 
                (increase (cost ?player) 1))
)            


(:action stop
    :parameters (?robot - player ?target - player 
                ?col - coord ?row - coord)
                
    :precondition (and
                  (at ?robot ?col ?row)
                  (at ?target ?col ?row))

    :effect (catch ?robot ?target)
        
)

)