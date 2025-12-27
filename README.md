# MCS-85 family self modifying program
We can easily change the program during RUN TIME during execution of any **MCS-85** like intel **8085** program. Since the running program itself will change the program code, the entire program should be located in **RAM** memory. If the running program is located in ROM or EPROM memory address space, the program can not modify the program. Please note that we are not changing any DATA inside the program, instead we are changing the program itself!

## LED Running EXAMPLE
### 8 LEDs running Left and Right between LSB to MSB
The simple program with memory location and opcodes listed like below
![Program_with_Opcode](https://github.com/user-attachments/assets/ff25464f-dbfc-47e0-9521-9f02e69f5fe7)

If we notice the LOCATION **2002** contains **RAL** instruction with opcode of **0x17**
We set the CARRY FLAG and continue the rotate operation until the CARRY FLAG is SET again. If the CARRY FLAG is set due to the RAL operation, the program changes the LOCATION 2002 into RAR by changing the (RAL XOR 08) which will result in RAR opcode equals to **0x1F**
After changing the content of 2002 now the shifting happens in Right direction due to change in the opcode from RAL to RAR.

When once again when the CARRY FLAG sets after shifting through Right, now again the same XOR 08 is performed in the location which changes the content from 0X1F to 0X17
This means the program again changed back to RAL opcode 0x17 at the program space memory location 2002.

This repeats for ever.
### MCS-85 Rotate instructions with Instruction code 
![MCS-85_ROTATE](https://github.com/user-attachments/assets/bd1366bc-84ae-4157-b5db-0ae25be827d2)

### MCS-85 RAL and RAR Instruction
![RAL_RAR_HiLight](https://github.com/user-attachments/assets/94ec3ea9-518f-465c-a67a-f139b33bd6f0)

### D3 bit flip changes RAL to RAR
![RAL_RAR_FLIP](https://github.com/user-attachments/assets/89400abf-fe3a-412d-a52b-854c34adc288)

SO
![RAL_RAF](https://github.com/user-attachments/assets/ee691dc5-79fc-4948-b7ca-f36942fd99ae)

![RAL_RAF_XOR](https://github.com/user-attachments/assets/998e8313-fb1d-4c71-8d69-a567410dba06)

;##################################################  
; MCS-85 SELF MODIFYING PROGRAM FOR RUNNING 8 LEDs  
;##################################################  
		ORG 2000H  

		XRA A  
		STC  
		**RAL** 
		OUT 04  
		CALL DELAY  
		CALL DELAY  
		CC XOR8  
		JMP 2002  
XOR8:  
		LDA 2002  
		XRI A,08  
		STA 2002  
		XRA A  
		STC  
		RET  

; DELAY is part of MONITOR program and not Listed Here  
  
Only before starting the execution of the program, we are sure the program memory space location 2002 contains RAL instruction with a opcode 0x17. After exectuting this content changes to 0X1F and again back to 0X17 depends on CARRY FLAG status. Since the MCS-85 source program changes dynamically, no one know what is the content value at the location 2002.  It may be 0x17 or 0x1F depends on the current status and conditions.

Same logic is applicable and true for RLC and RRC instruction of MCS-85 family.

This may be impossible with modern computers and quantum computers! ;)
