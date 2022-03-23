;this source code written for PAT microcomputer system which uses 80286 inter microprocessor
;D2000 development system assembler can be use to convert this source code to an executable machine code program

;generate sound abaout 1kHz using piezo sounder

	  ORG 0100H
UPORT1CTL EQU 088H          ;PAT ENCODES PORT1 CONTROL REGISTER PORT ADDRESS AS 088H
UPORT1    EQU 090H          ;PAT ENCODES PORT1 PORT ADDRESS AS 090H

	  MOV AL,20H        ;PIEZO SOUNDER CONVERTS A TTL LEVEL WAVEFORM ON P15
	  OUT UPORT1CTL,AL  ;CONFIGURE P15 AS OUTPUT BIT

OUTPUT:   MOV AL,00H
	  OUT UPORT1,AL

	  CALL HALFPERIOD

	  MOV AL,20H
	  OUT UPORT1,AL
 
	  CALL HALFPERIOD

	  JMP OUTPUT



;SUBROUTINE FOR HALF PERIOD
HALPERIOD: MOV CX,0FFH 
WAIT:      LOOP WAIT        ;WAIT ABOUT 0.5 MS TO GENERATE 1KHZ SOUND
	   RET              ;RETURN TO MAIN PROGRAM
