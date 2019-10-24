package burritobrothers;

import java.util.InputMismatchException;
import java.util.Scanner;
import java.util.concurrent.Semaphore;

public class RunABuisness {

	protected static Semaphore serverClocksInSemaphore = new Semaphore(1);
	protected static Integer input;


	public static void main(String[] args) throws Exception {

		
		System.out.println(Thread.currentThread() + " Store is now open!");
		System.out.println(Thread.currentThread() + " Creating 3 Server Threads.");

//		 Creates 3 servers.
		for (int i = 1; i <4; ++i) {

			Thread Server = new Thread(new Server(i));
			serverClocksInSemaphore.acquire();
			
			Server.start();

		}

		
		
	   getCustomerNumberInput();
		
		for (int i = 1; i < input +1 ; ++i) {
			
			new Restraunt();
			Thread Customer = new Thread(Restraunt.getRestraunt());
			Customer.start();

		}
		
		}
	

		
	


	
	
	
	
	
	
	
	
	
	
	
	public static void getCustomerNumberInput() {
		
		try {
			
		
		 // 1. Create a Scanner using the InputStream available.
	    Scanner scanner = new Scanner( System.in );
		System.out.println("Please enter how many customers are coming in this day...");
	     input = scanner.nextInt();

	     if (input < 1) {
	 	    System.out.println( "has to be greater then 1 " + input );
	 	    getCustomerNumberInput();
	 	     }
	     
	     
	     if (input > 500) {
	    // 4. Now, you can do anything with the input string that you need to.
	    // Like, output it to the user.
	    System.out.println( "You chose TO MANY customers..." + input );
	    getCustomerNumberInput();
	     }
	     
	     //to prevent stack overflow
	     if (input <= 100) {
	 	    // 4. Now, you can do anything with the input string that you need to.
	 	    // Like, output it to the user.
	 	    System.out.println( "You chose this many customers..." + input );
	 	     }
	   
	     
	   
				
	}catch ( InputMismatchException ime ){
 	    System.out.println( "Wrong input please try again, has to be less than 100..." );
	    getCustomerNumberInput();

		
	}
		
	}
	}

