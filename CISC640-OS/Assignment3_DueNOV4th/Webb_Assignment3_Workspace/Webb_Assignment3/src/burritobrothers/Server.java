package burritobrothers;

import java.util.concurrent.TimeUnit;

public class Server implements Runnable {

	private Customer customerAtCounter;
	private int serverNumber;
	static private int restrauntEmployees = RunABuisness.Employees;



	
	
	public void startServing() {

        try {
        	
			Restraunt.getRestraunt().counterAreaSemaphore.acquire();
			System.out.println("Alpha1 this is where error starts");
			
			System.out.println(serverNumber);

			customerAtCounter = Restraunt.getRestraunt().FromLineToCounter(serverNumber);
			
			
			System.out.println("Alpha2");

			Restraunt.getRestraunt().counterAreaSemaphore.release();
			System.out.println("Alpha3");

			if(customerAtCounter.getCustOrderSize() > 3) {
				System.out.println("Gamma");

				//Make 3 burritos
				customerAtCounter.makeThreeBurritos();
				Restraunt.getRestraunt().Cooking(3,serverNumber);
	            System.out.println("Customer "+customerAtCounter.getCustId()+ " Still needs " +customerAtCounter.getCustOrderSize()+ " Burritos.");
	               Restraunt.getRestraunt().LookAtlineArray(customerAtCounter,false);  
	               Restraunt.getRestraunt().servingCustomerSemaphore.release();
				
			}
			else
			{
				System.out.println("beta");

				Restraunt.getRestraunt().Cooking(customerAtCounter.getCustOrderSize(), serverNumber);
				Restraunt.getRestraunt().payAtRegister(customerAtCounter);
				if(!Restraunt.getRestraunt().registerLineLL.isEmpty()&&Restraunt.getRestraunt().registerSemaphore.tryAcquire()) {
					
	               System.out.println("Server "+serverNumber+" is at register");
	               Restraunt.getRestraunt().payAtRegister(customerAtCounter);

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
		System.out.println("Server " + (serverNumber + 1) + " Came into work and is clocked in.");
	 while(clockedIn) {


		try {

			//serves a customer and waits if none are in line.
			// tryacquire is aquire but with time contstaint.
			if(Restraunt.getRestraunt().servingCustomerSemaphore.tryAcquire(5*3+100, TimeUnit.MILLISECONDS))
			{
				
				//reaching here but not returning
				System.out.println("TEST4 hits startServing method but breaks");
				startServing();
				
				System.out.println("TEST5");

			}
			

			else {
				System.out.println("TEST6");

				clockedIn=false;
				System.out.println("Server " + (serverNumber + 1) + " left work and is clocked out.");
				--restrauntEmployees;
				if(restrauntEmployees==0) {
					System.out.println("Store is closed" );
					System.exit(0);
					
				}

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
		


