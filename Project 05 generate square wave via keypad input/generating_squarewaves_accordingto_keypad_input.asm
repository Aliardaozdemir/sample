;this source code written for PAT microcomputer system which uses 80286 inter microprocessor
;D2000 development system assembler can be use to convert this source code to an executable machine code program

;GENERATE SQUARE WAVES USING PIEZO SOUNDER IN DIFFERENT FREQ. 

	  ORG 0100H

UPORT1CTL EQU 088H
UPORT1    EQU 090H

	  MOV AL,20H
	  OUT UPORT1CTL,AL ;CONFIGURE P15 AS OUTPUT BIT

START:    MOV AH,00H
	  MOV BL,3
	  MOV CX,1
	  
	  MOV DI,1000H
          INT 028H ; INT028 USED TO ACCESS PAT SUBROUTINES

	  MOV AX,[DI]
	  MOV DI,OFFSET ANARRAY
	  SHL AX
	  ADD DI,AX
	  MOV BX,[DI]

OUTPUT: MOV AL,00H
	OUT UPORT1,AL

	MOV CX,BX
DELAY1: LOOP DELAY1

	MOV AL,20H
	OUT UPORT1,AL

	MOV CX,BX
DELAY2: LOOP DELAY2

ANARRAY DW 06B0H,05F4H,059CH,04FBH,0470H,03F8H,03A8H,0355H,02FEH
