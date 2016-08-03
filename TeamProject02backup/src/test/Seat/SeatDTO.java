package test.Seat;

public class SeatDTO {

	private int s_seq;
	private int th_seq;
	private String s_name;
	private int s_check;
	
	public SeatDTO() {
	}

	public int getS_seq() {
		return s_seq;
	}

	public void setS_seq(int s_seq) {
		this.s_seq = s_seq;
	}

	public int getTh_seq() {
		return th_seq;
	}

	public void setTh_seq(int th_seq) {
		this.th_seq = th_seq;
	}

	public String getS_name() {
		return s_name;
	}

	public void setS_name(String s_name) {
		this.s_name = s_name;
	}

	public int getS_check() {
		return s_check;
	}

	public void setS_check(int s_check) {
		this.s_check = s_check;
	}

	@Override
	public String toString() {
		return "SeatDTO [s_seq=" + s_seq + ", th_seq=" + th_seq + ", s_name=" + s_name + ", s_check=" + s_check + "]";
	}

}
