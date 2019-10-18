
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
	private int customerInRestraunt = 0;

	protected int customerNum = 0;
	protected int customerInline = 0;

	// needs to be correct store capacity before turning in.
	// protected Customer lineArray[]=new Customer[5];
	protected LinkedList<Customer> registerLineLL = new LinkedList<Customer>();
	protected static Map<Integer, Customer> OrderLineMapUnsorted = new HashMap<>();
//   protected List<Customer> sortByOrderSize = new ArrayList<>(OrderLineMapUnsorted.values());
	protected static List<Customer> sortByOrderSizefinal = new ArrayList<>(OrderLineMapUnsorted.values());

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

			// Sets limit of how many people can come in restraunt.
			// change back to 15 when turning in.
			if (customerInRestraunt < 5) {

				++customerInRestraunt;
				Customer customer = new Customer();
				customer.setCustId(customerNum);
				System.out.println(Thread.currentThread() + "Customer " + customer.getCustId() + " walked in wanting "
						+ customer.getCustOrderSize() + " Burritos." + " There are " + customerInRestraunt
						+ " customers in the restraunt");

				// passes customer to be ordered in line.
				AddCustomerToLine(customer, true);

				servingCustomerSemaphore.release();
				isRestrauntFullSemaphore.release();

			} else {
//			Customer customer = new Customer();
//	        customer.setCustId(customerNum);
				System.out.println(
						"Restraunt is at MAX Capacity Customer number " + customerNum + " you can not come in.");
				isRestrauntFullSemaphore.release();

			}
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
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
				System.out.println(Thread.currentThread() + "****NEW LINE IS***");

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
			

			System.out.println("sortByOrderSizefinal.size ====  " + sortByOrderSizefinal.size());
			for (int i = 0; i <= sortByOrderSizefinal.size(); i++) {
				sortByOrderSizefinal.add(i, customer);
				i++;
				
				
					System.out.println(sortByOrderSizefinal.toString());
			}
			}
			 catch (InterruptedException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
//			}}
//			
			// These need to be equal.
			System.out.println("sortByOrderSizefinal====  " + sortByOrderSizefinal);
			System.out.println("OrderLineMapUnsorted====  " + OrderLineMapUnsorted);
			System.out.println("Above needs to be 1 not 2.");
//			

			try {
				putCustomersInOrderSemaphore.acquire();
				// List<Customer> sortByOrderSize = sortByOrderSizefinal;

				Collections.sort(sortByOrderSizefinal, Comparator.comparing(Customer::getCustOrderSize));
				System.out.println(Thread.currentThread() + "****UPDATED LINE IS***");

				for (Customer customers : sortByOrderSizefinal) {
					System.out.println(Thread.currentThread() + " Customer " + customers.getCustId() + "\t"
							+ "Order size= " + customers.getCustOrderSize());
					// System.out.println(sortByOrderSize);
					// sortByOrderSizefinal = sortByOrderSize;
					putCustomersInOrderSemaphore.release();

				}
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {

				System.out.println("sortByOrderSizefinal ==  " + sortByOrderSizefinal.toString());
				System.out.println(" Next server available needs to serve Customer  " + sortByOrderSizefinal.get(0));
				System.out.println(" ");

				++customerInline;
			putCustomersInOrderSemaphore.release();
				System.out.println("TEst 0000 ===sortByOrderSizefinal === " + sortByOrderSizefinal);
				//System.exit(0);
				servingCustomerSemaphore.release();

			}
		}
	}

	public void serveFirstCustomerInline(Server server) {

		Customer customeraAtCounter;

		if (sortByOrderSizefinal.isEmpty()) {
			System.out.println("No more Customers clock out.");
			clockOut(server);

		}
		customeraAtCounter = sortByOrderSizefinal.get(0);

		System.out.println(Thread.currentThread() + "Server " + server.getServerNumber()
				+ " serving smallest order, removing customer " + customeraAtCounter.getCustId()
				+ " from line moving to counter. With order size of " + customeraAtCounter.getCustOrderSize()
				+ " and has walked up to the counter area ");

		// System.out.println(" sortByOrderSizefinal to string.." +
		// sortByOrderSizefinal.toString());

		if (!sortByOrderSizefinal.isEmpty()) {

			System.out.println("sortByOrderSizefinal to string WAS .. " + sortByOrderSizefinal.toString());
			// System.out.println("Removing customer.." +
			// sortByOrderSizefinal.get(0).toString());

			sortByOrderSizefinal.remove(0);
			customerInline--;
			// does not remove customer from

			System.out.println("sortByOrderSizefinal to string NOW IS " + sortByOrderSizefinal.toString());
//			System.out.println("NEw first customer.." + sortByOrderSizefinal.get(0));
//			System.out.println("New First customer is empty " + sortByOrderSizefinal.isEmpty());

			showCurrentLine();
			Cooking(server, customeraAtCounter);

		}

	}

//	
//	if (customerInline == 1) {
//		--customerInline;
//		customeraAtCounter = sortByOrderSizefinal.get(0);
//		sortByOrderSizefinal.remove(0);
//		System.out.println(Thread.currentThread() + "customerInline ==  " + customerInline);
//
//	}
//	if (customerInline > 1) {
//
//		for (int i = 0; i < customerInline; ++i) // moving the line
//			customeraAtCounter = sortByOrderSizefinal.get(i + 1);
//		--customerInline;
//		sortByOrderSizefinal.remove(customerInline + 1);
//		System.out.println(Thread.currentThread() + " customers In line ==  " + customerInline);
//
//	}
//
//	return customeraAtCounter;

	private void showCurrentLine() {
		List<Customer> sortByOrderSize = sortByOrderSizefinal;

		Collections.sort(sortByOrderSize, Comparator.comparing(Customer::getCustOrderSize));
		System.out.println(Thread.currentThread() + "****NEW LINE IS***");

		for (Customer customers : sortByOrderSize) {
			System.out.println(Thread.currentThread() + " Customer " + customers.getCustId() + "\t" + "Order size= "
					+ customers.getCustOrderSize());
			// System.out.println(sortByOrderSize);
			sortByOrderSizefinal = sortByOrderSize;

		}
//		System.out.println("Exit");
//
//		System.exit(0);
	}

	private void clockOut(Server server) {
		System.out.println(Thread.currentThread() + " Sever " + server.getServerNumber() + " clocked out");
		System.out.println(Thread.currentThread() + "Restraunt is closed.");
		System.exit(0);

	}

	public void Cooking(Server server, Customer customerAtCounter) {
		System.out.println(
				Thread.currentThread() + "Cooking method : Server = " + server.getServerNumber() + " Customer ID = "
						+ customerAtCounter.getCustId() + " subtract 3 from " + customerAtCounter.getCustOrderSize());
		customerAtCounter.makeThreeBurritos();
		System.out.println(Thread.currentThread() + " New order size = " + customerAtCounter.getCustOrderSize());

		if (customerAtCounter.getCustOrderSize() <= 0) {
			System.out.println(Thread.currentThread() + " Time to go pay at register. ");
			payAtRegister(customerAtCounter, server);
		} else {
			System.out.println(Thread.currentThread() + " Send back to line. Server helps next guest");
			AddCustomerToLine(customerAtCounter, false);
			try {
				Thread.sleep(500);

				serveFirstCustomerInline(server);
				System.out.println("TEST999");

			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
//		}
		}

	}

//		{
//
//			// TODO
//			try {
//				ingredientSemaphore.acquire();
//				System.out.println(Thread.currentThread() + "Server " + serverNumber + " has obtained all ingredients for customer "
//						+ customerAtCounter.getCustId());
//
//				// System.out.println("Server "+serverNumber+" has obtained all ingredients for
//				// customer " + customeraAtCounter.getCustId() +"s " +
//				// customeraAtCounter.getCustOrderSize() + "burritos ");
//				ingredientSemaphore.release();
//				System.out.println(Thread.currentThread() + "Server " + serverNumber + " Cooking 3 Burritos for customer "
//						+ customerAtCounter.getCustId() + " Order size left is " + customerAtCounter.getCustOrderSize());
//
////                  System.out.println("After making three burritos " + customerAtCounter.getCustOrderSize());
//
//				if (customerAtCounter.getCustOrderSize() <= 0) {
//					// System.out.println("Customer " + customerAtCounter.getCustId() + " Being sent
//					// to register to pay..");
//
//					// System.exit(0);
//
//					// Send to pay at register
//					payAtRegister(customerAtCounter);
//				} else {
//
//					System.out.println(Thread.currentThread() + "did not complete Customer " + customerAtCounter.getCustId() + " Still wants "
//							+ customerAtCounter.getCustOrderSize() + " Burritos");
////					System.out.println("Sending back to line depending on lowest order size is NOW "
////							+ "..");
//
//					// Customer Re enters line to be sorted.
//					orderCounterLine(customerAtCounter);
//					// Server servers next person inline.
//					//serveFirstCustomerInline(serverNumber);
//
//				}
//			}
//
////              //  System.out.println("Server "+ serverNumber + " Cooking foor for " + customeraAtCounter.getCustId() +  " and their " +  customeraAtCounter.getCustOrderSize() + " burritos");
////                try {Thread.sleep(numofBurritos*1000);} //simulating servers work
////                catch (InterruptedException e) {e.printStackTrace();}
////                   
////            }
//			catch (InterruptedException e1) {
//				e1.printStackTrace();
//			}
//		}
//	}

	public void payAtRegister(Customer customerAtRegister, Server server) {

		// hold 3 customers in line
		//
		//
		try {
			registerLineSemaphore.acquire();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		System.out.println("Server " + server.getServerNumber() + " Cashing out " + customerAtRegister.getCustId()
				+ ", There can be 3 peoples in this line. ");
		customerLeavingStore(customerAtRegister);
		registerLineSemaphore.release();

		System.out.println("server " + server.getServerNumber() + " going back to get next order.");
		serveFirstCustomerInline(server);

		// registerLineLL.addLast(customerAtCounter); // adding customer into register
		// queue

		// registerLineSemaphore.release();

	}

	private void customerLeavingStore(Customer customerAtRegister) {
		System.out.println("Customer " + customerAtRegister.getCustId() + " left");
		customerAtRegister = null;
		System.out.println("Customer in RESTraunt before customer left " + customerInRestraunt);

		--customerInRestraunt;

		System.out.println("Customer in restraunt after customer left " + customerInRestraunt);

	}

//	
//	  public void GoToPay(Customer atCounter)
//	   {
//	       LinkedList<Customer> RegisterPrnt = new LinkedList<Customer>();
//	       String AtRegister="";
//	       try
//	       {
//	       semRegisterLine.acquire();
//	           RegisterLine.addLast(atCounter); //adding customer into register queue
//	                      
//	           if (Burrito.advmode)
//	           {
//	               RegisterPrnt=RegisterLine;
//	               for (int i=0; i<RegisterPrnt.size(); ++i)
//	                   AtRegister=AtRegister+"C"+RegisterPrnt.get(i).getCustID()+"<=";
//	               System.out.println(space+space+"Customers on register:");
//	               System.out.println(space+space+AtRegister);
//	           }
//	          
//	          
//	       semRegisterLine.release();
//	      
//	       }
//	       catch (InterruptedException e1) {e1.printStackTrace();}
//	   }

//	       try
//	       {
//	    	   registerLineSemaphore.acquire();
//	    	   registerLineLL.addLast(customerAtCounter); //adding customer into register queue
//	                      
//	         
//	          
//	          
//	    	   registerLineSemaphore.release();
//	      
//	       }
//	       catch (InterruptedException e1) {e1.printStackTrace();}
//	   }

//	public void Register() {
//		Customer cust;
//
//		while (!registerLineLL.isEmpty()) {
//			cust = registerLineLL.pollFirst();
//			System.out.println(Thread.currentThread() + "Customer #" + cust.getCustId() + " is paying...");
//			try {
//				Thread.sleep((int) (1000));
//			} // simulating paying
//			catch (InterruptedException e) {
//				e.printStackTrace();
//			}
//
//			System.out.println("Good bye! Customer #" + cust.getCustId() + " is leaving the store");
//			--customerInRestraunt; // customer exits the shop
//		}
//		registerSemaphore.release();
//	}

	public static Restraunt getRestraunt() {
		return restraunt;
	}

	public static void setRestraunt(Restraunt restraunt) {
		Restraunt.restraunt = restraunt;
	}

}