package burritobrothers;

import java.util.concurrent.TimeUnit;

public class Server implements Runnable {

	private Customer customerAtCounter;
	private int serverNumber;
	static private int restrauntEmployees = RunABuisness.Employees;



	
	
	void startServing() {
		
        System.out.println(serverNumber + " Came into work today.");
        	
        try {
        	
			Restraunt.getRestraunt().counterAreaSemaphore.acquire();
		
			customerAtCounter = Restraunt.getRestraunt().FromLineToCounter(serverNumber);
			
			Restraunt.getRestraunt().counterAreaSemaphore.release();

        } catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
	}
	
	@Override
	public void run() {
		
	boolean clockedIn=true;
		System.out.println("Server " + (serverNumber + 1) + " Came into work and is clocked in.");
	 while(clockedIn==true) {
		 

		try {
			
			//serves a customer and waits if none are in line.
			// tryacquire is aquire but with time contstaint.
			if(Restraunt.getRestraunt().servingCustomerSemaphore.tryAcquire(5*3+1000, TimeUnit.MILLISECONDS))
			{
				CheckRegister();
			}
			else {
				
				clockedIn=false;
				System.out.println("Server " + (serverNumber + 1) + " left work and is clocked out.");
				--restrauntEmployees;
				if(serverNumber==0) {
					System.out.println("Store is closed" );
					System.exit(0);
					
				}

						}
			
			
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}}
	 }

	private void CheckRegister() {
		// TODO Auto-generated method stub
		
	}
		
	Server(int serverNumber){
		this.serverNumber = serverNumber;
		
	}




}
		
//		boolean ServerWorkingTheirShift = true;
//		
//		while(ServerWorkingTheirShift){
//			//store getshop semaphorestartserving tryaquire 
//			//freeServer
//			System.out.println("Server " + serverNumber+1) + " Came into work.");
//
//			if(serverNumber==3) {
//				ServerWorkingTheirShift=false;
//			}
//		}
//		// TODO Auto-generated method stub
//
//	}


