


//Classic POJO for customer, constructor automatically creates order size when initiated.
public class Customer {

	private int custId;
	private int custOrderSize;

	Customer() {
		// Creates order size of 1-25.
		this.custOrderSize = (int) (1 + 25 * Math.random());

	}
	
	
	public int getCustId() {
		return custId;
	}

	public void setCustId(int custId) {
		this.custId = custId;
	}

	protected int getCustOrderSize() {
		if(custOrderSize<=0) {
			custOrderSize=0;
		}
		return custOrderSize;
	}
	 public void makeThreeBurritos() {
		 this.custOrderSize = this.custOrderSize -3;
	 }
	
}
