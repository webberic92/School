package simmac;

import java.util.ArrayList;

public class OperatingSystem {

	ArrayList<Process> rdyQue; // Queue of processes ready to run.

	Process current_process; // Process currently being executed.

	SIMMAC cpu; // Cpu used to execute the processes.

	int quantum; // Value of the time quantum.

	int lastLoadAddress; // Address to load a program.

	int clock; //clock.
	
	
// Operating System gets passed cpu and quantum time, then creates a ready queue with null processes.
	public OperatingSystem(SIMMAC cpu, int quantum) {

		this.cpu = cpu;

		this.quantum = quantum;

		lastLoadAddress = 0;

		rdyQue = new ArrayList();

		current_process = null;

		clock = 0;

	}

	
	//Prints processes
	public void printProcesses() {
		System.out.print("Process Queue: ");

		for (int i = 0; i < rdyQue.size(); i++)

		{

			if (i > 0)

				System.out.print(", ");

			System.out.print(rdyQue.get(i).processID);

		}


	}


//Switch processes.
	public void switch_process() {

		if (current_process != null) {

			//Saves current register state.
			current_process.ACC = cpu.ACC; 

			current_process.PSIAR = cpu.PSIAR;

			rdyQue.add(current_process);

		}
		//Gets the process from queue.
		current_process = rdyQue.remove(0); 

		//Load the state of the register.
		cpu.ACC = current_process.ACC;

		cpu.PSIAR = current_process.PSIAR;

		//Gets limits for the memory.
		cpu.memLimit = current_process.memoryLimit;

		cpu.memBase = current_process.memoryBase;

		//clock restarted.
		clock = 0; 

		System.out.println("\nSwitching process...");

		System.out.println("The Next Process ID is... " + current_process.processID);
		printProcesses();
		System.out.println();

	}

	
	
//Loops through processes and throws error if needed.
	public void run() {

		boolean term = false;

		current_process = null;
		//first process is loaded.
    	switch_process(); 

		while (!term)

		{

			boolean exit_status = cpu.executeTheInstructions();

			clock++;
			
			//Error handling of invalid processes,
			//Sets process to null and forces swap to next process.

			if (exit_status == true) {

				if (rdyQue.size() > 0)

				{

					current_process = null; 

					switch_process(); 

				}

				else
					//terminates
					term = true; 

			}

//If clock is greater than or equal to quantum and not terminated then next process.
			if (clock >= quantum && !term) {

				switch_process();

			}

		}

	}

	

//Loads SIMMAC program to the memory.
	void loadProgram(int[] program) {

		int startAddress = lastLoadAddress;
		
		//Verifies that this program doesnt exceed CPU MEM SIZE (512)
		if (lastLoadAddress + program.length >= cpu.MEM_SIZE) {

			System.out.println("Error: cannot load program, program size exceeds memory size.");

			System.exit(0);

		}
		
		//Loops through and adds process to que.

		for (int i = 0; i < program.length; i++)

			cpu.Memory[lastLoadAddress + i] = program[i];

		lastLoadAddress += program.length;

		Process process = new Process(startAddress, program.length, rdyQue.size());

		rdyQue.add(process);

	}

}