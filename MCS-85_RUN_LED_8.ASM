;##################################################
; MCS-85 SELF MODIFYING PROGRAM FOR RUNNING 8 LEDs
;##################################################
		ORG 2000H

		XRA A
		STC
		RAL
		OUT 04
		CALL DELAY
		CALL DELAY
		CC XOR8
		JMP 2002
XOR8: 	LDA 2002
		XRI A,08
		STA 2002
		XRA A
		STC
		RET

; DELAY is part of MONITOR program and not Listed Here
