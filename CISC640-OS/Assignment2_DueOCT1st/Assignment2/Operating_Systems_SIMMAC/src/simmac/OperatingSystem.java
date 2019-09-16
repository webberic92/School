 package simmac;

import java.util.ArrayList;

public class OperatingSystem {

ArrayList<Process  > readyQueue;  // queue of processes ready to run

Process currentProcess;         // process currently being executed

SIMMAC cpu;                     // cpu used to execute the processes

int quantum;    // value of the time quantum

int lastLoadAddress;    // address to load a program

int clock;


public OperatingSystem(SIMMAC cpu,int quantum) {

this.cpu=cpu;

this.quantum=quantum;

lastLoadAddress=0;

readyQueue=new ArrayList();

currentProcess=null;

clock=0;

}



/* prints the ready process queue */

public void printProcesses() {
System.out.print("Process Queue: ");

System.out.print("[ ");

for(int i=0; i<readyQueue.size(); i++)

{

if(i>0)

System.out.print(", ");


System.out.print(readyQueue.get(i).procid);

}

System.out.print(" ]");

}



/* Switch the current process for another from the ready queue */

public void switchProcess() {

if(currentProcess!=null) {

currentProcess.ACC = cpu.ACC;   // save current register state

currentProcess.PSIAR = cpu.PSIAR;

readyQueue.add(currentProcess);

}

currentProcess=readyQueue.remove(0);    // get process from queue

cpu.ACC=currentProcess.ACC; // load register state

cpu.PSIAR=currentProcess.PSIAR;

cpu.memoryLimit = currentProcess.memoryLimit;   // load memory limits

cpu.memoryBase = currentProcess.memoryBase;

clock = 0;  // restart clock count

System.out.println("\n Switching process.");

System.out.println("next process ID: "+currentProcess.procid);
printProcesses();

System.out.println();

}



/* Run the loaded processes in an loop until all are executed or an error happens*/

public void run() {

boolean terminate = false;

currentProcess=null;

switchProcess(); // load first process

while(!terminate)

{

boolean exitStatus = cpu.executeInstruction();

clock++;

if(exitStatus==true) { // it the process was terminated

if(readyQueue.size()>0)

{

currentProcess=null; // invalidate current process

switchProcess();    // forced swap to a different process

}

else

terminate=true; // no more processes, exit the program

}

if(clock>=quantum && !terminate) {

switchProcess();

}

}

}



/* load a SIMMAC program to memory */

void loadProgram(int [] program) {

int startAddress=lastLoadAddress;

if (lastLoadAddress + program.length >= cpu.MEMORY_SIZE) {

System.out.println("Error: cannot load program, program size exceeds memory size.");


System.exit(0);

}

for (int i=0; i<program.length; i++)

cpu.Memory[lastLoadAddress+i] = program[i];

lastLoadAddress+=program.length;

Process process= new Process(startAddress,program.length,readyQueue.size());

readyQueue.add(process);

}

}