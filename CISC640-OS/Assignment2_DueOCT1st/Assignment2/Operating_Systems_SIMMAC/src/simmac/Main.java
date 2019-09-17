package simmac;

import java.io.File;

import java.io.FileNotFoundException;

import java.util.ArrayList;

import java.util.Scanner;

public class Main {

	/*
	 * open a SIMMAC program file and parse its contents, if everything is fine
	 * 
	 * returns an array with all the instructions
	 */

	public static int[] readProgramFile(String filename) {

		try {

			Scanner s = new Scanner(new File(filename));

			ArrayList<Integer> instructions = new ArrayList();

			int nline = 1;

			while (s.hasNext()) {

				String line = s.nextLine().trim();

				if (line.length() > 0)

				{

					Integer inst = Instruction.parseInstruction(line, filename, nline); // parse the instruction
																						// contained in the current line

					if (inst != null) { // if the instruction was valid

						instructions.add(inst);

					}

					else

						System.exit(0);

				}

				nline++;

			}

			s.close();

			int[] instr = new int[instructions.size()];

			for (int i = 0; i < instructions.size(); i++)

				instr[i] = instructions.get(i);

			return instr; // success, return the instruction list

		} catch (FileNotFoundException e) {

			System.out.println("ERROR: program file " + filename + " could not be opened.");

			System.exit(0); // failure

		}

		return null;

	}

	public static void main(String[] args) {

		System.out.println("Please enter the time quantum value: "); // ask for the filename to use

		Scanner scanner = new Scanner(System.in);

		int quantum = scanner.nextInt();

		SIMMAC cpu = new SIMMAC();

		OperatingSystem operatingSytem = new OperatingSystem(cpu, quantum);

		if (args.length == 0) {

			boolean done = false;

			ArrayList<String> filenames = new ArrayList();

			while (!done) {

				System.out.print("Please enter file name to lead."); // ask for the filename to use

				filenames.add(scanner.next());

				System.out.println("Do you want to load another file? (Y/N): ");

				String choice = scanner.next();

				if (choice.toUpperCase().equals("N") || !choice.toUpperCase().equals("Y"))
					;

				done = true;

			}

//			 Add a HALT instruction that dumps the contents of all registers and memory and then 
//			prints an “End of Job” message. 
			for (int i = 0; i < filenames.size(); i++) {

				int[] program = readProgramFile(filenames.get(i));

				operatingSytem.loadProgram(program);

			}

		}

		else {

			for (int i = 0; i < args.length; i++)

			{

				int[] program = readProgramFile(args[i]);

				operatingSytem.loadProgram(program);

			}

		}

		operatingSytem.run(); // run the processes

	}

}
