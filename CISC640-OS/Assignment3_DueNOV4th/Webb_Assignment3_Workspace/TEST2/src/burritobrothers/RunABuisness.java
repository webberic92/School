package burritobrothers;

public class RunABuisness {
	


	public static void main(String[] args) throws Exception {

		System.out.println("Store is now open!");
		System.out.println("Creating 3 Server Threads.");

//		// Creates 3 servers.
		for (int i = 1; i < 2; ++i) {
			Thread Server = new Thread(new Server(i));
			Server.start();

		}

		// creates 15 customers
		// Suppose to be 15 customers.change before turning in.
		for (int i = 1; i < 3; ++i) {
			new Restraunt();
			Thread Customer = new Thread(Restraunt.getRestraunt());
			Customer.start();

			// This controls how fast customers are coming in.
			try {
				Thread.sleep(900);
			} catch (InterruptedException ie) {
				ie.printStackTrace();
			}

		}

	}
}
