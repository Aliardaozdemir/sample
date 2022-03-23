;this source code written for PAT microcomputer system which uses 80286 inter microprocessor
;D2000 development system assembler can be use to convert this source code to an executable machine code program

;produce slowly increasing binary count output

	  ORG 0400H

UMODREG   EQU 086H
UPORT1CTL EQU 088H
UPORT1    EQU 090H
UPORT2    EQU 092H


	  MOV AL,01H		;CONFIGURE P10 AS OUTPUT BIT
          OUT UPORT1,AL

	  MOV AL,03H
	  OUTPUT UMODREG,AL	;CONFIGURE PORT2 AS ALL OUTPUTS

	  MOV AL,00H		;OUTPUT LOGIC 0 ON P10 TO ENABLA DAC
	  OUT UPORT1,AL

	  MOV AL,00H		;INITIAL COUNT 
OUTPUT:   OUT UPORT2,AL

	  CALL WAIT 
	  INC AL
	  JUMP OUTPUT


WAIT: MOV CX,0FFFH
DLY:  LOOP DLY


