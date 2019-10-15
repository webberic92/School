
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
	protected Map<Integer, Customer> OrderLineMapUnsorted = new HashMap<>();
//   protected List<Customer> sortByOrderSize = new ArrayList<>(OrderLineMapUnsorted.values());
	List<Customer> sortByOrderSizefinal = new ArrayList<>(OrderLineMapUnsorted.values());

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
				System.out.println(
						"Customer " + customer.getCustId() + " walked in wanting " + customer.getCustOrderSize()
								+ " Burritos." + " There are " + customerInRestraunt + " customers in the restraunt");

				// passes customer to be ordered in line.
				orderCounterLine(customer);

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

	public void orderCounterLine(Customer customer) {

		try {
			putCustomersInOrderSemaphore.acquire();

			// puts customer into end of map.
			// round robin
			for (int i = 1; i <= customerInline + 1; i++) {
				OrderLineMapUnsorted.putIfAbsent(i, customer);

			}
			
			List<Customer> sortByOrderSize = new ArrayList<>(OrderLineMapUnsorted.values());

			System.out.println("New Customer " + customer.getCustId() + " added to line time to SORT! ");
			Collections.sort(sortByOrderSize, Comparator.comparing(Customer::getCustOrderSize));

			for (Customer customers : sortByOrderSize) {
				System.out.println("****NEW LINE IS***");
				System.out.println(
						"Customer " + customers.getCustId() + "\t" + "Order size= " + customers.getCustOrderSize());
				// System.out.println(sortByOrderSize);
				sortByOrderSizefinal = sortByOrderSize;

			}

			// System.out.println(sortByOrderSizefinal);
			// System.out.println(sortByOrderSizefinal.toString());
			System.out.println(" ");

			++customerInline;
			putCustomersInOrderSemaphore.release();
			
			//Starts serving now that customers are in order.
			//servingCustomerSemaphore.release();

		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public Customer serveFirstCustomerInline(int serverNumber) {

		Customer customeraAtCounter;

		customeraAtCounter = sortByOrderSizefinal.get(0);
		System.out.println("Server " + serverNumber + " serving smallest order, removing customer "
				+ customeraAtCounter.getCustId() + " from line moving to counter. With order size of "
				+ customeraAtCounter.getCustOrderSize() + " and has walked up to the counter area ");
		if (customerInline == 1) {
			--customerInline;
			customeraAtCounter = sortByOrderSizefinal.get(0);
			sortByOrderSizefinal.remove(0);
			System.out.println("customerInline ==  " + customerInline);

		}
		if (customerInline > 1) {

			for (int i = 0; i < customerInline; ++i) // moving the line
				customeraAtCounter = sortByOrderSizefinal.get(i + 1);
			--customerInline;
			sortByOrderSizefinal.remove(customerInline + 1);
			System.out.println("customerInline ==  " + customerInline);

		}

		return customeraAtCounter;

	}

	public void Cooking(int numofBurritos, int serverNumber, Customer customerAtCounter) {
		{

			// TODO
			try {
				ingredientSemaphore.acquire();
				System.out.println("Server " + serverNumber + " has obtained all ingredients for customer "
						+ customerAtCounter.getCustId());

				// System.out.println("Server "+serverNumber+" has obtained all ingredients for
				// customer " + customeraAtCounter.getCustId() +"s " +
				// customeraAtCounter.getCustOrderSize() + "burritos ");
				ingredientSemaphore.release();
				System.out.println("Server " + serverNumber + " Cooking 3 Burritos for customer "
						+ customerAtCounter.getCustId() + " Order size " + customerAtCounter.getCustOrderSize());

//                  System.out.println("After making three burritos " + customerAtCounter.getCustOrderSize());

				if (customerAtCounter.getCustOrderSize() <= 0) {
					// System.out.println("Customer " + customerAtCounter.getCustId() + " Being sent
					// to register to pay..");

					// System.exit(0);

					// Send to pay at register
					payAtRegister(customerAtCounter);
				} else {

					System.out.println("did not complete Customer " + customerAtCounter.getCustId() + " Still wants "
							+ customerAtCounter.getCustOrderSize() + "Burritos");
					System.out.println("Sending back to line depending on lowest order size..");

					// Customer Re enters line to be sorted.
					orderCounterLine(customerAtCounter);
					// Server servers next person inline.
					serveFirstCustomerInline(serverNumber);

				}
			}

//              //  System.out.println("Server "+ serverNumber + " Cooking foor for " + customeraAtCounter.getCustId() +  " and their " +  customeraAtCounter.getCustOrderSize() + " burritos");
//                try {Thread.sleep(numofBurritos*1000);} //simulating servers work
//                catch (InterruptedException e) {e.printStackTrace();}
//                   
//            }
			catch (InterruptedException e1) {
				e1.printStackTrace();
			}
		}
	}

	public void payAtRegister(Customer customerAtCounter) {

		LinkedList<Customer> RegisterPrnt = new LinkedList<Customer>();
		String AtRegister = "";
		try {
			registerLineSemaphore.acquire();
			registerLineLL.addLast(customerAtCounter); // adding customer into register queue

			registerLineSemaphore.release();

		} catch (InterruptedException e1) {
			e1.printStackTrace();
		}
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

	public void Register() {
		Customer cust;

		while (!registerLineLL.isEmpty()) {
			cust = registerLineLL.pollFirst();
			System.out.println("Customer #" + cust.getCustId() + " is paying...");
			try {
				Thread.sleep((int) (1000));
			} // simulating paying
			catch (InterruptedException e) {
				e.printStackTrace();
			}

			System.out.println("Good bye! Customer #" + cust.getCustId() + " is leaving the store");
			--customerInRestraunt; // customer exits the shop
		}
		registerSemaphore.release();
	}

	public static Restraunt getRestraunt() {
		return restraunt;
	}

	public static void setRestraunt(Restraunt restraunt) {
		Restraunt.restraunt = restraunt;
	}

}