
package burritobrothers;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Semaphore;
import java.util.concurrent.TimeUnit;

public class Restraunt implements Runnable {

	 static Restraunt restraunt = new Restraunt();
	int customerNum = 0;
	public static boolean firstServe = true;

	static ArrayList<Server> ServersList = new ArrayList();
	static ArrayList<Customer> cstmrsOutsideList = new ArrayList();
	static ArrayList<Customer> registerLineList = new ArrayList();
	static ArrayList<Customer> totalCustomers = new ArrayList();
	static ArrayList<Customer> totalInsideCustomers = new ArrayList();
	static ArrayList<Customer> totalOutsideCustomers = new ArrayList();

	static Map<Integer, Customer> OrderLineMapUnsorted = new HashMap<>();
	static List<Customer> sortByOrderSizefinal = new ArrayList<>(OrderLineMapUnsorted.values());

	protected Semaphore currentLineSemaphore = new Semaphore(1);

	protected Semaphore OneCustomersWalkInSemaphore = new Semaphore(1);
	protected Semaphore AddCustomerToLineSemaphore = new Semaphore(1);
	protected Semaphore AddCustomerToOutsideSemaphore = new Semaphore(1);
	protected Semaphore ServingCustomerSemaphore = new Semaphore(1);
	protected Semaphore registerLineSemaphore = new Semaphore(1);

	public void serverClockedin(Server server) {
		if (!ServersList.isEmpty()) {
			ServersList.add(server);
			System.out.println(Thread.currentThread() + "****Servers Array****  size == " + ServersList.size());
			for (int i = 0; i <= ServersList.size() - 1; i++) {
				System.out.println(Thread.currentThread() + " Server " + ServersList.get(i).getServerNumber());
				RunABuisness.serverClocksInSemaphore.release();
			}
		}
		if (ServersList.isEmpty()) {
			System.out.println(Thread.currentThread() + "Adding Server " + server.getServerNumber() + " to serverslist.");
			ServersList.add(server);
			System.out.println(Thread.currentThread() + "****Servers Array****  size == " + ServersList.size());
			System.out.println(Thread.currentThread() + " Server " + "\t" + ServersList.get(0).getServerNumber());
			// Next Server can come in now that 1st has been added to array.
			RunABuisness.serverClocksInSemaphore.release();
		}
		if (ServersList.size() == 3) {
			System.out.println(Thread.currentThread() + " All our servers are here lets start taking orders!");
			System.out.println(Thread.currentThread() + "Lets wait for our customers to get here...");
			System.out.println(" ");
		}
	}

	@Override
	public void run() {
		//Create twent customers
		CustomerWalksInRestraunt();

		System.out.println(Thread.currentThread() + "totalCustomers == " + totalCustomers.size());
		System.out.println(Thread.currentThread() + "Cstmrs in Restraunt == " + totalInsideCustomers.size());
		System.out.println(Thread.currentThread() + "Cstmrs outside Restraunt == " + totalOutsideCustomers.size());
		//All customes inside and outside created.
//		OneCustomersWalkInSemaphore.release();
		
		
		
//		try {
//			AddCustomerToLineSemaphore.acquire();
			AddCustomerToLine(totalInsideCustomers.get(0),true);
			totalInsideCustomers.remove(0);
			OneCustomersWalkInSemaphore.release();

//		} catch (InterruptedException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
		
		

			
		}

	
	
//		try {
//			
////			System.out.println	("serverClocksInSemaphore.availablePermits()=========     "+ RunABuisness.serverClocksInSemaphore.availablePermits());
////			System.out.println	("serverClocksInSemaphore.hasQueuedThreads();========     "+ RunABuisness.serverClocksInSemaphore.hasQueuedThreads());
////			System.out.println	("serverClocksInSemaphore.getQueueLength();==========     " + RunABuisness.serverClocksInSemaphore.getQueueLength());
//
//			if (RunABuisness.serverClocksInSemaphore.tryAcquire(5, TimeUnit.SECONDS)) {
//				if(totalCustomers.size() ==5) {
//				serveFirstCustomerInline(ServersList.get(0));
//				}
//
//			}
//		} catch (InterruptedException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}}


	public void CustomerWalksInRestraunt() {
	
			// Only one customer can come in until RELEASE is called.
			try {
				OneCustomersWalkInSemaphore.acquire();
				
				
				//Creates our Customers.
				++customerNum;
				Customer customer = new Customer();
				customer.setCustId(customerNum);
				totalCustomers.add(customer);
				
				
				//4 or less go to inside
				if(totalCustomers.size() <=5)
				totalInsideCustomers.add(customer);
				//5 of more go outside.;
				if(totalCustomers.size() > 5) {
					totalOutsideCustomers.add(customer);
				}
				

			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		//	ServingCustomerSemaphore.acquire();
		
			
		}

//			// Sets limit of how many people can come in restraunt.
//			// change back to 15 when turning in.
//			if (totalCustomers.size() == 5) {
//				System.out.println(Thread.currentThread() + "888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888test34234 ");
//
//				makeCustomerWaitOutside(customer);
//				OneCustomersWalkInSemaphore.release();
//							
//			} 
//			if (totalCustomers.size() <= 4) { 	
//				// customer in restraunt array.
//				totalCustomers.add(customer);
//				System.out.println(Thread.currentThread() + "Customer " + customer.getCustId() + " walked in wanting "
//						+ customer.getCustOrderSize() + " Burritos." + " There are " + totalCustomers.size()
//						+ " customers in the restraunt");
//				// passes customer to be ordered in line.
//				AddCustomerToLine(customer, true);
//				
//			}
//		} catch (InterruptedException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		System.out.println(Thread.currentThread() + "End of customerwalksinmethod  totalCustomers size ==" +totalCustomers.size());
//		
//		RunABuisness.serverClocksInSemaphore.release();
	

	public void makeCustomerWaitOutside(Customer customer) {
		System.out.println(Thread.currentThread() + "*** Start of making cutomer outside mthod");

		try {
			AddCustomerToOutsideSemaphore.acquire();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		ArrayList<Customer> cstmrsOutsideListTemp = cstmrsOutsideList;
		cstmrsOutsideListTemp.add(customer);
		cstmrsOutsideList = cstmrsOutsideListTemp;
		System.out.println(Thread.currentThread() + " Customer " + customer.getCustId()
				+ " tried to come in but Restraunt full. Adding to outside list.");

		System.out.println(Thread.currentThread() + "*** Waiting Outside Line *** length = " + cstmrsOutsideList.size());

		for (int i = 0; i < cstmrsOutsideListTemp.size(); i++) {
			System.out.println(Thread.currentThread() + " CSTMR outside = " + cstmrsOutsideListTemp.get(i).getCustId());
		}
		System.out.println(Thread.currentThread() + "*** end of making cutomer outside mthod");

		AddCustomerToOutsideSemaphore.release();

		//ServingCustomerSemaphore.release();

	}

	public void AddCustomerToLine(Customer customer, Boolean newCustomer) {

		if (newCustomer == true) {
			try {
//				AddCustomerToOutsideSemaphore.release();
				AddCustomerToLineSemaphore.acquire();
				
				// puts customer into end of map.
				// round robin
				for (int i = 1; i <= sortByOrderSizefinal.size() + 1; i++) {
					OrderLineMapUnsorted.putIfAbsent(i, customer);

				}

				List<Customer> sortByOrderSize = new ArrayList<>(OrderLineMapUnsorted.values());

				System.out.println(Thread.currentThread() + "New Customer " + customer.getCustId()
						+ " added to line time to SORT! ");
				Collections.sort(sortByOrderSize, Comparator.comparing(Customer::getCustOrderSize));
				System.out.println(
						Thread.currentThread() + " ****NEW LINE IS*** Size = " + (sortByOrderSizefinal.size() + 1));

				for (Customer customers : sortByOrderSize) {
					System.out.println(Thread.currentThread() + " Customer " + customers.getCustId() + "\t"
							+ "Order size= " + customers.getCustOrderSize());
					sortByOrderSizefinal = sortByOrderSize;
					AddCustomerToLineSemaphore.release();

				}
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		if (newCustomer == false) {
			try {
				AddCustomerToLineSemaphore.acquire();

				sortByOrderSizefinal.add(customer);

			} catch (InterruptedException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}

			try {
				AddCustomerToLineSemaphore.acquire();
				Collections.sort(sortByOrderSizefinal, Comparator.comparing(Customer::getCustOrderSize));
				System.out.println(
						Thread.currentThread() + " **** UPDATED LINE IS ***  Size = " + sortByOrderSizefinal.size());

				for (Customer customers : sortByOrderSizefinal) {
					System.out.println(Thread.currentThread() + " Customer " + customers.getCustId() + "\t"
							+ "Order size= " + customers.getCustOrderSize());

					AddCustomerToLineSemaphore.release();

				}
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {

				System.out.println(Thread.currentThread() + " Next server available needs to serve Customer  "
						+ sortByOrderSizefinal.get(0).getCustId());

				AddCustomerToLineSemaphore.release();
				ServingCustomerSemaphore.release();

			}

		}
		if (totalCustomers.size() == 5) {
			
			if (firstServe == false) {
				System.out.println(Thread.currentThread() + "**F Restraunt at max capacity **  size = "
						+ totalCustomers.size() + " Lets start serving our customers!");

				Server moveServertoEndofLine = ServersList.get(0);
				ServersList.remove(0);
				ServersList.add(moveServertoEndofLine);

				//note here
			
					//AddCustomerToOutsideSemaphore.acquire();
					serveFirstCustomerInline(ServersList.get(0));
					//AddCustomerToOutsideSemaphore.release();
				
			}
			if (firstServe == true) {
				System.out.println(Thread.currentThread() + "**T Restraunt at max capacity **  size = "
						+ totalCustomers.size() + " Lets start serving our customers!");
				firstServe = false;
					//AddCustomerToOutsideSemaphore.acquire();
				System.out.println("**First Server.**");
					serveFirstCustomerInline(ServersList.get(0));

				

			
			}
//			
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

		if (sortByOrderSizefinal.isEmpty() && registerLineList.isEmpty()) {
			System.out.println(Thread.currentThread() + " No more Customers in register or order line time for server "
					+ server.getServerNumber() + " to clock out.");
			clockOut(server);

		}

		//Handles remaining register customers.
		if (sortByOrderSizefinal.isEmpty() && !registerLineList.isEmpty()) {
			System.out.println(Thread.currentThread()
					+ " No more Customers in order line, STILL customers in register line time for server "
					+ server.getServerNumber() + " to handle the cash register.");

			handleRemainingCashRegisterline(server);
//			AddCustomerToOutsideSemaphore.release();
		}

		if (!sortByOrderSizefinal.isEmpty()) {

			// so you dont get an index out of bound exception.
			customeraAtCounter = sortByOrderSizefinal.get(0);

			System.out.println(Thread.currentThread() + " Server " + server.getServerNumber()
					+ " serving smallest order, removing customer " + customeraAtCounter.getCustId()
					+ " from line moving to counter. With order size of " + customeraAtCounter.getCustOrderSize()
					+ " and has walked up to the counter area ");

			sortByOrderSizefinal.remove(0);

			//AddCustomerToOutsideSemaphore.release();
			showCurrentLine();
			Cooking(server, customeraAtCounter);

		}

	}

	private void handleRemainingCashRegisterline(Server server) {
		if (registerLineList.isEmpty() && cstmrsOutsideList.isEmpty() && sortByOrderSizefinal.isEmpty()) {
			clockOut(server);
		}

		System.out.println(Thread.currentThread() + " Server " + server.getServerNumber()
				+ " Cashing out first customer at register.");

		// ArrayList<Customer> registerLineArrayTemp = registerLineList;
		customerLeavingStore(registerLineList.get(0), server);

	}

	private void showCurrentLine() {
		try {
			currentLineSemaphore.acquire();
	

		List<Customer> sortByOrderSize = sortByOrderSizefinal;

		Collections.sort(sortByOrderSize, Comparator.comparing(Customer::getCustOrderSize));
		System.out.println(Thread.currentThread() + " ****NEW LINE IS***");

		for (Customer customers : sortByOrderSize) {
			System.out.println(Thread.currentThread() + " Customer " + customers.getCustId() + "\t" + "Order size= "
					+ customers.getCustOrderSize());
			sortByOrderSizefinal = sortByOrderSize;
			currentLineSemaphore.release();
		}
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	private void clockOut(Server server) {
		
		
		
		if(!ServersList.isEmpty()) {
		System.out.println(Thread.currentThread() + " Sever " + server.getServerNumber() + " clocked out");
		ServersList.remove(server);
		System.out.println(Thread.currentThread() + " Handling remaining servers...  servers left ==" +  ServersList.size());
		
		if(ServersList.isEmpty()) {
			System.out.println(Thread.currentThread() + " No more Servers or Customers.");
			System.out.println(Thread.currentThread() + " Restraunt is closed!");

			System.exit(0);

			}
		
		clockOut(ServersList.get(0));
		}
	
	}

	public void Cooking(Server server, Customer customerAtCounter) {
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
			try {
				Thread.sleep(500);

				Server moveServertoEndofLine = ServersList.get(0);
				ServersList.remove(0);
				ServersList.add(moveServertoEndofLine);

				serveFirstCustomerInline(ServersList.get(0));

			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

	}

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

		if (ServersList.get(0) == server) {
			System.out.println(
					Thread.currentThread() + " ^^^^ Does server list 0 = server ?" + ServersList.get(0).equals(server));

			System.out.println(Thread.currentThread() + " ^^^^ Does server list 0 = server ?");

		}
		ServingCustomerSemaphore.release();
		registerLineSemaphore.release();

		serveFirstCustomerInline(ServersList.get(0));

	}

	private void customerLeavingStore(Customer customerAtRegister, Server server) {

		System.out.println(
				Thread.currentThread() + " Server " + server.getServerNumber() + " Has cashed out customer " + customerAtRegister.getCustId() + " and they have left satisfied.");

		totalCustomers.remove(customerAtRegister);
		registerLineList.remove(0);

		System.out
				.println(Thread.currentThread() + " Resgister line now has " + registerLineList.size() + " Customers.");

		System.out.println(Thread.currentThread() + " Customer in restraunt now has " + totalCustomers.size()
				+ " customers in it.");

		if (totalCustomers.size() == 0) {
			clockOut(server);
		}

		// Addes outsie people.
		if (!cstmrsOutsideList.isEmpty()) {
			totalCustomers.add(cstmrsOutsideList.get(0));
			System.out.println(Thread.currentThread() + " Time for a waiting customer #"
					+ cstmrsOutsideList.get(0).getCustId() + " To come in the line. There is now "
					+ totalCustomers.size() + " Customers in the restraunt again.");
			Customer CstmrToAdd = cstmrsOutsideList.get(0);
			OrderLineMapUnsorted.put(0, CstmrToAdd);
			AddCustomerToLine(CstmrToAdd, false);
			cstmrsOutsideList.remove(0);

		}
		if (cstmrsOutsideList.isEmpty() && !sortByOrderSizefinal.isEmpty()) {
			System.out.println(Thread.currentThread()
					+ " More Customers in register line to cash out. but server going back to server first customer.");
		}

		if (cstmrsOutsideList.isEmpty() && sortByOrderSizefinal.isEmpty() && !registerLineList.isEmpty()) {
			System.out.println(Thread.currentThread()
					+ " Orderline and outsideline is empty time to cash out remaining customers in register line..");
			System.out.println(Thread.currentThread()
					+ " Server " + server.getServerNumber() + " Served last customer at register, adding back to server line...");
				Server nextServer = ServersList.get(0);
				ServersList.remove(0);
				ServersList.add(nextServer);
				handleRemainingCashRegisterline(ServersList.get(0));
		}

	}

	public static Restraunt getRestraunt() {
		return restraunt;
	}

	public static void setRestraunt(Restraunt restraunt) {
		Restraunt.restraunt = restraunt;
	}

}