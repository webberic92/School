package burritobrothers;

public class Customer {
	private int custID;
	private int orderSize;

	public Customer() {
		this.orderSize = (int) (1 + 20 * Math.random());
	}

	protected int getOrderSize() {
		return orderSize;
	}

	protected void redOrderSize() {
		this.orderSize = this.orderSize - 3;
	}

	public int getCustID() {
		return custID;
	}

	public void setCustID(int custID) {
		this.custID = custID;
	}

}