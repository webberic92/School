package burritobrothers;

public class Customer {

	private int custId;
	private int custOrderSize;

	Customer() {

		// You want to use int cast because double would show a decimal which does not
		// make sense. 
		//Suppose to be 25 make 25 before turning in.
		this.custOrderSize = (int) (1 + 10 * Math.random());

	}
	
	//Not setter for custOrderSize because you are setting it in the constructor.
	//You will be getting it later to see if your orderSize is 0 or less which means its complete.

	public int getCustId() {
		return custId;
	}

	public void setCustId(int custId) {
		this.custId = custId;
	}

	protected int getCustOrderSize() {
		return custOrderSize;
	}
	 public void makeThreeBurritos() {
		 this.custOrderSize = this.custOrderSize -3;
	 }
	
}
