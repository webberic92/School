package burritobrothers;

import java.util.concurrent.TimeUnit;

public class Server implements Runnable {

	private Customer customerAtCounter;
	private int serverNumber;
	static private int restrauntEmployees = 0;



	
	
	public void startServing() {

        try {
        	
			Restraunt.getRestraunt().counterAreaSemaphore.acquire();
			customerAtCounter = Restraunt.getRestraunt().FromLineToCounter(serverNumber);
			Restraunt.getRestraunt().counterAreaSemaphore.release();

			if(customerAtCounter.getCustOrderSize() > 3) {

				//Make 3 burritos
				customerAtCounter.makeThreeBurritos();
				Restraunt.getRestraunt().Cooking(3,serverNumber,customerAtCounter.getCustId());
	            System.out.println("Customer "+customerAtCounter.getCustId()+ " Still needs " +customerAtCounter.getCustOrderSize()+ " Burritos.");
	               Restraunt.getRestraunt().orderCounterLine(customerAtCounter);  
	               Restraunt.getRestraunt().servingCustomerSemaphore.release();
				
			}
			else
			{

				Restraunt.getRestraunt().Cooking(customerAtCounter.getCustOrderSize(), serverNumber,customerAtCounter.getCustId());
				System.out.println("Customer " +customerAtCounter.getCustId() + " Order is completed they are being sent to register line to pay.");
				Restraunt.getRestraunt().payAtRegister(customerAtCounter);
				if(!Restraunt.getRestraunt().registerLineLL.isEmpty()&&Restraunt.getRestraunt().registerSemaphore.tryAcquire()) {
					
	               System.out.println("Server "+serverNumber+" is at register with customer " +customerAtCounter.getCustId());
	               Restraunt.getRestraunt().payAtRegister(customerAtCounter);
	               System.out.println("Customer " +customerAtCounter.getCustId() + " has paid their food and is leaving the restraunt.");

				}
		
			}

        } catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
	}
	
	@Override
	public void run() {
		
	boolean clockedIn=true;
	++restrauntEmployees;

		System.out.println("Server " + (serverNumber + 1) + " Came into work and is clocked in.");
	 while(clockedIn) {


		try {

			//serves a customer and waits if none are in line.
			// tryacquire is aquire but with time contstaint.
			if(Restraunt.getRestraunt().servingCustomerSemaphore.tryAcquire(5*3+1000, TimeUnit.MILLISECONDS))
			{
				
				startServing();
				

			}
			

			else {

				clockedIn=false;
				System.out.println("No more work for Server " + (serverNumber + 1) + " to be done, they left work and are clocked out.");
			
				
				
				--restrauntEmployees;
				System.out.println(restrauntEmployees + " Employees left in the restraunt.");
					
				}
			if(restrauntEmployees==0) {
				System.out.println("No more employees left in the restraunt the Store is closed" );
				System.exit(0);

		}
			
			
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}}
	 }


		
	public Server(int serverNumber){
		this.serverNumber = serverNumber;
		
	}




}
		


