package simmac;

import java.io.File;

import java.io.FileNotFoundException;

import java.util.ArrayList;

import java.util.Scanner;

public class Main {

//Entry point to our program.
	public static void main(String[] args) {

		run(args);

	}

//Run method askes for time quantum value, then creates instances of SIMMAC and OperatingSystem.
	private static void run(String[] args) {
		System.out.println("Weclome to the SIMMAC program! ");
		System.out.println("To get started, ");
		System.out.println("Please enter time quantum value... ");

		Scanner scanner = new Scanner(System.in);

		int quantum = scanner.nextInt();

		SIMMAC cpu = new SIMMAC();

		OperatingSystem operatingSytem = new OperatingSystem(cpu, quantum);

//Asks for more files to be entered or not.
		if (args.length == 0) {

			boolean loadFileDone = false;

			ArrayList<String> filenames = new ArrayList();

			while (!loadFileDone) {

				System.out.print("Please enter file name to load...");

				filenames.add(scanner.next());

				System.out.println("Do you want to load another file? (Y/N)...");

				String choice = scanner.next();

				if (choice.toUpperCase().equals("N") || !choice.toUpperCase().equals("Y")) {
					loadFileDone = true;

				}

//Loads multiple if more then 1 filename.
				for (int i = 0; i < filenames.size(); i++) {

					int[] program = getFile(filenames.get(i));

					operatingSytem.loadProgram(program);

				}
			}
		}

//else Loads single.

		else {

			for (int i = 0; i < args.length; i++)

			{

				int[] program = getFile(args[i]);

				operatingSytem.loadProgram(program);

			}

		}
//Starts operating system.
		operatingSytem.run();

	}

// This method gets the input files to be loaded then returns instructions and validates via abstraction from Instruction.java.
	public static int[] getFile(String file) {

		try {

			Scanner scanner = new Scanner(new File(file));

			ArrayList<Integer> instructions = new ArrayList();

			int nline = 1;

			while (scanner.hasNext()) {

				String line = scanner.nextLine().trim();

				if (line.length() > 0)

				{

					Integer inst = Instruction.parseInstruction(line, file, nline);

					if (inst != null) {

						instructions.add(inst);

					}

					else

						System.exit(0);

				}

				nline++;

			}

			scanner.close();

// Loops through and gets instructions.

			int[] instr = new int[instructions.size()];

			for (int i = 0; i < instructions.size(); i++)

				instr[i] = instructions.get(i);

// success, returns the instruction list.
			return instr;

		} catch (FileNotFoundException e) {

			System.out.println("Something went wrong. Could not find or open " + file + ".");

			System.exit(0);

		}

		return null;

	}
}
