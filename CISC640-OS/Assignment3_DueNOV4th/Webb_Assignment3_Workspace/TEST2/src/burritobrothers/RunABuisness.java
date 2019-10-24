package burritobrothers;

import java.util.InputMismatchException;
import java.util.Scanner;
import java.util.concurrent.Semaphore;

public class RunABuisness {

	protected static Semaphore serverClocksInSemaphore = new Semaphore(1);
	protected static Semaphore customersLoadedSemphore = new Semaphore(1);
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
		
		// creates 15 customers
		// Suppose to be 15 customers.change before turning in.
		for (int i = 1; i < input; ++i) {
			new Restraunt();
			Thread Customer = new Thread(Restraunt.getRestraunt());
			Customer.start();

		}
		
	}


	public static void getCustomerNumberInput() {
		
		try {
			
		
		 // 1. Create a Scanner using the InputStream available.
	    Scanner scanner = new Scanner( System.in );

	    // 2. Don't forget to prompt the user
		System.out.println("Please enter how many customers are coming in this day...");

	    // 3. Use the Scanner to read a line of text from the user.
	     input = scanner.nextInt();

	     if (input < 1) {
	 	    // 4. Now, you can do anything with the input string that you need to.
	 	    // Like, output it to the user.
	 	    System.out.println( "has to be greater then 1 " + input );
	 	    getCustomerNumberInput();
	 	     }
	     
	     
	     if (input > 100) {
	    // 4. Now, you can do anything with the input string that you need to.
	    // Like, output it to the user.
	    System.out.println( "You chose TO MANY customers..." + input );
	    getCustomerNumberInput();
	     }
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

