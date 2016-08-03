package sist.co.Theater;

import java.sql.Timestamp;
import java.util.Date;

public class TheaterDTO {

	private int th_seq;
	private String th_name;
	private int mv_seq;
	private String th_cinema;
	private int th_num;
	private int th_totalseat;
	private Timestamp th_time;
	private Date th_s_date;
	private Date th_e_date;
	
	public TheaterDTO() {
		
	}
	
	public Date getTh_s_date() {
		return th_s_date;
	}

	public void setTh_s_date(Date th_s_date) {
		this.th_s_date = th_s_date;
	}

	public Date getTh_e_date() {
		return th_e_date;
	}

	public void setTh_e_date(Date th_e_date) {
		this.th_e_date = th_e_date;
	}

	public int getTh_seq() {
		return th_seq;
	}

	public void setTh_seq(int th_seq) {
		this.th_seq = th_seq;
	}

	public String getTh_name() {
		return th_name;
	}

	public void setTh_name(String th_name) {
		this.th_name = th_name;
	}

	public int getMv_seq() {
		return mv_seq;
	}

	public void setMv_seq(int mv_seq) {
		this.mv_seq = mv_seq;
	}

	public String getTh_cinema() {
		return th_cinema;
	}

	public void setTh_cinema(String th_cinema) {
		this.th_cinema = th_cinema;
	}

	public int getTh_num() {
		return th_num;
	}

	public void setTh_num(int th_num) {
		this.th_num = th_num;
	}

	public int getTh_totalseat() {
		return th_totalseat;
	}

	public void setTh_totalseat(int th_totalseat) {
		this.th_totalseat = th_totalseat;
	}

	public Timestamp getTh_time() {
		return th_time;
	}

	public void setTh_time(Timestamp th_time) {
		this.th_time = th_time;
	}

	@Override
	public String toString() {
		return "TheaterDTO [th_seq=" + th_seq + ", th_name=" + th_name + ", mv_seq=" + mv_seq + ", th_cinema="
				+ th_cinema + ", th_num=" + th_num + ", th_totalseat=" + th_totalseat + ", th_time=" + th_time 
				+ ", th_s_date=" + th_s_date + ", th_e_date=" + th_e_date + "]";
	}

	

	
}
