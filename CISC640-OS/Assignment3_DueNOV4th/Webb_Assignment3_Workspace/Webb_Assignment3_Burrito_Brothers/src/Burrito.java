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
    
  
   public static void main(String args[]) throws Exception
   {      
       System.out.println("Welcome to Burrito Brothers restaurant");
       System.out.println("\nChoose simulator mode: ");
   
       String    adv="";      
      
     
               NoOfCustomers=5;
               NoOfServers=3;
               StorCapacity=3;
               ArrivalWindowMax=4000;
               CookingSpeed=1500;
               RegisterSpeed=1000;
              
           
         
       
  
       System.out.println("------------- Customers activity --------------------|-------------------- Servers activity --------------"+adv);
                  
       for (int i=0; i<NoOfServers; ++i)
       {
           Thread Server = new Thread(new Server(i));           
           Server.start();                  
       }
  
       for (int i=0; i<NoOfCustomers; ++i)
       {
           new Store();
		Thread Customers = new Thread(Store.getShop());
           Customers.start();  
          
          
           try {Thread.sleep((int)(1+ArrivalWindowMax*Math.random()));}
           catch (InterruptedException e) {e.printStackTrace();}
       }  
      
   }
  
  
}