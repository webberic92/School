
package burritobrothers;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Semaphore;

public class Restraunt implements Runnable {

	private static Restraunt restraunt = new Restraunt();
//	private int customerInRestraunt = 0;

	protected int customerNum = 0;
	protected int customerInline = 0;

	static ArrayList<Customer> cstmrsOutsideList = new ArrayList();
	static ArrayList<Customer> registerLineList = new ArrayList();
	static ArrayList<Customer> totalCustomers = new ArrayList();

	protected static Map<Integer, Customer> OrderLineMapUnsorted = new HashMap<>();
	protected static List<Customer> sortByOrderSizefinal = new ArrayList<>(OrderLineMapUnsorted.values());
	protected static Map<Integer, Customer> WaitingMap = new HashMap<>();

	
	protected Semaphore makeCstmWaitSemaphore = new Semaphore(1);

	
	protected Semaphore isRestrauntFullSemaphore = new Semaphore(1);
	protected Semaphore putCustomersInOrderSemaphore = new Semaphore(1);
	protected Semaphore servingCustomerSemaphore = new Semaphore(0);
	protected Semaphore counterAreaSemaphore = new Semaphore(1);
	protected Semaphore registerSemaphore = new Semaphore(1);
	protected Semaphore ingredientSemaphore = new Semaphore(1);
	protected Semaphore registerLineSemaphore = new Semaphore(1);

	@Override
	public void run() {

		CustomerWalksInRestraunt();
	}

	public void CustomerWalksInRestraunt() {
		try {
			// Only one customer can come in until RELEASE is called.
			isRestrauntFullSemaphore.acquire();
			++customerNum;

			
			Customer customer = new Customer();
			customer.setCustId(customerNum);
			
			
			// Sets limit of how many people can come in restraunt.
			// change back to 15 when turning in.
			if (totalCustomers.size() <= 4) {

				
				//customer in restraunt array.
				totalCustomers.add(customer);
				System.out.println(Thread.currentThread()+ " " + totalCustomers.size());
				System.out.println(Thread.currentThread() + "Customer " + customer.getCustId() + " walked in wanting "
						+ customer.getCustOrderSize() + " Burritos." + " There are " + totalCustomers.size()
						+ " customers in the restraunt");

				// passes customer to be ordered in line.
				AddCustomerToLine(customer, true);

				servingCustomerSemaphore.release();
				isRestrauntFullSemaphore.release();

			} else {
//			Customer customer = new Customer();
//	        customer.setCustId(customerNum);
				
				makeCustomerWaitOutside(customer);
				
//				System.out.println(Thread.currentThread() + "Waiting list to get in now... " + AddToWaitingList.toString());

				isRestrauntFullSemaphore.release();

			}
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void makeCustomerWaitOutside(Customer customer) {
		try {
			makeCstmWaitSemaphore.acquire();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		ArrayList<Customer> cstmrsOutsideListTemp = cstmrsOutsideList;
		cstmrsOutsideListTemp.add(customer);
		cstmrsOutsideList = cstmrsOutsideListTemp;
		System.out.println(Thread.currentThread() +" Waiting line now is");
		
		for(int i = 0;i < cstmrsOutsideListTemp.size(); i++) {
		System.out.println(Thread.currentThread() +" CSTMR outside = " +cstmrsOutsideListTemp.get(i).getCustId());
		}
		makeCstmWaitSemaphore.release();

	}

	public void AddCustomerToLine(Customer customer, Boolean newCustomer) {

		if (newCustomer == true) {
			try {
				putCustomersInOrderSemaphore.acquire();

				// puts customer into end of map.
				// round robin
				for (int i = 1; i <= sortByOrderSizefinal.size() + 1; i++) {
					OrderLineMapUnsorted.putIfAbsent(i, customer);

				}

				List<Customer> sortByOrderSize = new ArrayList<>(OrderLineMapUnsorted.values());

				System.out.println(Thread.currentThread() + "New Customer " + customer.getCustId()
						+ " added to line time to SORT! ");
				Collections.sort(sortByOrderSize, Comparator.comparing(Customer::getCustOrderSize));
				System.out.println(Thread.currentThread() + " ****NEW LINE IS***");

				for (Customer customers : sortByOrderSize) {
					System.out.println(Thread.currentThread() + " Customer " + customers.getCustId() + "\t"
							+ "Order size= " + customers.getCustOrderSize());
					sortByOrderSizefinal = sortByOrderSize;
					putCustomersInOrderSemaphore.release();

				}
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		if (newCustomer == false) {
			try {
				putCustomersInOrderSemaphore.acquire();

					sortByOrderSizefinal.add(customer);

				
			} catch (InterruptedException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}

			try {
				putCustomersInOrderSemaphore.acquire();
				Collections.sort(sortByOrderSizefinal, Comparator.comparing(Customer::getCustOrderSize));
				System.out.println(Thread.currentThread() + " ****UPDATED LINE IS***");

				for (Customer customers : sortByOrderSizefinal) {
					System.out.println(Thread.currentThread() + " Customer " + customers.getCustId() + "\t"
							+ "Order size= " + customers.getCustOrderSize());

					putCustomersInOrderSemaphore.release();

				}
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {

				System.out.println(Thread.currentThread() + " Next server available needs to serve Customer  " + sortByOrderSizefinal.get(0).getCustId());

				++customerInline;
				putCustomersInOrderSemaphore.release();
				servingCustomerSemaphore.release();

			}
		}
	}

	public void serveFirstCustomerInline(Server server) {

		Customer customeraAtCounter;

		if (sortByOrderSizefinal.isEmpty() && registerLineList.isEmpty()) {
			System.out.println(Thread.currentThread() + " No more Customers in register or order line time for server " +server.getServerNumber() + " to clock out.");
			clockOut(server);

		}
		
		if (sortByOrderSizefinal.isEmpty() && !registerLineList.isEmpty()) {
			System.out.println(Thread.currentThread() + " No more Customers in order line, STILL customers in register line time for server " +server.getServerNumber() + " to handle the cash register.");
			//customerInRestraunt=registerLineList.size();

			handleRemainingCashRegisterline(server);

		}
		
		
		if (!sortByOrderSizefinal.isEmpty()) {
			
			//so you dont get an index out of bound exception.
			customeraAtCounter = sortByOrderSizefinal.get(0);
			
			System.out.println(Thread.currentThread() + " Server " + server.getServerNumber()
					+ " serving smallest order, removing customer " + customeraAtCounter.getCustId()
					+ " from line moving to counter. With order size of " + customeraAtCounter.getCustOrderSize()
					+ " and has walked up to the counter area ");


			//System.out.println("sortByOrderSizefinal WAS .. " + sortByOrderSizefinal.toString());
			sortByOrderSizefinal.remove(0);
			customerInline--;
			//System.out.println("sortByOrderSizefinal NOW IS " + sortByOrderSizefinal.toString());

			showCurrentLine();
			Cooking(server, customeraAtCounter);

		}

	}

	private void handleRemainingCashRegisterline(Server server) {
		if(registerLineList.isEmpty() && cstmrsOutsideList.isEmpty() && sortByOrderSizefinal.isEmpty() ) {
			clockOut(server);
		}
		
		System.out.println(Thread.currentThread() + " Server " + server.getServerNumber() + " Cashing out first customer at register.");

		//ArrayList<Customer> registerLineArrayTemp = registerLineList;
		customerLeavingStore(registerLineList.get(0),server);

	}

	private void showCurrentLine() {
		List<Customer> sortByOrderSize = sortByOrderSizefinal;

		Collections.sort(sortByOrderSize, Comparator.comparing(Customer::getCustOrderSize));
		System.out.println(Thread.currentThread() + " ****NEW LINE IS***");

		for (Customer customers : sortByOrderSize) {
			System.out.println(Thread.currentThread() + " Customer " + customers.getCustId() + "\t" + "Order size= "
					+ customers.getCustOrderSize());
			sortByOrderSizefinal = sortByOrderSize;

		}

	}

	private void clockOut(Server server) {
		System.out.println(Thread.currentThread() + " Sever " + server.getServerNumber() + " clocked out");
		System.out.println(Thread.currentThread() + " Restraunt is closed.");
		System.exit(0);

	}

	public void Cooking(Server server, Customer customerAtCounter) {
		System.out.println(
				Thread.currentThread() + " Cooking method : Server = " + server.getServerNumber() + " Customer ID = "
						+ customerAtCounter.getCustId() + " subtract 3 from " + customerAtCounter.getCustOrderSize());
		customerAtCounter.makeThreeBurritos();
		System.out.println(Thread.currentThread() + " Csutomer " + customerAtCounter.getCustId() + " New order size = " + customerAtCounter.getCustOrderSize());

	
		if ((customerAtCounter.getCustOrderSize() <= 0)) {
			System.out.println(Thread.currentThread() + " ORDER COMPLETED! Sending " +customerAtCounter.getCustId()+ " to register line..");
			registerLineSemaphore.release();
			registerLine(customerAtCounter, server);

		}
		
		
			
			
		else {
			System.out.println(Thread.currentThread() + " Sending customer " +customerAtCounter.getCustId() +" back to line. Server helps next guest");
			AddCustomerToLine(customerAtCounter, false);
			try {
				Thread.sleep(500);

				serveFirstCustomerInline(server);

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

		if(registerLineList.size() == 2) {
			System.out.println(Thread.currentThread() + " Register line has a 3 person max, we must cash out first person in line. (Cant have 4th person in line next turn.) ");

			ArrayList<Customer> registerLineArrayTemp = registerLineList;
			registerLineArrayTemp.add(customerAtRegister);
			registerLineList = registerLineArrayTemp;
			customerLeavingStore(registerLineArrayTemp.get(0),server);
			registerLineSemaphore.release();
		}

		if(registerLineList.size() == 0 || registerLineList.size() == 1 ) {
			ArrayList<Customer> registerLineArrayTemp = registerLineList;
			registerLineArrayTemp.add(customerAtRegister);
			registerLineList = registerLineArrayTemp;
			System.out.println(Thread.currentThread() + " Register Line  now has this many peope waiting : " + registerLineList.size());
			registerLineSemaphore.release();
			
		}
		
		System.out.println(Thread.currentThread() + " server " + server.getServerNumber() + " going back to get next order.");
		registerLineSemaphore.release();

		//servingCustomerSemaphore.release();
		serveFirstCustomerInline(server);

	}

	private void customerLeavingStore(Customer customerAtRegister, Server server) {
		
		
		System.out.println(Thread.currentThread() + " Customer " + customerAtRegister.getCustId() + " Has cashed out and left.");

			totalCustomers.remove(customerAtRegister);
			registerLineList.remove(0);
			
			System.out.println(Thread.currentThread() + " Resgister line now has " + registerLineList.size() + " Customers.");
			
			System.out.println(Thread.currentThread() + " Customer in restraunt now has " + totalCustomers.size() + " customers in it.");
			
			if(totalCustomers.size()==0) {
				clockOut(server);
			}
			
			//Addes outsie people.
			if(!cstmrsOutsideList.isEmpty()) {
			totalCustomers.add(cstmrsOutsideList.get(0));
			System.out.println(Thread.currentThread() + " Time for a waiting customer #" +cstmrsOutsideList.get(0).getCustId() + " To come in the line. There is now " +totalCustomers.size() + " Customers in the restraunt again." );
			Customer CstmrToAdd = cstmrsOutsideList.get(0);
			OrderLineMapUnsorted.put(0, CstmrToAdd);
			AddCustomerToLine(CstmrToAdd, false);
			cstmrsOutsideList.remove(0);

		}
		if(cstmrsOutsideList.isEmpty() && !sortByOrderSizefinal.isEmpty()) {
			System.out.println(Thread.currentThread() +" More Customers in register line to cash out. but server going back to server first customer." );
			servingCustomerSemaphore.release();
			//serveFirstCustomerInline(server);
			}
		
		if(cstmrsOutsideList.isEmpty() && sortByOrderSizefinal.isEmpty() && !registerLineList.isEmpty()){
			System.out.println(Thread.currentThread() +" Orderline and outside line is empty time to cash out remaining customers in register line.." );

			handleRemainingCashRegisterline(server);
		}
	
		
			}
		

	

	public static Restraunt getRestraunt() {
		return restraunt;
	}

	public static void setRestraunt(Restraunt restraunt) {
		Restraunt.restraunt = restraunt;
	}

}