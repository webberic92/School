import java.util.LinkedList;

import java.util.concurrent.Semaphore;

public class Store implements Runnable
{
   private static Store Str = new Store();
   private int CustInShop=0;
   protected int CustInLine=0;
   protected int custID=0;
   protected Customer line[]=new Customer[Burrito.StorCapacity];
   protected LinkedList<Customer> RegisterLine = new LinkedList<Customer>();  
  
   protected Semaphore semCustInStore = new Semaphore(1);
   protected Semaphore semStartServing = new Semaphore(0);
   protected Semaphore semRegister = new Semaphore(1);
   protected Semaphore semRegisterLine = new Semaphore(1);
   protected Semaphore semCounter = new Semaphore(1);
   protected Semaphore semLine = new Semaphore(1);
   protected Semaphore semIngredients = new Semaphore(1);
  
   String space =String.format("%" + 55 + "s", " ");
  
   public static Store getShop()
   {
       return Str;
   }
  
  
      
   public void Welcome()
   {      
       try
       {
           semCustInStore.acquire();   // only one customer can enter store at a time.
           ++custID;
          
           if(CustInShop<Burrito.StorCapacity)
           {                  
               ++CustInShop;              
               Customer Cust = new Customer();
               Cust.setCustID(custID);
               System.out.println("Welcome! Cust #"+Cust.getCustID()+" with order of "+Cust.getOrderSize()+" Burritos In");
               CheckLine(Cust,true);                  
                                      
               semStartServing.release(); // letting server now that there is customer in the store.
               semCustInStore.release(); // now other customer can enter the store
           }
           else
           {
               System.out.println("Too many people inside Cust # "+custID+" hsa left the stor");
               semCustInStore.release(); // now other customer can enter the store
           }
       }
       catch (InterruptedException e1) {e1.printStackTrace();}
   }
  
   public void CheckLine(Customer Cust, boolean newCust)
   {
       try               
       {
           semLine.acquire();       
              
               if (CustInLine==0) EnterLine(1,0,Cust);  
               else
               {
                   if (CustInLine==1&&!newCust) line[1]=Cust;
                   else                              
                   {
                       if (CustInLine==1&&newCust)
                       {
                           if (Cust.getOrderSize()>line[0].getOrderSize()) line[1]=Cust;
                           else
                           {
                               line[1]=line[0];
                               line[0]=Cust;
                           }
                       }
                       else
                       {  
                           for (int i=0; i<CustInLine-1; ++i)
                           {
                               if (line[i].getOrderSize()>line[i+1].getOrderSize())
                               {                                  
                                   EnterLine(CustInLine+1,i+1,Cust);
                                   break;
                               }
                               if (i==CustInLine-2) line[i+2]=Cust;
                           }
                       }
                   }
                  
               }              
               ++CustInLine;              
           semLine.release();
       }      
       catch (InterruptedException e1) {e1.printStackTrace();}      
   }
          
   public void EnterLine(int CustInLine, int Sortuntill, Customer Cust)
   {
       if (CustInLine==1) line[0]=Cust;
       else
       {
           for (int i=CustInLine-1; i>Sortuntill; --i)
           {
               if(Cust.getOrderSize()<line[i-1].getOrderSize())
               {
                   line[i]=line[i-1]; //moving elements
                   if (i==Sortuntill+1)
                   {
                       line[i-1]=Cust;
                       break;
                   }
                      
               }
               else
               {
                   line[i]=Cust;
                   break;
               }
           }
       }
   System.out.println("Customer #"+Cust.getCustID()+" with order of "+Cust.getOrderSize()+" burritos waiting in line");  
   }
  
   public Customer Counter(int serverID)
   {
  
       Customer atCounter;
       String Line="";
      
//       if (Burrito.advmode)
//       {
//           for (int i=0; i<Store.getShop().CustInLine; ++i)
//               Line=Line+"C"+Store.getShop().line[i].getCustID()+"("+Store.getShop().line[i].getOrderSize()+")-";              
//           System.out.println(space+space+"Customers in line:");
//           System.out.println(space+space+Line);
//       }
//      
       atCounter=line[0];                       //serving first customer in the line
              
       System.out.println(space+"Server #"+serverID+" serving Customer #"+atCounter.getCustID());                                      
       /*test*///Prnt.getPrnt().ServerIsFree(serverID,atCounter);
       for (int i=0; i<CustInLine; ++i)        //moving the line
           line[i]=line[i+1];
       --CustInLine;                           //customer is on counter, not in line anymore       
      
       line[CustInLine]=null;
      
      
       return atCounter;
   }
  
   public void Cooking(int burritos, int ServerID)
   {
      
       try
       {
           semIngredients.acquire();
           System.out.println(space+"Server #"+ServerID+" has obtained all ingredients");    
           semIngredients.release();
           System.out.println(space+"Cooking...");
           try {Thread.sleep(burritos*Burrito.CookingSpeed);} //simulating servers work
           catch (InterruptedException e) {e.printStackTrace();}
              
       }
       catch (InterruptedException e1) {e1.printStackTrace();}
   }
      
   public void GoToPay(Customer atCounter)
   {
       LinkedList<Customer> RegisterPrnt = new LinkedList<Customer>();
       String AtRegister="";
       try
       {
       semRegisterLine.acquire();
           RegisterLine.addLast(atCounter); //adding customer into register queue
                      
           if (Burrito.advmode)
           {
               RegisterPrnt=RegisterLine;
               for (int i=0; i<RegisterPrnt.size(); ++i)
                   AtRegister=AtRegister+"C"+RegisterPrnt.get(i).getCustID()+"<=";
               System.out.println(space+space+"Customers on register:");
               System.out.println(space+space+AtRegister);
           }
          
          
       semRegisterLine.release();
      
       }
       catch (InterruptedException e1) {e1.printStackTrace();}
   }
  
   public void Register()
   {
       Customer cust;  
       while (!RegisterLine.isEmpty())
       {              
           cust=RegisterLine.pollFirst();
           System.out.println("Customer #"+cust.getCustID()+" is paying...");
           try {Thread.sleep((int)(1+Burrito.RegisterSpeed*Math.random()));} //simulating paying
           catch (InterruptedException e) {e.printStackTrace();}
                          
          
           System.out.println("Good bye! Customer #"+cust.getCustID() +" is leaving the store");
           --CustInShop;   //customer exits the shop
       }  
       semRegister.release();
   }  
   public void run()
   {
       Welcome();  
   }

}