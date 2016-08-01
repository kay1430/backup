package test.Price;

public class PriceDTO {
	
	private int p_seq;
	private String p_grade;
	private int p_price;
	
	public PriceDTO() {
	}

	public int getP_seq() {
		return p_seq;
	}

	public void setP_seq(int p_seq) {
		this.p_seq = p_seq;
	}

	public String getP_grade() {
		return p_grade;
	}

	public void setP_grade(String p_grade) {
		this.p_grade = p_grade;
	}

	public int getP_price() {
		return p_price;
	}

	public void setP_price(int p_price) {
		this.p_price = p_price;
	}

	@Override
	public String toString() {
		return "PriceDTO [p_seq=" + p_seq + ", p_grade=" + p_grade + ", p_price=" + p_price + "]";
	}

}
