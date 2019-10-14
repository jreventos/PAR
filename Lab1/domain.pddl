;LUNAR LOCKOUT GAME : Description 

(define (domain lunar_lockout_game)
    (:requirements :strips :typing :adl :fluents )
   
    (:types locations spacecraft

    )

; PREDICATES 
(:predicates 
            (spacecraft_at ?red_or_helper -spacecraft ?col - locations ?row -locations)   ; spacecraft localization within the 5x5 board
            (bigger ?colrow1 - locations ?colrrow2 - locations)                           ; col/row 1 is bigger than col/row 2
            (lower ?colrow1 - locations ?colrow2 - locations)                             ; col/row 1 is lower than col/row 2
            (adj_unit_greater ?colrow1 - locations ?colrow2 -locations)                   ; col/row 1 is adjacent & 1 unit greater than col/row 2
) 

(:functions 
            (total_moves))

; ACTIONS

(:action move_right
    :parameters (?sc_moves ?sc_static - spacecraft                             ; we consider two spacecraft: the moving one (sc_moves) and the static one (static_sc)
                 ?row ?from_c ?to_c ?static_c - locations)                     ; we're always un the same row for a right movement, only columns change 
    
    :precondition (and
                       (spacecraft_at ?sc_moves ?from_c ?row)                  ; moving spacecraft localization
                       (spacecraft_at ?sc_static ?static_c ?row)               ; static spacecraft localization
                       (bigger ?to_c ?from_c)                                  ; always: final column position moving sc (to_c) > initial column (from_c)        
                       (bigger ?static_c ?to_c)                                ; always: static sc  column (static_c) > final column position red spacecraft (to_c)
                       (adj_unit_greater ?static_c ?to_c)                      ; columns of static sc and final position moving sct are 1 unit greater = adjacents 
                       (not(and (spacecraft_at ?sc_moves ?to_c ?row)           ; the moving sc & static sc are not located at the final position
                            (spacecraft_at ?sc_static ?to_c ?row)))            
                        (forall (?sc_others - spacecraft ?col - locations)     ; for all the other spacecrafts there's no sc between the moving sc and the static sc
                                (not (and (spacecraft_at ?sc_others ?col ?row) 
                                          (bigger ?col ?from_c)
                                          (bigger ?to_c ?col)))))
                        
    :effect(and (spacecraft_at ?sc_moves ?to_c ?row)                           ; moving sc goes to the square adjacent to the static sc             
                (not(spacecraft_at ?sc_moves ?from_c ?row))                    ; clear the initial position of the moving sc
                (increase (total_moves) 1)))

(:action move_left                                                             
    :parameters (?sc_moves ?sc_static - spacecraft                             
                ?row ?from_c ?to_c ?static_c - locations) 
    
    :precondition (and
                       (spacecraft_at ?sc_moves ?from_c ?row)  
                       (spacecraft_at ?sc_static ?static_c ?row) 
                       (lower ?to_c ?from_c) 
                       (lower ?static_c ?to_c)
                       (adj_unit_greater ?to_c ?static_c)
                       (not(and (spacecraft_at ?sc_moves ?to_c ?row) 
                                (spacecraft_at ?sc_static ?to_c ?row)))
                        (forall (?sc_others - spacecraft ?col - locations)
                                (not (and (spacecraft_at ?sc_others ?col ?row) 
                                      (bigger ?from_c ?col )
                                      (bigger ?col ?to_c)))))                                                    
    :effect(and (spacecraft_at ?sc_moves ?to_c ?row) 
                (not(spacecraft_at ?sc_moves ?from_c ?row))
                (increase (total_moves) 1 )))
                
(:action move_down
    :parameters (?sc_moves ?sc_static - spacecraft  
                 ?col ?from_r ?to_r ?static_r - locations) 
    
    :precondition (and
                       (spacecraft_at ?sc_moves ?col ?from_r)  
                       (spacecraft_at ?sc_static ?col ?static_r) 
                       (bigger ?to_r ?from_r)          
                       (bigger ?static_r ?to_r) 
                       (adj_unit_greater ??static_r ?to_r)
                       (not(and (spacecraft_at ?sc_moves ?col ?to_r) 
                            (spacecraft_at ?sc_static ?col ?to_r)))
                        (forall (?sc_others - spacecraft ?row - locations)
                                (not (and (spacecraft_at ?sc_others ?col ?row) 
                                          (bigger ?row ?from_r)
                                          (bigger ?to_r ?row)))))
                                
    :effect(and (spacecraft_at ?sc_moves ?col ?to_r) 
                (not(spacecraft_at ?sc_moves ?col ?from_r))
                (increase (total_moves) 1)))
                
(:action move_up
    :parameters (?sc_moves ?sc_static - spacecraft  
                 ?col ?from_r ?to_r ?static_r - locations) 
    
    :precondition (and
                       (spacecraft_at ?sc_moves ?col ?from_r)  
                       (spacecraft_at ?sc_static ?col ?static_r) 
                       (lower ?to_r ?from_r)           
                       (lower ?static_r ?to_r)
                       (adj_unit_greater ?to_r ?static_r)
                       (not(and (spacecraft_at ?sc_moves ?col ?to_r) 
                            (spacecraft_at ?sc_static ?col ?to_r)))
    
                       (forall (?sc_others - spacecraft ?row - locations)
                                (not (and (spacecraft_at ?sc_others ?col ?row) 
                                          (bigger ?from_r ?row)
                                          (bigger ?row ?to_r)))))    
                                
    :effect(and (spacecraft_at ?sc_moves ?col ?to_r) 
                (not(spacecraft_at ?sc_moves ?col ?from_r))
                (increase (total_moves) 1)))
)