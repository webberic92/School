package simmac;

public class SIMMAC {

	public final int MEMORY_SIZE = 512;

	public int Memory[];

	public int memoryBase; // starting address for current process

	public int memoryLimit; // maximum address allowed for current process

// registers

	public int ACC; // accumulator

	public int PSIAR; // Primary Storage Instruction Address Register

	int SAR; // Storage Address Register

	int SDR; // Storage Data Register

	int TMPR; // Temporary Register

	int CSIAR; // Control Storage Instruction Address Register

	int IR; // Instruction Register

	int MIR; // Micro-instruction Register

	public SIMMAC() {

		Memory = new int[MEMORY_SIZE];

		CSIAR = 0;

		PSIAR = 0;

		ACC = 0;

		memoryLimit = MEMORY_SIZE;

		memoryBase = 0;

	}

	/*
	 * read from memory using the SAR register, if an error was found returns true
	 */

	boolean read() {

		if (SAR + memoryBase >= 0 && SAR + memoryBase < memoryLimit) {

			SDR = Memory[memoryBase + SAR];

			return false;

		}

		else

			return true;

	}

	/* write to memory using the SAR register, if an error was found returns true */

	boolean write() {

		if (SAR + memoryBase >= 0 && SAR + memoryBase < memoryLimit) {

			Memory[memoryBase + SAR] = SDR;

			return false;

		}

		else

			return true;

	}

	boolean fetch() {

		SAR = PSIAR;

		if (read())

			return true;

		IR = SDR;

		SDR = IR & 0xFFFF;

		CSIAR = IR >> 16;

		return false;

	}

	boolean add() {
		//(10) TMPR = ACC (11) ACC = PSIAR + 1 (12) PSIAR = ACC (13)
		//ACC = TMPR (14) TMPR = SDR (15) SAR = TMPR (16) READ (17) 
		//TMPR = SDR (18) ACC = ACC + TMPR (19) CSIAR = 0 

		TMPR = ACC;

		ACC = PSIAR + 1;

		PSIAR = ACC;

		ACC = TMPR;

		TMPR = SDR;

		SAR = TMPR;

		if (read())

			return true;

		TMPR = SDR;

		ACC = ACC + TMPR;

		CSIAR = 0;

		return false;

	}

	boolean sub() {
		
//		(20) TMPR = ACC (21) ACC = PSIAR + 1 (22) PSIAR = ACC (23) ACC = TMPR (24) TMPR = SDR (25) 
//		SAR = TMPR (26) READ (27) TMPR = SDR (28) ACC = ACC - TMPR (29) CSIAR = 0 

		TMPR = ACC;

		ACC = PSIAR + 1;

		PSIAR = ACC;

		ACC = TMPR;

		TMPR = SDR;

		SAR = TMPR;

		if (read())

			return true;

		TMPR = SDR;

		ACC = ACC - TMPR;

		CSIAR = 0;

		return false;

	}

	boolean load() {
//		
//		 (30) TMPR = ACC (31) ACC = PSIAR + 1 (32) PSIAR = ACC (33) ACC = TMPR (34) 
//		TMPR = SDR (35) SAR = TMPR (36) READ (37) ACC = SDR (38) CSIAR = 0 

		TMPR = ACC;

		ACC = PSIAR + 1;

		PSIAR = ACC;

		ACC = TMPR;

		TMPR = SDR;

		SAR = TMPR;

		if (read())

			return true;

		ACC = SDR;

		CSIAR = 0;

		return false;

	}

	boolean store() {
//		(40) TMPR = ACC (41) ACC = PSIAR + 1 (42) PSIAR = ACC (43) ACC = TMPR (44) TMPR = SDR (45)
//		SAR = TMPR (46) SDR = ACC (47) WRITE (48) CSIAR = 0 
//		
//		

		TMPR = ACC;

		ACC = PSIAR + 1;

		PSIAR = ACC;

		ACC = TMPR;

		TMPR = SDR;

		SAR = TMPR;

		SDR = ACC;

		if (write())

			return true;

		CSIAR = 0;

		return false;

	}

	boolean branch() {
		//(50) PSIAR = SDR (51) CSIAR = 0 

		PSIAR = SDR;

		CSIAR = 0;

		return false;

	}

	boolean conditionalBranch() {
//		 PSIAR = SDR (63) CSIAR = 0 (64) TMPR = ACC (65) 
//		ACC = PSIAR + 1 (65) PSIAR = ACC (66) ACC = TMPR (67) CSIAR = 0 

		if (ACC == 0) {

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
 // (70) ACC = PSIAR + 1 (71) PSIAR = ACC (72) ACC = SDR (73) CSIAR = 0 
		ACC = PSIAR + 1;

		PSIAR = ACC;

		ACC = SDR;

		CSIAR = 0;

		return false;

	}

	
	
//	/* print the contents of all the registers and all memory */

	public void dump() {
		// Add a HALT instruction that dumps the contents of all registers and memory and then prints an “End of Job” message. 

		System.out.printf("Contents of Register:\n");
		System.out.printf("ACC = %08X\tPSIAR = %04X\tSAR = %04X\tSDR = %08X\n", ACC, PSIAR, SAR, SDR);
		System.out.printf("TMPR = %08X\tCSIAR = %04X\tIR = %04X\tMIR = %04X\n", TMPR, CSIAR, IR, MIR);
		System.out.printf("\nMemory contents:\n%03d: ", 0);
		for (int i = 0; i < MEMORY_SIZE; i++) {

			if (i != 0 && i % 8 == 0)
				System.out.printf("\n%03d: ", i);

			System.out.printf("%08X ", Memory[i]);

		}

		System.out.println();

	}

	public boolean executeTheInstructions() {

		boolean halt = false;

		boolean error = false;

		fetch();

		switch (CSIAR) {

		case Instruction.ADD:

			error = add();

			break;

		case Instruction.SUB:

			error = sub();

			break;

		case Instruction.LDA:

			error = load();

			break;

		case Instruction.STR:

			error = store();

			break;

		case Instruction.BRH:

			error = branch();

			break;

		case Instruction.CBR:

			error = conditionalBranch();

			break;

		case Instruction.LDI:

			error = loadImmediate();

			break;

		case Instruction.HLT:

			dump();

			System.out.println("End of Job");

			halt = true;

			break;

		default:

			dump();
			System.out.printf("ERROR : invlaid instructions %04X.\nProgram termd. \n", IR);

			halt = true;

		}

		if (error) {

			dump();
			System.out.printf("ERROR : invlaid memory address %04X.\nProgram termd. \n", SAR);

		}

		return (halt || error); // return true if there was an error, false otherwise

	}

}