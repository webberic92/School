package simmac;

import java.util.ArrayList;

public class OperatingSystem {

	ArrayList<Process> rdyQue; // queue of processes ready to run

	Process current_process; // process currently being executed

	SIMMAC cpu; // cpu used to execute the processes

	int quantum; // value of the time quantum

	int lastLoadAddress; // address to load a program

	int clock;

	public OperatingSystem(SIMMAC cpu, int quantum) {

		this.cpu = cpu;

		this.quantum = quantum;

		lastLoadAddress = 0;

		rdyQue = new ArrayList();

		current_process = null;

		clock = 0;

	}

	
	/* prints the ready process queue */

	public void printProcesses() {
		System.out.print("Process Queue: ");

		for (int i = 0; i < rdyQue.size(); i++)

		{

			if (i > 0)

				System.out.print(", ");

			System.out.print(rdyQue.get(i).processID);

		}


	}

	
	/* Switch the current process for another from the ready queue */

	public void switch_process() {

		if (current_process != null) {

			current_process.ACC = cpu.ACC; // save current register state

			current_process.PSIAR = cpu.PSIAR;

			rdyQue.add(current_process);

		}

		current_process = rdyQue.remove(0); // get process from queue

		cpu.ACC = current_process.ACC; // load register state

		cpu.PSIAR = current_process.PSIAR;

		cpu.memoryLimit = current_process.memoryLimit; // load memory limits

		cpu.memoryBase = current_process.memoryBase;

		clock = 0; // restart clock count

		System.out.println("\nSwitching process.");

		System.out.println("next process ID: " + current_process.processID);
		printProcesses();
		System.out.println();

	}

	
	/*
	 * Run the loaded processes in an loop until all are executed or an error
	 * happens
	 */

	public void run() {

		boolean term = false;

		current_process = null;

		switch_process(); // load first process

		while (!term)

		{

			boolean exit_status = cpu.executeTheInstructions();

			clock++;

			if (exit_status == true) { // it the process was termd

				if (rdyQue.size() > 0)

				{

					current_process = null; // invalidate current process

					switch_process(); // forced swap to a different process

				}

				else

					term = true; // no more processes, exit the program

			}

			if (clock >= quantum && !term) {

				switch_process();

			}

		}

	}

	
	/* load a SIMMAC program to memory */

	void loadProgram(int[] program) {

		int startAddress = lastLoadAddress;

		if (lastLoadAddress + program.length >= cpu.MEMORY_SIZE) {

			System.out.println("Error: cannot load program, program size exceeds memory size.");

			System.exit(0);

		}

		for (int i = 0; i < program.length; i++)

			cpu.Memory[lastLoadAddress + i] = program[i];

		lastLoadAddress += program.length;

		Process process = new Process(startAddress, program.length, rdyQue.size());

		rdyQue.add(process);

	}

}