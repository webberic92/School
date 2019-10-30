


import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Semaphore;


public class Restaurant implements Runnable {

	static Restaurant restaurant = new Restaurant();
	int customerNum = 0;

	//Arrays representing Servers, Customers inside, outside, and total, along with register line array.
	static ArrayList<Server> ServersList = new ArrayList();
	static ArrayList<Customer> registerLineList = new ArrayList();
	static ArrayList<Customer> totalCustomers = new ArrayList();
	static ArrayList<Customer> totalInsideCustomers = new ArrayList();
	static ArrayList<Customer> totalOutsideCustomers = new ArrayList();

	// Need these for sorting.
	static Map<Integer, Customer> OrderLineMapUnsorted = new HashMap<>();
	static List<Customer> sortByOrderSizefinal = new ArrayList<>(OrderLineMapUnsorted.values());

	
	//Shows current line.
	protected Semaphore currentLineSemaphore = new Semaphore(1);
	//Shows cooking going on.
	protected Semaphore cookingSemaphore = new Semaphore(1);
	//Only one customer can walk in at a time.
	protected Semaphore OneCustomersWalkInSemaphore = new Semaphore(1);
	//Add customer to inside or outside line before another customer walks in.
	protected Semaphore AddCustomerToLineSemaphore = new Semaphore(1);
	//Serving logic.
	protected Semaphore ServingCustomerSemaphore = new Semaphore(1);
	//Register line operations.
	protected Semaphore registerLineSemaphore = new Semaphore(1);

	
	//Adds server to server array. releases server clock in semaphore once they have been added so next server can come in to work.
	//When do they wait for the serving first customer method to be called.
	public void serverClockedin(Server server) {
		if (!ServersList.isEmpty()) {
			ServersList.add(server);
			System.out.println(Thread.currentThread() + "****Servers Array****  size == " + ServersList.size());
			for (int i = 0; i <= ServersList.size() - 1; i++) {
				System.out.println(Thread.currentThread() + " Server " + ServersList.get(i).getServerNumber());
				Burrito.serverClocksInSemaphore.release();
			}
		}
		if (ServersList.isEmpty()) {
			System.out
					.println(Thread.currentThread() + "Adding Server " + server.getServerNumber() + " to serverslist.");
			ServersList.add(server);
			System.out.println(Thread.currentThread() + "****Servers Array****  size == " + ServersList.size());
			System.out.println(Thread.currentThread() + " Server " + "\t" + ServersList.get(0).getServerNumber());
			// Next Server can come in now that 1st has been added to array.
			Burrito.serverClocksInSemaphore.release();
		}
		if (ServersList.size() == 3) {
			System.out.println(Thread.currentThread() + " All our servers are here lets start taking orders!");
			System.out.println(Thread.currentThread() + "Lets wait for our customers to get here...");
			System.out.println(" ");
		}
	}

	@Override
	public void run() {
		// Creates  customers.
		CustomerWalksInRestaurant();
	}

	//Adds to inside or outside lines.
	//If inside plus outside customers = input
	//Then start serving.
	public void CustomerWalksInRestaurant() {

		// Only one customer can come in until RELEASE is called.
		try {
			OneCustomersWalkInSemaphore.acquire();

			// Creates our Customers.
			++customerNum;
			Customer customer = new Customer();
			customer.setCustId(customerNum);
			totalCustomers.add(customer);

			// 15 or less go to inside
			if (totalCustomers.size() <= 15) {
				totalInsideCustomers.add(customer);
				AddCustomerToLine(customer, true);

				if (totalInsideCustomers.size() == Burrito.input) {
					System.out.println(" ");

					System.out.println(" its time to serve !");
					System.out.println(" ");

					serveFirstCustomerInline(ServersList.get(0));

				}
			}

			// more then 15 go outside.
			if (totalCustomers.size() >= 16) {
				totalOutsideCustomers.add(customer);
				System.out.println("  ");

				System.out.println(" Customer  " + customer.getCustId()
						+ " Tried to come in but restaurant is full sending to OUTSIDE LINE");
				System.out.println("**** Current out side line...****  ");

				for (int i = 0; i < totalOutsideCustomers.size(); i++) {

					System.out.println(" Customer " + totalOutsideCustomers.get(i).getCustId() + " is in OUTSIDE LINE");

				}

				OneCustomersWalkInSemaphore.release();

				
				//If inside plus outside customers = input then start serving.
				if (((totalInsideCustomers.size()) + (totalOutsideCustomers.size())) == Burrito.input) {
					System.out.println(" ");

					System.out.println(" its time to serve !");
					System.out.println(" ");

					serveFirstCustomerInline(ServersList.get(0));
				}
			}
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	
	//If new customer add to inside line.
	//If not new customer add to line and serve first customer.
	public void AddCustomerToLine(Customer customer, Boolean newCustomer) {
		System.out.println(" ");

		
		//For first 15 new customers add to map if absent.
		if ((newCustomer == true) && totalInsideCustomers.size() <= 15) {

			// puts customer into end of map.
			// round robin
			for (int i = 1; i <= sortByOrderSizefinal.size() + 1; i++) {
				OrderLineMapUnsorted.putIfAbsent(i, customer);

			}
			
			//Sorting logic.

			List<Customer> sortByOrderSize = new ArrayList<>(OrderLineMapUnsorted.values());

			System.out.println(Thread.currentThread() + " AddcsutomertoLine new True New Customer "
					+ customer.getCustId() + " added to line time to SORT! ");
			Collections.sort(sortByOrderSize, Comparator.comparing(Customer::getCustOrderSize));
			System.out.println(Thread.currentThread() + " addtoline new true ****NEW LINE IS*** Size = "
					+ (sortByOrderSizefinal.size() + 1));

			for (Customer customers : sortByOrderSize) {
				System.out.println(Thread.currentThread() + " Customer " + customers.getCustId() + "\t" + "Order size= "
						+ customers.getCustOrderSize() + " customers hash " + customers.hashCode());
				sortByOrderSizefinal = sortByOrderSize;

			}
			OneCustomersWalkInSemaphore.release();

		}

		
		//If new customer is false add to map and show current line.
		//Show current line will sort the map.
		//Then serve new customer.
		if (newCustomer == false) {
			try {
				AddCustomerToLineSemaphore.acquire();

				sortByOrderSizefinal.add(customer);
				showCurrentLine();
				AddCustomerToLineSemaphore.release();
				ServingCustomerSemaphore.release();
				serveFirstCustomerInline(ServersList.get(0));

			} catch (InterruptedException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}

	}
	
	

	public void serveFirstCustomerInline(Server server) {

		try {
			ServingCustomerSemaphore.acquire();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		Customer customeraAtCounter;

		//If all empty then clock out.
		if (sortByOrderSizefinal.isEmpty() && registerLineList.isEmpty()) {
			System.out.println(Thread.currentThread() + " No more Customers in register or order line time for server "
					+ server.getServerNumber() + " to clock out.");
			clockOut(server);

		}

		// Handles remaining register customers.
		if (sortByOrderSizefinal.isEmpty() && !registerLineList.isEmpty()) {
			System.out.println(Thread.currentThread()
					+ " No more Customers in order line, STILL customers in register line time for server "
					+ server.getServerNumber() + " to handle the cash register.");

			handleRemainingCashRegisterline(server);
		}

		
		//Logic to serve first customer in line decrease order size by 3.
		if (!sortByOrderSizefinal.isEmpty()) {

			//So you dont get an index out of bound exception.
			customeraAtCounter = sortByOrderSizefinal.get(0);

			System.out.println(Thread.currentThread() + " Server " + server.getServerNumber()
					+ " serving smallest order, removing customer " + customeraAtCounter.getCustId()
					+ " from line moving to counter. With order size of " + customeraAtCounter.getCustOrderSize()
					+ " and has walked up to the counter area ");

			
			//Removes from line.
			sortByOrderSizefinal.remove(0);
			//Reorders line.
			showCurrentLine();
			//Starts cooking the customer that got pulled form line.
			Cooking(server, customeraAtCounter);

		}

	}

	//Clock out or customer leaves store.
	private void handleRemainingCashRegisterline(Server server) {
		if (registerLineList.isEmpty() && sortByOrderSizefinal.isEmpty()) {
			clockOut(server);
		}

		System.out.println(Thread.currentThread() + " Server " + server.getServerNumber()
				+ " Cashing out first customer at register.");
		customerLeavingStore(registerLineList.get(0), server);

	}

	
	// Takes sort by order final and reorders it and displays.
	private void showCurrentLine() {
		try {
			currentLineSemaphore.acquire();

			List<Customer> sortByOrderSize = sortByOrderSizefinal;

			Collections.sort(sortByOrderSize, Comparator.comparing(Customer::getCustOrderSize));
			System.out.println(Thread.currentThread() + " ****NEW LINE IS***");

			for (Customer customers : sortByOrderSize) {
				System.out.println(Thread.currentThread() + " Customer " + customers.getCustId() + "\t"
						+ "Order size= " + customers.getCustOrderSize());
				sortByOrderSizefinal = sortByOrderSize;
				currentLineSemaphore.release();
				cookingSemaphore.release();

			}
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	
	//Clocks out server if more are in store pass on to them, if no servers exit program store is closed.
	private void clockOut(Server server) {

		if (!ServersList.isEmpty()) {
			System.out.println(Thread.currentThread() + " Sever " + server.getServerNumber() + " clocked out");
			ServersList.remove(server);
			System.out.println(
					Thread.currentThread() + " Handling remaining servers...  servers left ==" + ServersList.size());

			if (ServersList.isEmpty()) {
				System.out.println(Thread.currentThread() + " No more Servers or Customers.");
				System.out.println(Thread.currentThread() + " Restaurant is closed!");

				System.exit(0);

			}

			clockOut(ServersList.get(0));
		}

	}

	
	// Server decrements customers order size by 3. 
	// If order complete add to register.
	// If not add back to line to be sorted.
	// Next server serves first person in line.
	public void Cooking(Server server, Customer customerAtCounter) {

		try {
			cookingSemaphore.acquire();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		System.out.println(
				Thread.currentThread() + " Cooking method : Server = " + server.getServerNumber() + " Customer ID = "
						+ customerAtCounter.getCustId() + " subtract 3 from " + customerAtCounter.getCustOrderSize());
		customerAtCounter.makeThreeBurritos();
		System.out.println(Thread.currentThread() + " Csutomer " + customerAtCounter.getCustId() + " New order size = "
				+ customerAtCounter.getCustOrderSize());

		if ((customerAtCounter.getCustOrderSize() <= 0)) {
			System.out.println(Thread.currentThread() + " ORDER COMPLETED! Sending " + customerAtCounter.getCustId()
					+ " to register line..");
			registerLineSemaphore.release();
			registerLine(customerAtCounter, server);

		}

		else {
			System.out.println(Thread.currentThread() + " Sending customer " + customerAtCounter.getCustId()
					+ " back to line. Server " + server.getServerNumber() + " goes back to server que.");
			AddCustomerToLine(customerAtCounter, false);

			Server moveServertoEndofLine = ServersList.get(0);
			ServersList.remove(0);
			ServersList.add(moveServertoEndofLine);

			cookingSemaphore.release();

			serveFirstCustomerInline(ServersList.get(0));

		}

	}

	
	//If register line gets 3 people then cash out first person.
	//If not add server back to end of server line and next server serves first customer again.
	public void registerLine(Customer customerAtRegister, Server server) {

		try {
			registerLineSemaphore.acquire();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		if (registerLineList.size() == 2) {
			System.out.println(Thread.currentThread()
					+ " Register line has a 3 person max, we must cash out first person in line. (Cant have 4th person in line next turn.) ");

			ArrayList<Customer> registerLineArrayTemp = registerLineList;
			registerLineArrayTemp.add(customerAtRegister);
			registerLineList = registerLineArrayTemp;
			customerLeavingStore(registerLineArrayTemp.get(0), server);
			registerLineSemaphore.release();
		}

		if (registerLineList.size() == 0 || registerLineList.size() == 1) {
			ArrayList<Customer> registerLineArrayTemp = registerLineList;
			registerLineArrayTemp.add(customerAtRegister);
			registerLineList = registerLineArrayTemp;
			System.out.println(Thread.currentThread() + " Register Line  now has this many peope waiting : "
					+ registerLineList.size());
			registerLineSemaphore.release();

		}

		System.out.println(
				Thread.currentThread() + " server " + server.getServerNumber() + " going back to server line.");
		Server moveServertoEndofLine = server;
		ServersList.remove(server);
		ServersList.add(moveServertoEndofLine);

		ServingCustomerSemaphore.release();
		registerLineSemaphore.release();

		serveFirstCustomerInline(ServersList.get(0));

	}

	
	// Remove customer from register line and total customers.
	// If more outside customers then add them to inside line.
	// If no remaining customers in line then handle register line.
	private void customerLeavingStore(Customer customerAtRegister, Server server) {

		System.out.println(Thread.currentThread() + " Server " + server.getServerNumber() + " Has cashed out customer "
				+ customerAtRegister.getCustId() + " and they have left satisfied.");

		totalCustomers.remove(customerAtRegister);
		registerLineList.remove(0);

		int CustInRestaurant = registerLineList.size() + sortByOrderSizefinal.size();

		System.out
				.println(Thread.currentThread() + " Resgister line now has " + registerLineList.size() + " Customers.");


		if (CustInRestaurant == 0) {
			clockOut(server);
		}

		// Addes outsie people.
		if (!totalOutsideCustomers.isEmpty()) {
			totalCustomers.add(totalOutsideCustomers.get(0));
			System.out.println(Thread.currentThread() + " Time for a waiting outside customer # "
					+ totalOutsideCustomers.get(0).getCustId() + " To come in the line. There is now 15 Customers in the restaurant again.");
			Customer CstmrToAdd = totalOutsideCustomers.get(0);

			sortByOrderSizefinal.add(CstmrToAdd);
			showCurrentLine();
			totalOutsideCustomers.remove(0);
			totalInsideCustomers.add(CstmrToAdd);
		}
		if (totalOutsideCustomers.isEmpty() && !sortByOrderSizefinal.isEmpty()) {
			System.out.println(Thread.currentThread()
					+ " More Customers in register line to cash out. but server going back to server first customer.");
		}

		if (totalOutsideCustomers.isEmpty() && sortByOrderSizefinal.isEmpty() && !registerLineList.isEmpty()) {
			System.out.println(Thread.currentThread()
					+ " Orderline and outsideline is empty time to cash out remaining customers in register line..");
			System.out.println(Thread.currentThread() + " Server " + server.getServerNumber()
					+ " Served last customer at register, adding back to server line...");
			Server nextServer = ServersList.get(0);
			ServersList.remove(0);
			ServersList.add(nextServer);
			handleRemainingCashRegisterline(ServersList.get(0));
		}

	}

	public static Restaurant getRestaurant() {
		return restaurant;
	}

	public static void setRestaurant(Restaurant restaurant) {
		Restaurant.restaurant = restaurant;
	}

}