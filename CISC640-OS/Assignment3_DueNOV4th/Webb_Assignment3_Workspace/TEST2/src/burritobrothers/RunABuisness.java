package burritobrothers;

import java.util.concurrent.Semaphore;

public class RunABuisness {
	
	
	protected static Semaphore serverClocksInSemaphore = new Semaphore(1);



	public static void main(String[] args) throws Exception {

		System.out.println(Thread.currentThread() + " Store is now open!");
		System.out.println(Thread.currentThread() + " Creating 3 Server Threads.");

//		 Creates 3 servers.
		for (int i = 1; i < 4 ; ++i) {
			

			Thread Server = new Thread(new Server(i));
			serverClocksInSemaphore.acquire();;
			Server.start();
			

		}
	

		
		// creates 15 customers
		// Suppose to be 15 customers.change before turning in.
		for (int i = 1; i <9 ; ++i) {
			new Restraunt();
			Thread Customer = new Thread(Restraunt.getRestraunt());
			Customer.start();

			// This controls how fast customers are coming in.
			

		}
	}
	}

