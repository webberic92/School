 package simmac;

public class SIMMAC {

public final int MEMORY_SIZE = 512;

public int Memory[];

public int memoryBase;  // starting address for current process

public int memoryLimit; // maximum address allowed for current process

// registers

public int ACC;    // accumulator

public int PSIAR;  // Primary Storage Instruction Address Register

int SAR;    // Storage Address Register

int SDR;    // Storage Data Register

int TMPR;   // Temporary Register

int CSIAR;  // Control Storage Instruction Address Register

int IR;     // Instruction Register

int MIR;    // Micro-instruction Register

public SIMMAC() {

Memory=new int [MEMORY_SIZE];

CSIAR = 0;

PSIAR = 0;

ACC = 0;

memoryLimit=MEMORY_SIZE;

memoryBase=0;

}

/* read from memory using the SAR register, if an error was found returns true */

boolean read() {

if(SAR+memoryBase>=0 && SAR+memoryBase<memoryLimit) {

SDR=Memory[memoryBase+SAR];

return false;

}

else

return true;

}

/* write to memory using the SAR register, if an error was found returns true */

boolean write() {

if(SAR+memoryBase>=0 && SAR+memoryBase<memoryLimit) {

Memory[memoryBase+SAR]=SDR;

return false;

}

else

return true;

}

boolean fetch() {

SAR = PSIAR;

if(read())

return true;

IR = SDR;

SDR = IR & 0xFFFF;

CSIAR = IR >> 16;

return false;

}

boolean add() {

TMPR = ACC;

ACC = PSIAR + 1;

PSIAR = ACC;

ACC = TMPR;

TMPR = SDR;

SAR = TMPR;

if(read())

return true;

TMPR = SDR;

ACC = ACC + TMPR;

CSIAR = 0;

return false;

}

boolean sub() {

TMPR = ACC;

ACC = PSIAR + 1;

PSIAR = ACC;

ACC = TMPR;

TMPR = SDR;

SAR = TMPR;

if(read())

return true;

TMPR = SDR;

ACC = ACC -TMPR;

CSIAR = 0;

return false;

}

boolean load() {

TMPR = ACC;

ACC = PSIAR + 1;

PSIAR = ACC;

ACC = TMPR;

TMPR = SDR;

SAR = TMPR;

if(read())

return true;

ACC = SDR;

CSIAR = 0;

return false;

}

boolean store() {

TMPR = ACC;

ACC = PSIAR + 1;

PSIAR = ACC;

ACC = TMPR;

TMPR = SDR;

SAR = TMPR;

SDR = ACC;

if(write())

return true;

CSIAR = 0;

return false;

}

boolean branch() {

PSIAR = SDR;

CSIAR = 0;

return false;

}

boolean conditionalBranch() {

if (ACC==0) {

PSIAR = SDR;

CSIAR = 0;

}

else {

TMPR = ACC;

ACC = PSIAR + 1;

PSIAR = ACC;

ACC = TMPR;

CSIAR = 0;

}

return false;

}

boolean loadImmediate() {

ACC = PSIAR + 1;

PSIAR = ACC;

ACC = SDR;

CSIAR = 0;

return false;

}

/* print the contents of all the registers and all memory */

public void dump() {

System.out.printf("Register contents:\n");
System.out.printf("ACC = %08X\tPSIAR = %04X\tSAR = %04X\tSDR = %08X\n",ACC,PSIAR,SAR,SDR);
System.out.printf("TMPR = %08X\tCSIAR = %04X\tIR = %04X\tMIR = %04X\n",TMPR,CSIAR,IR,MIR);
System.out.printf("\nMemory contents:\n%03d: ",0);
for (int i=0; i<MEMORY_SIZE; i++) {

if(i!=0 && i%8==0)
System.out.printf("\n%03d: ",i);

System.out.printf("%08X ",Memory[i]);

}

System.out.println();

}

public boolean executeInstruction() {

boolean halt = false;

boolean error = false;

fetch();

switch(CSIAR) {

case Instruction.ADD:

error=add();

break;

case Instruction.SUB:

error=sub();

break;

case Instruction.LDA:

error=load();

break;

case Instruction.STR:

error=store();

break;

case Instruction.BRH:

error=branch();

break;

case Instruction.CBR:

error=conditionalBranch();

break;

case Instruction.LDI:

error=loadImmediate();

break;

case Instruction.HLT:

dump();

System.out.println("End of Job");

halt=true;

break;

default:

dump();
System.out.printf("ERROR : invlaid instructions %04X.\nProgram terminated. \n",IR);


halt =true;

}

if(error) {

dump();
System.out.printf("ERROR : invlaid memory address %04X.\nProgram terminated. \n",SAR);


}

return (halt || error); // return true if there was an error, false otherwise

}

}