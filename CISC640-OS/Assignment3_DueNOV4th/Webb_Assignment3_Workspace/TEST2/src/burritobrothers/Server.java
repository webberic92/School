package burritobrothers;

import java.util.concurrent.TimeUnit;

public class Server implements Runnable {

	private Customer customerAtCounter;
	private int serverNumber;

	static private int restrauntEmployees = 0;

	boolean clockedIn = true;

	public Server(Customer customerAtCounter, int serverNumber, boolean clockedIn) {
		super();
		this.customerAtCounter = customerAtCounter;
		this.serverNumber = serverNumber;
		this.clockedIn = clockedIn;
	}

	@Override
	public void run() {
		++restrauntEmployees;

		System.out.println(Thread.currentThread() + "Server " + (serverNumber) + " Came into work and is clocked in.");

		while (clockedIn) {

			try {

				// Probably need a semaphore here to release when **NEW LINE IS MADE**
				Thread.sleep(5000);
				Restraunt.getRestraunt().serveFirstCustomerInline(Server.this);

			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
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
