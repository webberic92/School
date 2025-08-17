package simmac;

import java.util.ArrayList;

public class OperatingSystem {

	ArrayList<Process> rdyQue; // Queue of processes ready to run.

	Process current_process; // Process currently being executed.

	SIMMAC cpu; // Cpu used to execute the processes.

	int quantum; // Value of the time quantum.

	int lastLoadAddress; // Address to load a program.

	int clock; // Clock to compare against time quantum value.

// Operating System gets passed cpu and quantum time, then creates a ready queue with null processes.
	public OperatingSystem(SIMMAC cpu, int quantum) {

		this.cpu = cpu;

		this.quantum = quantum;

		lastLoadAddress = 0;

		rdyQue = new ArrayList();

		current_process = null;

		clock = 0;

	}

	// Prints processes by looping through queue.
	public void printProcesses() {
		System.out.print("Process Queue: ");

		for (int i = 0; i < rdyQue.size(); i++)

		{

			if (i > 0)

				System.out.print(", ");

			System.out.print(rdyQue.get(i).processID);

		}

	}

//Switch processes. This is part of round robin.
	public void switch_process() {

		if (current_process != null) {

			// Saves current register state.
			current_process.ACC = cpu.ACC;

			current_process.PSIAR = cpu.PSIAR;

			rdyQue.add(current_process);

		}
		// Gets the next process from queue by removing index of 0 and everything in
		// array gets shifted downwards
		// Aka the next process is now at index 0 (Instead of index 1.) and set to our current process.
		current_process = rdyQue.remove(0);

		// Load the state of the register.
		cpu.ACC = current_process.ACC;
		cpu.PSIAR = current_process.PSIAR;

		// Gets limits for the memory.
		cpu.memLimit = current_process.memoryLimit;
		cpu.memBase = current_process.memoryBase;

		// clock restarted. So next process can compete against time quantum value.
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
		// first process is loaded.
		switch_process();

		while (!term)

		{

			boolean exit_status = cpu.executeTheInstructions();

			clock++;

			// Error handling of invalid processes,
			// Sets process to null and forces swap to next process.
			// IF the HLT instruction it will return true for exit_status

			if (exit_status == true) {

				if (rdyQue.size() > 0)

				{

					current_process = null;

					switch_process();

				}

				else
					// terminates
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

		// Verifies that this program doesnt exceed CPU MEM SIZE (512)
		if (lastLoadAddress + program.length >= cpu.MEM_SIZE) {

			System.out.println("Something went wrong cannot load program, program size exceeds memory size.");

			System.exit(0);

		}

		// Loops through and adds process to que.

		for (int i = 0; i < program.length; i++)

			cpu.Memory[lastLoadAddress + i] = program[i];

		lastLoadAddress += program.length;

		Process process = new Process(startAddress, program.length, rdyQue.size());

		//This is where processes get added to end of the queue in the round robin architecture if still needs to be completed.
		rdyQue.add(process);

	}

}