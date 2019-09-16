package simmac;

import java.io.File;

import java.io.FileNotFoundException;

import java.util.ArrayList;

import java.util.Scanner;

public class Main {

/* open a SIMMAC program file and parse its contents, if everything is fine

returns an array with all the instructions */

public static int [] readProgramFile(String filename) {

try {

Scanner s = new Scanner(new File(filename));

ArrayList<Integer> instructions = new ArrayList();

int nline = 1;

while (s.hasNext()){

String line=s.nextLine().trim();

if(line.length()>0)

{

Integer inst=Instruction.parseInstruction(line,filename,nline); // parse the instruction contained in the current line

if (inst != null) { // if the instruction was valid

instructions.add(inst);

}

else

System.exit(0);

}

nline++;

}

s.close();

int [] instr = new int[instructions.size()];

for(int i=0; i<instructions.size(); i++)

instr[i]=instructions.get(i);

return instr; // success, return the instruction list

} catch (FileNotFoundException e) {


System.out.println("ERROR: program file " + filename +" could not be opened.");

System.exit(0); //failure

}

return null;

}

/**

* @param args the command line arguments

*/

public static void main(String[] args) {

System.out.println("Please enter the time quantum value: "); // ask for the filename to use

Scanner s = new Scanner(System.in);

int quantum = s.nextInt();

SIMMAC cpu = new SIMMAC();

OperatingSystem os = new OperatingSystem(cpu,quantum);

if(args.length==0) {

boolean done=false;

ArrayList<String> filenames=new ArrayList();

while(!done) {

System.out.print("Please enter file name to lead.");  // ask for the filename to use

filenames.add(s.next());

System.out.println("Do you want to load another file? (Y/N): ");


String c=s.next();

if(c.toUpperCase().equals("N") || !c.toUpperCase().equals("Y"));

done=true;

}

for(int i=0; i<filenames.size(); i++) {

int [] program = readProgramFile(filenames.get(i));

os.loadProgram(program);

}

}

else {

for(int i=0; i<args.length; i++)

{

int [] program = readProgramFile(args[i]);

os.loadProgram(program);

}

}

os.run();   // run the processes

}

} 
