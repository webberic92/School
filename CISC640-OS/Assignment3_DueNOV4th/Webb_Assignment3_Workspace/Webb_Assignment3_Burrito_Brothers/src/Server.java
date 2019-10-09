import java.util.concurrent.TimeUnit;

public class Server implements Runnable
{
   private int serverID;
   private Customer atCounter;
   static private int ServersInStor=Burrito.NoOfServers;
  
   public Server(int serverID)
   {
       this.serverID=serverID;
   }  
  
  
   public void FreeServer()
   {
       try
       {
           //Shop.getShop().semStartServing.acquire();
      
           Store.getShop().semCounter.acquire();
               atCounter=Store.getShop().Counter(serverID);
           Store.getShop().semCounter.release();
          
           if (atCounter.getOrderSize()>3)
           {
               atCounter.redOrderSize();   // redusing ordersize by 3 buritos           
               Store.getShop().Cooking(3,serverID);  
               System.out.println("Customer #"+atCounter.getCustID() +" should reenter the line");
               Store.getShop().CheckLine(atCounter,false);  
               Store.getShop().semStartServing.release();
           }                                                                              
           else
           {
               Store.getShop().Cooking(atCounter.getOrderSize(),serverID);
               Store.getShop().GoToPay(atCounter);      
               if (!Store.getShop().RegisterLine.isEmpty()&&Store.getShop().semRegister.tryAcquire())
               {
                   System.out.println(Store.getShop().space+"Server # "+serverID+" is on register");
                   Store.getShop().Register();
                   System.out.println(Store.getShop().space+"Server # "+serverID+" has left register");
               }              
           }
       }
       catch (InterruptedException e1) {e1.printStackTrace();}
  
   }
  
   public void run()
   {
      
       boolean working=true;  
       while (working)
       {
           try
           {
               // try to serve customer if no customer in line wait
               if (Store.getShop().semStartServing.tryAcquire(Burrito.ArrivalWindowMax*Burrito.NoOfServers+100,TimeUnit.MILLISECONDS))
               {
                   FreeServer();
               }
               else
               {
                   working=false; // closing store
                   System.out.println("Server #"+serverID+" finish his job" );
                   --ServersInStor;
                   if (ServersInStor==0)System.out.println("Store is closed" );
               }
           }
           catch (InterruptedException e) {e.printStackTrace();   }
                      
       }      
      
   }
  
}