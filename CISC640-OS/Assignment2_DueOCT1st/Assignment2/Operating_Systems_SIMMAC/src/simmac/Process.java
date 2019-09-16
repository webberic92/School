 package simmac;

// Definition of a process control block

public class Process {

public int procid;

public int ACC;

public int PSIAR;

public int memoryBase;

public int memoryLimit;

public Process(int address,int size,int procid) {

this. procid=procid;

ACC = 0;

PSIAR = 0;

memoryBase = address;

memoryLimit=address+size;

}

} 