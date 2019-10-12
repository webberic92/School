package burritobrothers;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.concurrent.Semaphore;

public class Restraunt implements Runnable {

	
	private static Restraunt restraunt = new Restraunt();
	private int customerInRestraunt=0;

	protected int customerNum=0;
	protected int customerInline=0;
	
	//needs to be correct store capacity before turning in.
	protected Customer lineArray[]=new Customer[5];
    protected LinkedList<Customer> registerLineLL = new LinkedList<Customer>();  


	
	protected Semaphore customerInRrestrauntSemaphore = new Semaphore(1);
	protected Semaphore customerInlineSemaphore = new Semaphore(1);
	protected Semaphore servingCustomerSemaphore = new Semaphore(1);
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
          System.out.println("Customer number " + customer.getCustId() + " walked in wanting " + customer.getCustOrderSize() + " Burritos.");
		
          LookAtlineArray(customer,true);
          
          servingCustomerSemaphore.release();
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


	
	public void LookAtlineArray(Customer customer, boolean newCustomer) {
		
		

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

	public void customerEnterslineArray(int customerInline, int sortTo, Customer customer) {
		//customer in line ==1
		//System.out.println(customerInline + "Equals 1???");

		if (customerInline==1) {
			 lineArray[0]=customer;
			
			System.out.println(customer.getCustId() + "  " + customer.getCustOrderSize() );

		 }
	       else
	       {
	           for (int i=customerInline-1; i>sortTo; --i)
	           {
	               if(customer.getCustOrderSize()<lineArray[i-1].getCustOrderSize())
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

		   System.out.println("lineArray test in fromlinetocountermethod " + lineArray[0]);  

		
		
		Customer customeraAtCounter;
		
		customeraAtCounter=lineArray[0];
		
		
		   System.out.println(" above error Server "+serverNumber); 
		   System.out.println(lineArray[0]);  

		   System.out.println(customeraAtCounter.getCustId());  
		   
		   
	   System.out.println("Server "+serverNumber+" serving Customer "+customeraAtCounter.getCustId());                                      
	   
       for (int i=0; i<customerInline; ++i)        //moving the line
    	   lineArray[i]=lineArray[i+1];
       --customerInline;  
       //customer is on counter, not in line anymore       
       System.out.println("DELTA TEST"); 
       lineArray[customerInline+1]=null;
		
		return customeraAtCounter;
	}

	public void Cooking(int numofBurritos, int serverNumber) {
        System.out.println("Cooking food");
        {
            
            try
            {
                ingredientSemaphore.acquire();
                System.out.println("Server "+serverNumber+" has obtained all ingredients");    
                ingredientSemaphore.release();
                System.out.println("Cooking...");
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
}



























