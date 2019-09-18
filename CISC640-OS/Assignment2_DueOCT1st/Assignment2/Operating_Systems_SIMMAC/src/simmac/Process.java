package simmac;

// Process Control Block.

public class Process {

	public int processID;

	public int ACC;

	public int PSIAR;

	public int memoryBase;

	public int memoryLimit;
	


	public Process(int address, int size, int processID) {

		this.processID = processID;

		ACC = 0;

		PSIAR = 0;

		memoryBase = address;

		memoryLimit = address + size;

	}

}