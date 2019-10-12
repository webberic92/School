package burritobrothers;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.concurrent.Semaphore;

public class Restraunt implements Runnable {

	
	private static Restraunt restraunt = new Restraunt();
	protected int customerNum=0;
	protected int customerInRestraunt=0;
	protected int customerInline=0;
	
	//needs to be correct store capacity before turning in.
	protected Customer lineArray[] = new Customer[5];

	
	protected Semaphore customerInRrestrauntSemaphore = new Semaphore(1);
	protected Semaphore customerInlineSemaphore = new Semaphore(1);
	protected Semaphore servingCustomerSemaphore = new Semaphore(0);
	protected Semaphore counterAreaSemaphore = new Semaphore(1);

	private Customer Cust;

	
	
	
	
	@Override
	public void run() {
		CustomerWalksInRestraunt();
	}
	
	private void CustomerWalksInRestraunt() {
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
          System.out.println("Customer number " + customer.getCustId() + " walked in wanting " + customer.getCustOrderSize() + " Burritos.");
		
          LookAtlineArray(customer,true);
          
          
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


	
	private void LookAtlineArray(Customer customer, boolean newCustomer) {
		
		

		try {
			customerInlineSemaphore.acquire();
			
			if(customerInline==0) {
				
				customerEnterslineArray(1,0,customer);
			}
			
			if (customerInline==1&&!newCustomer)
			{
				lineArray[1]=customer;
			}
			else {
				
				if(customerInline==1&&newCustomer) {
					
					if (customer.getCustOrderSize()>lineArray[0].getCustOrderSize()) {
			         
						//TEST
//						System.out.println(lineArray);

						lineArray[1]=customer;
					}
					else {
						
						lineArray[1] = lineArray[0];
						lineArray[0] = customer;
					}
				}
				else {
					
					  for (int i=0; i<customerInline-1; ++i)
                      {
                          if (lineArray[i].getCustOrderSize()>lineArray[i+1].getCustOrderSize())
                          {                                  
                        	  customerEnterslineArray(customerInline+1,i+1,customer);
                              break;
                          }
                          if (i==customerInline-2) {
                        	  lineArray[i+2]=customer;
                          }
                      }
                  }
              }
             
                       
          ++customerInline;              
          customerInlineSemaphore.release();
   
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}

	private void customerEnterslineArray(int customerInline, int sortTo, Customer customer) {
		//customer in line ==1
		//System.out.println(customerInline + "Equals 1???");

		if (customerInline==1) {
			 lineArray[0]=customer;
			//TEST
//			System.out.println("Customer in lineArray0== " + lineArray[0].toString());
		 }
	       else
	       {
	           for (int i=customerInline-1; i>sortTo; --i)
	           {
	               if(Cust.getCustOrderSize()<lineArray[i-1].getCustOrderSize())
	               {
	                   lineArray[i]=lineArray[i-1]; //moving elements
	                   if (i==sortTo+1)
	                   {
	                       lineArray[i-1]=customer;
	                       break;
	                   }
	                      
	               }
	               else
	               {
	                   lineArray[i]=customer;
	                   
	                   break;
	               }
	           }
	       }
//		//TEST
//			System.out.println(lineArray[0].toString());
//			System.out.println(lineArray[1].toString());
	   System.out.println("Customer " +customer.getCustId()+" Wants "+customer.getCustOrderSize()+" burritos and is waiting in line for service.");  
	   }		
	

	public static Restraunt getRestraunt() {
		return restraunt;
	}

	public static void setRestraunt(Restraunt restraunt) {
		Restraunt.restraunt = restraunt;
	}

	
	
	public Customer FromLineToCounter(int serverNumber) {
		
		Customer customeraAtCounter;
		
		customeraAtCounter=lineArray[0];
		
	   System.out.println("Server "+serverNumber+" serving Customer "+customeraAtCounter.getCustId());                                      
	   /*test*///Prnt.getPrnt().ServerIsFree(serverID,atCounter);
       for (int i=0; i<customerInline; ++i)        //moving the line
    	   lineArray[i]=lineArray[i+1];
       --customerInline;                           //customer is on counter, not in line anymore       
      
       lineArray[customerInline]=null;
		
		return customeraAtCounter;
	}

	
}




























//	int numCustomersInStore = 0;
//	int numCustomersInlineArray = 0;
//	int customerIDNum = 0;
//	Customer customerInQue[] = new Customer[15];
//	LinkedList<Customer> RegisterlineArray = new LinkedList<Customer>();  
//
//	Boolean storeFullNoMoreCustomers = false;
//	
//	protected Semaphore CustomerInStoreSemaphore = new Semaphore(1);
//	   protected Semaphore semStartServing = new Semaphore(0);
//	   protected Semaphore semRegister = new Semaphore(1);
//	   protected Semaphore semRegisterlineArray = new Semaphore(1);
//	   protected Semaphore semCounter = new Semaphore(1);
//	   protected Semaphore semlineArray = new Semaphore(1);
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
//		               CheckLengthlineArray(customer,true);                  
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
//private void CheckLengthlineArray(Customer customer, boolean isNewCustomer) {
//	 {
//	       try               
//	       {
//	           semlineArray.acquire();       
//	              
//	               if (numCustomersInlineArray==0) AddTolineArray(1,0,customer);  
//	               else
//	               {
//	                   if (numCustomersInlineArray==1&&!isNewCustomer) customerInQue[1]=customer;
//	                   else                              
//	                   {
//	                       if (numCustomersInlineArray==1&&isNewCustomer)
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
//	                           for (int i=0; i<numCustomersInlineArray-1; ++i)
//	                           {
//	                               if (customerInQue[i].getCustOrderSize()>customerInQue[i+1].getCustOrderSize())
//	                               {                                  
//	                            	   AddTolineArray(numCustomersInlineArray+1,i+1,customer);
//	                                   break;
//	                               }
//	                               if (i==numCustomersInlineArray-2) customerInQue[i+2]=customer;
//	                           }
//	                       }
//	                   }
//	                  
//	               }              
//	               ++numCustomersInlineArray;              
//	           semlineArray.release();
//	       }      
//	       catch (InterruptedException IE) {IE.printStackTrace();}      
//	   }	
//}
//
//private void AddTolineArray(int lineArrayPositionStart, int lineArrayPositionEnd, Customer customer) {
//
//	   
//	       if (lineArrayPositionStart==1) customerInQue[0]=customer;
//	       else
//	       {
//	           for (int i=lineArrayPositionStart-1; i>lineArrayPositionEnd; --i)
//	           {
//	               if(customer.getCustOrderSize()<customerInQue[i-1].getCustOrderSize())
//	               {
//	                   customerInQue[i]=customerInQue[i-1]; //moving elements
//	                   if (i==lineArrayPositionEnd+1)
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
//	   System.out.println("Customer #"+customer.getCustId()+" is waiting in lineArray and wants "+customer.getCustOrderSize()+" burritos.");  
//	   }
//
//
