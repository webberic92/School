package burritobrothers;

import java.util.concurrent.TimeUnit;

public class Server implements Runnable {

	private Customer customerAtCounter;
	private int serverNumber;
	
	static private int restrauntEmployees = 0;

	boolean clockedIn=true;


	
	
//	public void startServing() {
//
//        try {
//        	
//			Restraunt.getRestraunt().counterAreaSemaphore.acquire();
//			
//			//returns customer at counter customeraAtCounter
//			customerAtCounter = Restraunt.getRestraunt().serveFirstCustomerInline(serverNumber);
//			Restraunt.getRestraunt().counterAreaSemaphore.release();
//
//			if(customerAtCounter.getCustOrderSize() > 3) {
//
//				//Make 3 burritos
//				customerAtCounter.makeThreeBurritos();
//				System.out.println("*************Before cooking*******");
//				Restraunt.getRestraunt().Cooking(3,serverNumber,customerAtCounter);
//				System.out.println("***After cooking ***********");
//	            System.out.println("Customer "+customerAtCounter.getCustId()+ " Still needs " +customerAtCounter.getCustOrderSize()+ " Burritos.");
//	               Restraunt.getRestraunt().orderCounterLine(customerAtCounter);  
//	               Restraunt.getRestraunt().servingCustomerSemaphore.release();
//				
//			}
//			else
//			{
//
//				Restraunt.getRestraunt().Cooking(customerAtCounter.getCustOrderSize(), serverNumber,customerAtCounter);
//				System.out.println("Customer " +customerAtCounter.getCustId() + " Order is completed they are being sent to register line to pay.");
//				Restraunt.getRestraunt().payAtRegister(customerAtCounter);
//				if(!Restraunt.getRestraunt().registerLineLL.isEmpty()&&Restraunt.getRestraunt().registerSemaphore.tryAcquire()) {
//					
//	               System.out.println("Server "+serverNumber+" is at register with customer " +customerAtCounter.getCustId());
//	               Restraunt.getRestraunt().payAtRegister(customerAtCounter);
//	               System.out.println("Customer " +customerAtCounter.getCustId() + " has paid their food and is leaving the restraunt.");
//
//				}
//		
//			}
//
//        } catch (InterruptedException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//        
//	}
	
	@Override
	public void run() {
		
//	boolean clockedIn=true;
	++restrauntEmployees;

		System.out.println("Server " + (serverNumber) + " Came into work and is clocked in.");
		
	 while(clockedIn) {

		try {
			

			//Probably need a semaphore here to release when  **NEW LINE IS MADE**
			Thread.sleep(5000);
			Restraunt.getRestraunt().serveFirstCustomerInline(Server.this);
			
			
			System.out.println("After serveFirstCustomerInline()");
			
			
			
			
			System.exit(0);

			
		
			
			
			
//			//serves a customer and waits if none are in line.
//			// tryacquire is aquire but with time contstaint.
//			if(Restraunt.getRestraunt().servingCustomerSemaphore.tryAcquire(5*3+1000, TimeUnit.MILLISECONDS))
//			{
//				
//			//	startServing();
//				
//
//			}
//			
//
//			else {
//
//				clockedIn=false;
//				System.out.println("No more work for Server " + (serverNumber ) + " to be done, they left work and are clocked out.");
//			
//				
//				
//				--restrauntEmployees;
//				System.out.println(restrauntEmployees + " Employees left in the restraunt.");
//					
//				}
//			if(restrauntEmployees==0) {
//				System.out.println("No more employees left in the restraunt the Store is closed" );
//				System.exit(0);
//
//		}
//			
//			
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
//	 }
	 }
	}
		
	
	
	
	public Server(Customer customerAtCounter, int serverNumber, boolean clockedIn) {
	super();
	this.customerAtCounter = customerAtCounter;
	this.serverNumber = serverNumber;
	this.clockedIn = clockedIn;
}




	public Server(int serverNumber){
		this.serverNumber = serverNumber;
		
	}

	public int getServerNumber() {
		return serverNumber;
	}

	public void setServerNumber(int serverNumber) {
		this.serverNumber = serverNumber;
	}



}
		


