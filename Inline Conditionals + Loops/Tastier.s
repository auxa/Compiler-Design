; Procedure Subtract
SubtractBody
    LDR     R0, =4
    LDR     R5, [R4, R0, LSL #2] ; i
    LDR     R6, =1
    SUB     R5, R5, R6
    LDR     R0, =4
    STR     R5, [R4, R0, LSL #2] ; i
    MOV     TOP, BP         ; reset top of stack
    LDR     BP, [TOP,#12]   ; and stack base pointers
    LDR     PC, [TOP]       ; return from Subtract
Subtract
    LDR     R0, =2          ; current lexic level
    LDR     R1, =0          ; number of local variables
    BL      enter           ; build new stack frame
    B       SubtractBody
; Procedure Add
AddBody
    LDR     R0, =4
    LDR     R5, [R4, R0, LSL #2] ; i
    LDR     R6, =0
    CMP     R5, R6
    MOVGT   R5, #1
    MOVLE   R5, #0
    MOVS    R5, R5          ; reset Z flag in CPSR
    BEQ     L1              ; jump on condition false
    B       L2
L1
L2
    MOV     R0, BP          ; load current base pointer
    LDR     R0, [R0,#8]
    ADD     R0, R0, #16
    LDR     R1, =1
    LDR     R5, [R0, R1, LSL #2] ; sum
    LDR     R0, =4
    LDR     R6, [R4, R0, LSL #2] ; i
    ADD     R5, R5, R6
    MOV     R0, BP          ; load current base pointer
    LDR     R0, [R0,#8]
    ADD     R0, R0, #16
    LDR     R1, =1
    STR     R5, [R0, R1, LSL #2] ; sum
    ADD     R0, PC, #4      ; store return address
    STR     R0, [TOP]       ; in new stack frame
    B       Subtract
    ADD     R0, PC, #4      ; store return address
    STR     R0, [TOP]       ; in new stack frame
    B       Add
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
    LDR     R0, =2
    STR     R5, [R4, R0, LSL #2] ; limit
    LDR     R5, =1
    LDR     R0, =3
    STR     R5, [R4, R0, LSL #2] ; doThis
    LDR     R5, =1
    LDR     R0, =1
    STR     R5, [R4, R0, LSL #2] ; place
L3
    LDR     R0, =1
    LDR     R5, [R4, R0, LSL #2] ; place
    LDR     R0, =2
    LDR     R6, [R4, R0, LSL #2] ; limit
    CMP     R5, R6
    MOVLE   R5, #1
    MOVGT   R5, #0
    MOVS    R5, R5          ; reset Z flag in CPSR
    BEQ     L0              ; jump on condition false
    LDR     R0, =1
    LDR     R5, [R4, R0, LSL #2] ; place
    LDR     R6, =1
    ADD     R5, R5, R6
    LDR     R0, =1
    STR     R5, [R4, R0, LSL #2] ; place
    LDR     R0, =3
    LDR     R5, [R4, R0, LSL #2] ; doThis
    LDR     R6, =1
    ADD     R5, R5, R6
    LDR     R0, =3
    STR     R5, [R4, R0, LSL #2] ; doThis
    B       L3
L0
    LDR     R5, =1
    LDR     R0, =5
    STR     R5, [R4, R0, LSL #2] ; x
    LDR     R5, =2
    LDR     R0, =6
    STR     R5, [R4, R0, LSL #2] ; y
    LDR     R0, =5
    LDR     R5, [R4, R0, LSL #2] ; x
    LDR     R0, =6
    LDR     R6, [R4, R0, LSL #2] ; y
    CMP     R5, R6
    MOVLT   R5, #1
    MOVGE   R5, #0
    MOVS    R5, R5          ; reset Z flag in CPSR
    BEQ     L4              ; jump on condition false
    LDR     R0, =5
    LDR     R5, [R4, R0, LSL #2] ; x
    LDR     R6, =1
    ADD     R5, R5, R6
    B       L5
L4
    LDR     R0, =1
    STR     R5, [R4, R0, LSL #2] ; place
    LDR     R0, =6
    LDR     R5, [R4, R0, LSL #2] ; y
    LDR     R6, =1
    SUB     R5, R5, R6
L5
    LDR     R0, =1
    STR     R5, [R4, R0, LSL #2] ; place
    LDR     R0, =4
    LDR     R5, [R4, R0, LSL #2] ; i
    STR     R5, [BP,#16]    ; j
    LDR     R5, =1
    LDR     R5, =2
    LDR     R5, =3
    LDR     R5, =0
    ADD     R0, BP, #16
    LDR     R1, =1
    STR     R5, [R0, R1, LSL #2] ; sum
    ADD     R0, PC, #4      ; store return address
    STR     R0, [TOP]       ; in new stack frame
    B       Add
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L6
    DCB     "The sum of the values from 1 to ", 0
    ALIGN
L6
    LDR     R5, [BP,#16]    ; j
    MOV     R0, R5
    BL      TastierPrintInt
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L7
    DCB     " is ", 0
    ALIGN
L7
    ADD     R0, BP, #16
    LDR     R1, =1
    LDR     R5, [R0, R1, LSL #2] ; sum
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
;Name:Add Const:False Type:undef Kind:proc, Level:local
MainBody
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L8
    DCB     "Enter value for i (or 0 to stop): ", 0
    ALIGN
L8
    BL      TastierReadInt
    LDR     R0, =4
    STR     R0, [R4, R0, LSL #2] ; i
L9
    LDR     R0, =4
    LDR     R5, [R4, R0, LSL #2] ; i
    LDR     R6, =0
    CMP     R5, R6
    MOVGT   R5, #1
    MOVLE   R5, #0
    MOVS    R5, R5          ; reset Z flag in CPSR
    BEQ     L10              ; jump on condition false
    ADD     R0, PC, #4      ; store return address
    STR     R0, [TOP]       ; in new stack frame
    B       SumUp
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L11
    DCB     "Enter value for i (or 0 to stop): ", 0
    ALIGN
L11
    BL      TastierReadInt
    LDR     R0, =4
    STR     R0, [R4, R0, LSL #2] ; i
    B       L9
L10
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
;Name:SumUp Const:False Type:undef Kind:proc, Level:globul
;Name:main Const:False Type:undef Kind:proc, Level:globul
