; Procedure Subtract
SubtractBody
    LDR     R2, =4
    LDR     R5, [R4, R2, LSL #2] ; i
    LDR     R6, =1
    SUB     R5, R5, R6
    LDR     R2, =4
    STR     R5, [R4, R2, LSL #2] ; i
    MOV     TOP, BP         ; reset top of stack
    LDR     BP, [TOP,#12]   ; and stack base pointers
    LDR     PC, [TOP]       ; return from Subtract
Subtract
    LDR     R0, =2          ; current lexic level
    LDR     R1, =0          ; number of local variables
    BL      enter           ; build new stack frame
    B       SubtractBody
; Procedure Assign
AssignBody
    LDR     R5, =1
    MOV     R2, BP          ; load current base pointer
    LDR     R2, [R2,#8]
    ADD     R2, R2,#16
    STR     R5, [R2]        ; j
    MOV     TOP, BP         ; reset top of stack
    LDR     BP, [TOP,#12]   ; and stack base pointers
    LDR     PC, [TOP]       ; return from Assign
Assign
    LDR     R0, =2          ; current lexic level
    LDR     R1, =0          ; number of local variables
    BL      enter           ; build new stack frame
    B       AssignBody
; Procedure Add
AddBody
    LDR     R2, =4
    LDR     R5, [R4, R2, LSL #2] ; i
    LDR     R6, =0
    CMP     R5, R6
    MOVGT   R5, #1
    MOVLE   R5, #0
    MOVS    R5, R5          ; reset Z flag in CPSR
    BEQ     L1              ; jump on condition false
    MOV     R2, BP          ; load current base pointer
    LDR     R2, [R2,#8]
    ADD     R2, R2, #16
    LDR     R1, =1
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; sum
    LDR     R2, =4
    LDR     R6, [R4, R2, LSL #2] ; i
    ADD     R5, R5, R6
    MOV     R2, BP          ; load current base pointer
    LDR     R2, [R2,#8]
    ADD     R2, R2, #16
    LDR     R1, =1
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; sum
    ADD     R0, PC, #4      ; store return address
    STR     R0, [TOP]       ; in new stack frame
    B       Subtract
    ADD     R0, PC, #4      ; store return address
    STR     R0, [TOP]       ; in new stack frame
    B       Add
    MOV     R2, BP          ; load current base pointer
    LDR     R2, [R2,#8]
    ADD     R2, R2,#16
    ADD     R0, PC, #4      ; store return address
    STR     R0, [TOP]       ; in new stack frame
    B       Assign
    B       L2
L1
L2
    MOV     TOP, BP         ; reset top of stack
    LDR     BP, [TOP,#12]   ; and stack base pointers
    LDR     PC, [TOP]       ; return from Add
Add
    LDR     R0, =2          ; current lexic level
    LDR     R1, =0          ; number of local variables
    BL      enter           ; build new stack frame
    B       AddBody
; Procedure SumUp
SumUpBody
    LDR     R5, =5
    LDR     R2, =2
    STR     R5, [R4, R2, LSL #2] ; limit
    LDR     R5, =1
    LDR     R2, =3
    STR     R5, [R4, R2, LSL #2] ; doThis
    LDR     R5, =1
    LDR     R2, =1
    STR     R5, [R4, R2, LSL #2] ; place
L3
    LDR     R2, =1
    LDR     R5, [R4, R2, LSL #2] ; place
    LDR     R2, =2
    LDR     R6, [R4, R2, LSL #2] ; limit
    CMP     R5, R6
    MOVLE   R5, #1
    MOVGT   R5, #0
    MOVS    R5, R5          ; reset Z flag in CPSR
    BEQ     L0              ; jump on condition false
    LDR     R2, =1
    LDR     R5, [R4, R2, LSL #2] ; place
    LDR     R6, =1
    ADD     R5, R5, R6
    LDR     R2, =1
    STR     R5, [R4, R2, LSL #2] ; place
    LDR     R2, =3
    LDR     R5, [R4, R2, LSL #2] ; doThis
    LDR     R6, =1
    ADD     R5, R5, R6
    LDR     R2, =3
    STR     R5, [R4, R2, LSL #2] ; doThis
    B       L3
L0
    LDR     R5, =1
    LDR     R2, =5
    STR     R5, [R4, R2, LSL #2] ; x
    LDR     R5, =2
    LDR     R2, =6
    STR     R5, [R4, R2, LSL #2] ; y
    LDR     R2, =5
    LDR     R5, [R4, R2, LSL #2] ; x
    LDR     R2, =6
    LDR     R6, [R4, R2, LSL #2] ; y
    CMP     R5, R6
    MOVLT   R5, #1
    MOVGE   R5, #0
    MOVS    R5, R5          ; reset Z flag in CPSR
    BEQ     L4              ; jump on condition false
    LDR     R2, =5
    LDR     R5, [R4, R2, LSL #2] ; x
    LDR     R6, =1
    ADD     R5, R5, R6
    B       L5
L4
    LDR     R2, =1
    STR     R5, [R4, R2, LSL #2] ; place
    LDR     R2, =6
    LDR     R5, [R4, R2, LSL #2] ; y
    LDR     R6, =1
    SUB     R5, R5, R6
L5
    LDR     R2, =1
    STR     R5, [R4, R2, LSL #2] ; place
    LDR     R2, =4
    LDR     R5, [R4, R2, LSL #2] ; i
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; j
    LDR     R5, =0
    LDR     R2, =7
    STR     R5, [R4, R2, LSL #2] ; variable
    LDR     R5, =1
    LDR     R5, =1
    CMP     R5, R5
    MOVEQ   R5, #1
    MOVNE   R5, #0
    MOVS    R5, R5          ; reset Z flag in CPSR
    BEQ     L6              ; jump on condition false
    LDR     R5, =1
    LDR     R2, =7
    STR     R5, [R4, R2, LSL #2] ; variable
    B       L0
    LDR     R5, =2
    CMP     R5, R5
    MOVEQ   R5, #1
    MOVNE   R5, #0
    MOVS    R5, R5          ; reset Z flag in CPSR
    BEQ     L7              ; jump on condition false
    LDR     R5, =1
    LDR     R2, =7
    STR     R5, [R4, R2, LSL #2] ; variable
    B       L0
    LDR     R5, =12
    LDR     R2, =7
    STR     R5, [R4, R2, LSL #2] ; variable
    B       L0
    LDR     R5, =1
    LDR     R5, =2
    LDR     R5, =3
    LDR     R5, =0
    ADD     R2, BP, #16
    LDR     R1, =1
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; sum
    ADD     R0, PC, #4      ; store return address
    STR     R0, [TOP]       ; in new stack frame
    B       Add
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L8
    DCB     "The sum of the values from 1 to ", 0
    ALIGN
L8
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; j
    MOV     R0, R5
    BL      TastierPrintInt
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L9
    DCB     " is ", 0
    ALIGN
L9
    ADD     R2, BP, #16
    LDR     R1, =1
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; sum
    MOV     R0, R5
    BL      TastierPrintIntLf
    MOV     TOP, BP         ; reset top of stack
    LDR     BP, [TOP,#12]   ; and stack base pointers
    LDR     PC, [TOP]       ; return from SumUp
SumUp
    LDR     R0, =1          ; current lexic level
    LDR     R1, =2          ; number of local variables
    BL      enter           ; build new stack frame
    B       SumUpBody
;Name:j Const:False Type:intr Kind:var, Level:local
;Name:sum Const:False Type:intr Kind:var, Level:local
;Name:Subtract Const:False Type:undef Kind:proc, Level:local
;Name:Assign Const:False Type:undef Kind:const, Level:local
;Name:Add Const:False Type:undef Kind:proc, Level:local
MainBody
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L10
    DCB     "Enter value for i (or 0 to stop): ", 0
    ALIGN
L10
    BL      TastierReadInt
    LDR     R2, =4
    STR     R0, [R4, R2, LSL #2] ; i
L11
    LDR     R2, =4
    LDR     R5, [R4, R2, LSL #2] ; i
    LDR     R6, =0
    CMP     R5, R6
    MOVGT   R5, #1
    MOVLE   R5, #0
    MOVS    R5, R5          ; reset Z flag in CPSR
    BEQ     L12              ; jump on condition false
    ADD     R0, PC, #4      ; store return address
    STR     R0, [TOP]       ; in new stack frame
    B       SumUp
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L13
    DCB     "Enter value for i (or 0 to stop): ", 0
    ALIGN
L13
    BL      TastierReadInt
    LDR     R2, =4
    STR     R0, [R4, R2, LSL #2] ; i
    B       L11
L12
StopTest
    B       StopTest
Main
    LDR     R0, =1          ; current lexic level
    LDR     R1, =0          ; number of local variables
    BL      enter           ; build new stack frame
    B       MainBody
;Name:holder Const:False Type:bool Kind:var, Level:globul
;Name:place Const:False Type:intr Kind:var, Level:globul
;Name:limit Const:False Type:intr Kind:var, Level:globul
;Name:doThis Const:False Type:intr Kind:var, Level:globul
;Name:i Const:False Type:intr Kind:var, Level:globul
;Name:x Const:False Type:intr Kind:var, Level:globul
;Name:y Const:False Type:intr Kind:var, Level:globul
;Name:variable Const:False Type:intr Kind:var, Level:globul
;Name:SumUp Const:False Type:undef Kind:proc, Level:globul
;Name:main Const:False Type:undef Kind:proc, Level:globul
