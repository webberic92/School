
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
	private int customerInRestraunt=0;

	protected int customerNum=0;
	protected int customerInline=0;
	
	//needs to be correct store capacity before turning in.
	//protected Customer lineArray[]=new Customer[5];
    protected LinkedList<Customer> registerLineLL = new LinkedList<Customer>();  
   protected  Map<Integer, Customer> OrderLineMapUnsorted = new HashMap<>();
//   protected List<Customer> sortByOrderSize = new ArrayList<>(OrderLineMapUnsorted.values());
	List<Customer> sortByOrderSizefinal = new ArrayList<>(OrderLineMapUnsorted.values());



	
	protected Semaphore customerInRrestrauntSemaphore = new Semaphore(1);
	protected Semaphore customerInlineSemaphore = new Semaphore(1);
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
			//Only one customer can come in until RELEASE is called.
			customerInRrestrauntSemaphore.acquire();
		++customerNum;
		
		//Sets limit of how many people can come in restraunt.
		//change back to 15 when turning in.
		if(customerInRestraunt < 5){
			
          ++customerInRestraunt;
          Customer customer = new Customer();
          customer.setCustId(customerNum);
          System.out.println("Customer " + customer.getCustId() + " walked in wanting " + customer.getCustOrderSize() + " Burritos." + " There are " + customerInRestraunt + " customers in the restraunt");
		
          
          // passes customer and true they are a new customer.
          orderCounterLine(customer); 
          
         // servingCustomerSemaphore.release();
          customerInRrestrauntSemaphore.release();


		}
		else {
//			Customer customer = new Customer();
//	        customer.setCustId(customerNum);
            System.out.println("Restraunt is at MAX Capacity Customer number " + customerNum + " you can not come in.");
			customerInRrestrauntSemaphore.release();

		}
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}


	
	public void orderCounterLine(Customer customer) {
		

		try {
			customerInlineSemaphore.acquire();
			
				for (int i = 1; i <= customerInline +1;i++) {
//					registerLineMap.put(i, customer);
					OrderLineMapUnsorted.putIfAbsent(i, customer);

					
					
				}
				List<Customer> sortByOrderSize = new ArrayList<>(OrderLineMapUnsorted.values());

				 System.out.println("New Customer added to line time to SORT! ");
				 Collections.sort(sortByOrderSize, Comparator.comparing(Customer:: getCustOrderSize));

				 for(Customer customers : sortByOrderSize) {
//					 System.out.println("Updated Line...");
					 System.out.println("Customer " + customers.getCustId() + "\t" + "Order size= " + customers.getCustOrderSize());
					 //System.out.println(sortByOrderSize); 
					 sortByOrderSizefinal = sortByOrderSize;
					 
				 }
				 
			

		 // System.out.println(sortByOrderSizefinal);
		  //System.out.println(sortByOrderSizefinal.toString());
		  System.out.println(" ");          

          ++customerInline;              
          customerInlineSemaphore.release();
          servingCustomerSemaphore.release();
   
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}


	
	public Customer serveFirstCustomerInline(int serverNumber) {
		
		Customer customeraAtCounter;
		
		customeraAtCounter=sortByOrderSizefinal.get(0); 
		   System.out.println("Server "+ serverNumber+ " is about to serve the next person in line with the smallest order, this is customer " + customeraAtCounter.getCustId() + " With order size of " +customeraAtCounter.getCustOrderSize() + " and has walked up to the counter area ");
	   
		   if(customerInline==1) {
			   --customerInline;
			   customeraAtCounter=sortByOrderSizefinal.get(0);
			   sortByOrderSizefinal.remove(0);
		   }
		   else {
			   for (int i=0; i<customerInline; ++i)        //moving the line
		    	   customeraAtCounter=sortByOrderSizefinal.get(i +1);
		       --customerInline;  
//		       //customer is on counter, not in line anymore 
		  //     Customer customeraAtCountertest =  sortByOrderSizefinal.get(customeraAtCounter.getCustId() +1);
//		       customeraAtCountertest=null;
		       sortByOrderSizefinal.remove(customerInline + 1);
//		       Customer RemoveEndofLineCustomer =sortByOrderSizefinal.get(customerInline+ 1);
//		       RemoveEndofLineCustomer=null;
			   
			   
		   }
		   
			return customeraAtCounter;    
	}
	
	

	public void Cooking(int numofBurritos, int serverNumber, int customerNumb) {
        {
        	
            
        	//TODO
            try
            {
                ingredientSemaphore.acquire();
                System.out.println("Server "+serverNumber+" has obtained all ingredients");    

             //   System.out.println("Server "+serverNumber+" has obtained all ingredients for customer " + customeraAtCounter.getCustId() +"s " + customeraAtCounter.getCustOrderSize() +  "burritos ");    
                ingredientSemaphore.release();
                  System.out.println("Server "+ serverNumber + " Cooking 3 Burritos for customer " + customerNumb);

              //  System.out.println("Server "+ serverNumber + " Cooking foor for " + customeraAtCounter.getCustId() +  " and their " +  customeraAtCounter.getCustOrderSize() + " burritos");
                try {Thread.sleep(numofBurritos*1000);} //simulating servers work
                catch (InterruptedException e) {e.printStackTrace();}
                   
            }
            catch (InterruptedException e1) {e1.printStackTrace();}
        }
	}

	public void payAtRegister(Customer customerAtCounter) {

	  
	       try
	       {
	    	   registerLineSemaphore.acquire();
	    	   registerLineLL.addLast(customerAtCounter); //adding customer into register queue
	                      
	         
	          
	          
	    	   registerLineSemaphore.release();
	      
	       }
	       catch (InterruptedException e1) {e1.printStackTrace();}
	   }
	
	
	 public void Register()	 {
	       Customer cust;
	       
	       while (!registerLineLL.isEmpty())
	       {              
	           cust=registerLineLL.pollFirst();
	           System.out.println("Customer #"+cust.getCustId()+" is paying...");
	           try {Thread.sleep((int)(1000));
	           } //simulating paying
	           catch (InterruptedException e) {e.printStackTrace();}
	                          
	          
	           System.out.println("Good bye! Customer #"+cust.getCustId() +" is leaving the store");
	           --customerInRestraunt;   //customer exits the shop
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