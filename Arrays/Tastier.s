; Procedure Subtract
SubtractBody
    LDR     R0, =3
    LDR     R5, [R4, R0, LSL #2] ; i
    LDR     R6, =1
    SUB     R5, R5, R6
    LDR     R0, =3
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
    LDR     R0, =3
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
    LDR     R5, [R0,#16]    ; sum
    LDR     R0, =3
    LDR     R6, [R4, R0, LSL #2] ; i
    ADD     R5, R5, R6
    MOV     R0, BP          ; load current base pointer
    LDR     R0, [R0,#8]
    STR     R5, [R0,#16]    ; sum
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
    LDR     R5, =0
    STR     R5, [R4]        ; temp23
    LDR     R0, =3
    LDR     R5, [R4, R0, LSL #2] ; i
    STR     R5, [R4]        ; joke
    LDR     R5, =1
    LDR     R0, =1
    STR     R5, [R4, R0, LSL #2] ; k
    LDR     R0, =1
    LDR     R5, [R4, R0, LSL #2] ; k
    LDR     R6, [R4]        ; temp23
    ADD     R5, R5, R6
    LDR     R0, =1
    STR     R5, [R4, R0, LSL #2] ; k
    MOVS    R5, #1          ; true
    LDR     R0, =2
    STR     R5, [R4, R0, LSL #2] ; var
    LDR     R5, =0
    STR     R5, [BP,#16]    ; sum
    ADD     R0, PC, #4      ; store return address
    STR     R0, [TOP]       ; in new stack frame
    B       Add
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L3
    DCB     "The sum of the values from 1 to ", 0
    ALIGN
L3
    LDR     R5, [R4]        ; joke
    MOV     R0, R5
    BL      TastierPrintInt
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L4
    DCB     " is ", 0
    ALIGN
L4
    LDR     R5, [BP,#16]    ; sum
    MOV     R0, R5
    BL      TastierPrintIntLf
    MOV     TOP, BP         ; reset top of stack
    LDR     BP, [TOP,#12]   ; and stack base pointers
    LDR     PC, [TOP]       ; return from SumUp
SumUp
    LDR     R0, =1          ; current lexic level
    LDR     R1, =1          ; number of local variables
    BL      enter           ; build new stack frame
    B       SumUpBody
;Name:sum Const:False Type:intr Kind:var, Level:local
;Name:Subtract Const:False Type:undef Kind:proc, Level:local
;Name:Add Const:False Type:undef Kind:proc, Level:local
    LDR     R5, =1
    ADD     R0, BP, #16
    STR     R5, [R0, R0, LSL #2] ; value of temp[]
    LDR     R5, =2
    LDR     R5, =3
MainBody
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L5
    DCB     "Enter value for i (or 0 to stop): ", 0
    ALIGN
L5
    BL      TastierReadInt
    LDR     R0, =3
    STR     R0, [R4, R0, LSL #2] ; i
L6
    LDR     R0, =3
    LDR     R5, [R4, R0, LSL #2] ; i
    LDR     R6, =0
    CMP     R5, R6
    MOVGT   R5, #1
    MOVLE   R5, #0
    MOVS    R5, R5          ; reset Z flag in CPSR
    BEQ     L7              ; jump on condition false
    ADD     R0, PC, #4      ; store return address
    STR     R0, [TOP]       ; in new stack frame
    B       SumUp
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L8
    DCB     "Enter value for i (or 0 to stop): ", 0
    ALIGN
L8
    BL      TastierReadInt
    LDR     R0, =3
    STR     R0, [R4, R0, LSL #2] ; i
    B       L6
L7
StopTest
    B       StopTest
Main
    LDR     R0, =1          ; current lexic level
    LDR     R1, =0          ; number of local variables
    BL      enter           ; build new stack frame
    B       MainBody
;Name:temp Const:False Type:intr Kind:const, Level:local
;Name:joke Const:False Type:intr Kind:var, Level:globul
;Name:k Const:False Type:intr Kind:var, Level:globul
;Name:var Const:False Type:bool Kind:var, Level:globul
;Name:i Const:False Type:intr Kind:var, Level:globul
;Name:temp23 Const:True Type:intr Kind:const, Level:globul
;Name:SumUp Const:False Type:undef Kind:proc, Level:globul
;Name:main Const:False Type:undef Kind:proc, Level:globul
