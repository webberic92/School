package burritobrothers;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.concurrent.Semaphore;

public class Restraunt implements Runnable {

	private static Restraunt restraunt = new Restraunt();
	protected Semaphore customerInRrestrauntSemaphore = new Semaphore(1);
	protected int customerNum=0;
	protected int CustomerInRestraunt=0;

	
	
	
	
	@Override
	public void run() {
		CustomerWalksInRestraunt();
	}
	
	private void CustomerWalksInRestraunt() {
		try {
			//Onle one customer can come in until RELEASE is called.
			customerInRrestrauntSemaphore.acquire();
		++customerNum;
			
		
		//Sets limit of how many eople can come in restraunt.
		//change back to 15 when turning in.
		if(CustomerInRestraunt < 5){
          System.out.println("Restraunt NOT full");
          ++CustomerInRestraunt;
          System.out.println(CustomerInRestraunt);
          Customer customer = new Customer();
          customer.setCustId(customerNum);
          System.out.println("Customer number " + customer.getCustId() + " walked in wanting " + customer.getCustOrderSize() + " Burritos.");
		  customerInRrestrauntSemaphore.release();


		}
		else {
			Customer customer = new Customer();
	        customer.setCustId(customerNum);
            System.out.println("Restraunt is at MAX Capacity Customer number " + customer.getCustId() + " you can not come in. Get your " + customer.getCustOrderSize() + " Burritos some where else. Taco bell?");
			customerInRrestrauntSemaphore.release();

		}
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}


	
	public static Restraunt getRestraunt() {
		return restraunt;
	}

	public static void setRestraunt(Restraunt restraunt) {
		Restraunt.restraunt = restraunt;
	}

	
}




























//	int numCustomersInStore = 0;
//	int numCustomersInLine = 0;
//	int customerIDNum = 0;
//	Customer customerInQue[] = new Customer[15];
//	LinkedList<Customer> RegisterLine = new LinkedList<Customer>();  
//
//	Boolean storeFullNoMoreCustomers = false;
//	
//	protected Semaphore CustomerInStoreSemaphore = new Semaphore(1);
//	   protected Semaphore semStartServing = new Semaphore(0);
//	   protected Semaphore semRegister = new Semaphore(1);
//	   protected Semaphore semRegisterLine = new Semaphore(1);
//	   protected Semaphore semCounter = new Semaphore(1);
//	   protected Semaphore semLine = new Semaphore(1);
//	   protected Semaphore semIngredients = new Semaphore(1);
//
//
//	public void start() {
//		  {      
//		       try
//		       {
//		    	   CustomerInStoreSemaphore.acquire(); 
//		           ++customerIDNum;
//		          
//		           if(numCustomersInStore<15)
//		           {                  
//		               ++numCustomersInStore;              
//		               Customer customer = new Customer();
//		               customer.setCustId(customerIDNum);
//		               System.out.println("Customer #"+customer.getCustId()+" wants "+customer.getCustOrderSize()+" Burritos.");
//		               CheckLengthLine(customer,true);                  
//		                                      
//		             //  semStartServing.release(); // letting server now that there is customer in the store. to do:
////		               CustomerInStoreSemaphore.release(); // now other customer can enter the store
//		           }
//		           else
//		           {
//		               System.out.println("Store is full " + customerIDNum + "had to leave.");
//		               CustomerInStoreSemaphore.release(); // now other customer can enter the store
//		           }
//		       }
//		       catch (InterruptedException e1) {
//		    	   e1.printStackTrace();
//		    	   }
//		   }		
//	}
//
//private void CheckLengthLine(Customer customer, boolean isNewCustomer) {
//	 {
//	       try               
//	       {
//	           semLine.acquire();       
//	              
//	               if (numCustomersInLine==0) AddToLine(1,0,customer);  
//	               else
//	               {
//	                   if (numCustomersInLine==1&&!isNewCustomer) customerInQue[1]=customer;
//	                   else                              
//	                   {
//	                       if (numCustomersInLine==1&&isNewCustomer)
//	                       {
//	                           if (customer.getCustOrderSize()>customerInQue[0].getCustOrderSize()) customerInQue[1]=customer;
//	                           else
//	                           {
//	                               customerInQue[1]=customerInQue[0];
//	                               customerInQue[0]=customer;
//	                           }
//	                       }
//	                       else
//	                       {  
//	                           for (int i=0; i<numCustomersInLine-1; ++i)
//	                           {
//	                               if (customerInQue[i].getCustOrderSize()>customerInQue[i+1].getCustOrderSize())
//	                               {                                  
//	                            	   AddToLine(numCustomersInLine+1,i+1,customer);
//	                                   break;
//	                               }
//	                               if (i==numCustomersInLine-2) customerInQue[i+2]=customer;
//	                           }
//	                       }
//	                   }
//	                  
//	               }              
//	               ++numCustomersInLine;              
//	           semLine.release();
//	       }      
//	       catch (InterruptedException IE) {IE.printStackTrace();}      
//	   }	
//}
//
//private void AddToLine(int linePositionStart, int linePositionEnd, Customer customer) {
//
//	   
//	       if (linePositionStart==1) customerInQue[0]=customer;
//	       else
//	       {
//	           for (int i=linePositionStart-1; i>linePositionEnd; --i)
//	           {
//	               if(customer.getCustOrderSize()<customerInQue[i-1].getCustOrderSize())
//	               {
//	                   customerInQue[i]=customerInQue[i-1]; //moving elements
//	                   if (i==linePositionEnd+1)
//	                   {
//	                       customerInQue[i-1]=customer;
//	                       break;
//	                   }
//	                      
//	               }
//	               else
//	               {
//	                   customerInQue[i]=customer;
//	                   break;
//	               }
//	           }
//	       }
//	   System.out.println("Customer #"+customer.getCustId()+" is waiting in line and wants "+customer.getCustOrderSize()+" burritos.");  
//	   }
//
//
