.MODEL SMALL                    ;ALLOCATE MEMORY
.DATA                         

ANARRAY DW 5555H, 4444H, 3333H, 2222H, 1111H
SIZE EQU 5                     

.CODE                              ; beginning of code segment
	    MOV AX,@DATA           ; beginning address of data is moved to ax
            MOV DS,AX              

            MOV CX,SIZE            ; initialize cx register
            DEC CS                  

FIRSTLOOP:  LEA SI,ANARRAY               
            MOV DX,CX           

SECONDLOOP: MOV AX,[SI]               
            MOV BX, [SI+2]      
            CMP AX,BX         
            JB NEXT             
            MOV [SI],DX       
            MOV [SI+2],AX      

NEXT:	    ADD SI, 02H                    
            DEC DX             
            JNZ FIRSTLOOP        
            LOOP SECONDLOOP

         
            INT 3H                  ; Breakpoint interrupt
            ALIGN 16                ; alignment of your output data                         
            END                     ; end directive