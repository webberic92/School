package burritobrothers;

public class Server implements Runnable {

	
	private int serverNumber;



	Server(int serverNumber){
		this.serverNumber = serverNumber;
		
	}
	
	void startServing() {
		
        System.out.println(serverNumber + " Came into work today.");

	}
	
	@Override
	public void run() {
		System.out.println("Server " + (serverNumber + 1) + " Came into work.");

		
	}}
		
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


