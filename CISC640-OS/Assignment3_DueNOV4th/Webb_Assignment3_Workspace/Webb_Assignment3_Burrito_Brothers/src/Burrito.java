import java.util.Scanner;

public class Burrito
{
   protected static int NoOfCustomers=0;
   protected static int NoOfServers=0;
   protected static int StorCapacity=0;
   protected static int ArrivalWindowMax=0;
   protected static int CookingSpeed=0;
   protected static int RegisterSpeed;
   protected static boolean advmode;
  

   static Scanner conIn = new Scanner(System.in);
  
  
   public static void main(String args[]) throws Exception
   {      
       System.out.println("Welcome to Burrito Brothers restaurant");
       System.out.println("\nChoose simulator mode: ");
       System.out.println("1: User Mode ");
       System.out.println("2: Test Mode (Advanced) ");
       String    adv="";      
      
       switch (input())
       {
            case 1: // User Mode
               advmode=false;
               NoOfCustomers=30;
               NoOfServers=3;
               StorCapacity=15;
               ArrivalWindowMax=4000;
               CookingSpeed=1500;
               RegisterSpeed=1000;
              
            break;
      
            case 2: // Test Mode
               advmode=true;
              
               System.out.println("How many CUSTOMERS you want to generate?");
               NoOfCustomers=input();
              
               System.out.println("How many SERVERS you want to generate?");
               NoOfServers=input();
              
               System.out.println("Setup store capacity more then 1");              
               while (StorCapacity<2)
               {
                   StorCapacity=input();
                   if (StorCapacity<2) System.out.println("store capacity must be more then 1");  
               }
              
               System.out.println("Setup customer generator frequency's upper limit (in MILLISECONDS) ");
               ArrivalWindowMax=input();              
              
               System.out.println("Setup Cooking time (in MILLISECONDS) for one burrito");
               CookingSpeed=input();
              
               System.out.println("Setup Register speed (in MILLISECONDS)");
               RegisterSpeed=input();
              
               adv="|---------- Waiting line and Register line -------------";
            break;          

                   
            default:
               System.out.println("Error in mode choice. Terminating test.");
               return;
         
       }
  
       System.out.println("------------- Customers activity --------------------|-------------------- Servers activity --------------"+adv);
                  
       for (int i=0; i<NoOfServers; ++i)
       {
           Thread Server = new Thread(new Server(i));           
           Server.start();                  
       }
  
       for (int i=0; i<NoOfCustomers; ++i)
       {
           Thread Customers = new Thread(new Store().getShop());
           Customers.start();  
          
          
           try {Thread.sleep((int)(1+ArrivalWindowMax*Math.random()));}
           catch (InterruptedException e) {e.printStackTrace();}
       }  
      
   }
  
  
   static int input()
   {
       int input=0;
       String skip;       // skip end of line after reading an integer
       boolean flag=true; // flag for "Input" loop
      
       while (flag)          
       {
            if (conIn.hasNextInt())
            {
               input = conIn.nextInt();
               flag=false;
            }
            else
            {
                 System.out.println("Error: you must enter an integer.");
                 System.out.println("Try again");
                  // return;
            }
             skip = conIn.nextLine();
       }
      
      
       return input;      
   }
}