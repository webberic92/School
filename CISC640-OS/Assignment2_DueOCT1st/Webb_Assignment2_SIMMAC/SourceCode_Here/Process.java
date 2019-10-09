package simmac;

// Process Control Block.
//This class creates a basic Process template to be later be initialized in multiple new instances stored in the queue.

public class Process {

	public int memoryBase;

	public int memoryLimit;
	
	public int processID;

	public int ACC;

	public int PSIAR;

	
	


	public Process(int address, int size, int processID) {

		this.processID = processID;

		ACC = 0;

		PSIAR = 0;

		memoryBase = address;
		
		memoryLimit = address + size;

	}

}