

import java.util.ArrayList;

//Pojo for servers, runs clocked in method in Restaurant.
import java.util.concurrent.Semaphore;
import java.util.concurrent.TimeUnit;

public class Server implements Runnable {

	private Customer customerAtCounter;
	private int serverNumber;


	boolean clockedIn = true;

	protected Semaphore serverClocksInSemaphore = new Semaphore(1);

	
	
	public Server(Customer customerAtCounter, int serverNumber, boolean clockedIn) {
		super();
		this.customerAtCounter = customerAtCounter;
		this.serverNumber = serverNumber;
		this.clockedIn = clockedIn;
	}

	@Override
	public void run() {
		
		//Clocks in server.
			System.out.println(Thread.currentThread() + "Server " + (serverNumber) + " Came into work and is clocked in.");
			Restaurant.getRestaurant().serverClockedin(Server.this);
		
		}
	

	public Server(int serverNumber) {
		this.serverNumber = serverNumber;

	}

	public int getServerNumber() {
		return serverNumber;
	}

	public void setServerNumber(int serverNumber) {
		this.serverNumber = serverNumber;
	}

}
