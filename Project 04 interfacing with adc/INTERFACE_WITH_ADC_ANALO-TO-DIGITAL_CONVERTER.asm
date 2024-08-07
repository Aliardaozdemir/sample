;this source code written for PAT microcomputer system which uses 80286 inter microprocessor
;D2000 development system assembler can be use to convert this source code to an executable machine code program

;ADC INTERFACING
;OUTPUT BINARY VALUE AT PORT2,DEPENDING UPON THE POSITION OF THE APPLICATION MODULE POTENTIOMETER

	  ORG 0100H
UMODREG   EQU O86H
UPORT1CTL EQU 088H
UPORT1    EQU 090H
UPORT2    EQU 092H

START:    MOV AL,00H
	  OUT UMODREG,AL	;CONFIGURE PORT2 AS ALL INPUTS

	  MOV AL,0AH		;0AH = 0000 1010
	  OUT UPORT1CTL,AL	;CONFIGURE P11 & P13 AS OUTPUT BITS

;GENERATE SHORT NEGATIVE GOING PULSE

	  MOV AL,20H
	  OUT UPORT1,AL

          MOV AL,00H
	  OUT UPORT1,AL

          MOV AL,20H
	  OUT UPORT1,AL

;CHECK IF CONVERSION HAS COMPLETE
CHECK:    IN AL,UPORT1
	  TEST AL,40H		;CHECK P16, IF P16 = 1 CONVERSION IS COMPLETE
	  JNZ CHECK

;ENABLE ADC & READ POT VALUE 
	  MOV AL,0F7H		;OUTPUT 0 ON RD
	  OUT UPORT1,AL

	  IN AL,UPORT2
	  MOV BL,AL


	  MOV AL,08H		;OUTPUT LOGIC 1 ON RD
	  OUT UPORT1,AL

	  MOV AL,03H
	  OUT UMODREG,AL	;CONFIGURE PORT2 AS ALL OUPUTS

	  MOV AL,BL 
	  OUT UPORT2,AL

	  CALL WAIT

	  JMP START

WAIT: MOV CX,0FH
DLY:  LOOP DLY
      RET
