;this source code written for PAT microcomputer system which uses 80286 inter microprocessor
;D2000 development system assembler can be use to convert this source code to an executable machine code program

;implementation of a piezosounder alarm system using proximity detector as input

	ORG 0200H

UPORT1CTL EQU 088H 	;PAT ENCODES PORT1 CONTROL REGISTER PORT ADDRESS AS 088H
UPORT1    EQU 090H      ;PAT MICROCOMPUTER SYSTEM ENCODES PORT1 REGISTER PORT ADDRESS AS 090H

START:    MOV AL,60H    ;CONFIGURE P15&P16 AS OUTPUT BITS AND P17 AS INPUT BIT
	  OUT UPORT1CTL,AL

	  MOV AL,40H
	  OUT UPORT1,AL ;OUTPUT LOGIC "1" ON P16(UTX) TO SWITCH ON ULTRASOUND

DETECT:   IN AL,UPORT1 ;LOAD ACCUMULATOR FROM PORT1
	  TEST AL,80H  ;CHECK IF P17 = "0" OR "1".IF P17=0 THEN Z = 1 SO 40 KHZ SOUND DETECTED
	  JZ DETECT 

	  MOV BX,0FFH
	
OUTPUT:   MOV AL,00H
	  OUT UPORT1,AL ;OUTPUT LOGIC 0 ON P15 
	  
	  CALL HALFPERIOD

	  MOV AL,20H
	  OUT UPORT1,AL

	  CALL HALFPERIOD

	  DEC BX
	  JNZ OUTPUT
	  JUMP START

;SUBROUTINE 
HALFPERIOD: MOV CX,0FAH
WAIT:       LOOP WAIT
	    RET