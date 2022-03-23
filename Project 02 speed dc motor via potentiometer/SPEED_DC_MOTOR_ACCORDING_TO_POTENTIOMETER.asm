;this source code written for PAT microcomputer system which uses 80286 inter microprocessor
;D2000 development system assembler can be use to convert this source code to an executable machine code program

;speed dc motor according to position of the potentiometer

	  ORG 0500H

UMODREG   EQU 086H	;PAT ENCODES MODE REGISTER PORT ADDRESS AS 086H
UPORT1CTL EQU 088H	;PAT ENCODES PORT1 CONTROL REGISTER PORT ADDRESS AS 088H
UPORT1    EQU 090H	;PAT ENCODES PORT1 PORT ADDRESS AS 090H
UPORT2    EQU 092H	;PAT ENCODES PORT2 PORT ADDRESS AS 092H

START:	  MOV AL,00H	;MOD REG. PC0 = 0,PC1 = 0,PC2 = 0 SO PORT 2 BOTH NIBBLES CONFIGURED AS INPUT 
	  OUT UMODREG,AL

	  MOV AL,BL	;P10 = 1,P12 = 0,P13 = 1,P11 = 1
	  OUT UPORT1CTL,AL

;GENERATE SHORT NEGATIVE GOING PULSE ON P11 TO INITIATE CONVERSION
	  MOV AL,02H
	  OUT UPORT1,AL

	  MOV AL,00H
	  OUT UPORT1,AL

	  MOV AL,02H
	  OUT UPORT1,AL

;MONITOR P12 & WAIT UNTIL P12 = 1
CHECK:    IN AL,UPORT1
	  TEST AL,04H
	  JNZ CHECK

;ENABLE ADC & READ POTENTIOMETER VALUE
	  MOV AL,0F7H
	  OUT UPORT1,AL

	  IN AL,UPORT2
	  MOV BL,AL

	  MOV AL,08H
	  OUT UPORT1,AL
;DAC PART 
	  MOV AL,00H
	  OUT UPORT1,AL		;OUTPUT LOGIC 0 ON P10 TO ENABLE DAC

	  MOV AL,03H
	  OUT UMODREG,AL

	  OUT UPORT2,BL

	  CALL WAIT 
	  JUMP START


WAIT: MOV CX,0FFFH
DLY:  LOOP DLY
      RET

	  
	
