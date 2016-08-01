package sist.co.Review;

import java.sql.Timestamp;

public class ReviewDTO {
  
	private int r_seq;
	private String m_id;
	private String r_title;
	private String r_content;
	private Timestamp r_writedate;
	private int r_like;
	private int r_readcount;
	private int mv_seq;
	private int r_star;
	
	public ReviewDTO(){
		
		
	}

	public int getR_seq() {
		return r_seq;
	}

	public void setR_seq(int r_seq) {
		this.r_seq = r_seq;
	}

	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}

	public String getR_title() {
		return r_title;
	}

	public void setR_title(String r_title) {
		this.r_title = r_title;
	}

	public String getR_content() {
		return r_content;
	}

	public void setR_content(String r_content) {
		this.r_content = r_content;
	}

	public Timestamp getR_writedate() {
		return r_writedate;
	}

	public void setR_writedate(Timestamp r_writedate) {
		this.r_writedate = r_writedate;
	}

	public int getR_like() {
		return r_like;
	}

	public void setR_like(int r_like) {
		this.r_like = r_like;
	}

	public int getR_readcount() {
		return r_readcount;
	}

	public void setR_readcount(int r_readcount) {
		this.r_readcount = r_readcount;
	}

	public int getMv_seq() {
		return mv_seq;
	}

	public void setMv_seq(int mv_seq) {
		this.mv_seq = mv_seq;
	}

	public int getR_star() {
		return r_star;
	}

	public void setR_star(int r_star) {
		this.r_star = r_star;
	}

	@Override
	public String toString() {
		return "ReviewDTO [r_seq=" + r_seq + ", m_id=" + m_id + ", r_title=" + r_title + ", r_content=" + r_content
				+ ", r_writedate=" + r_writedate + ", r_like=" + r_like + ", r_readcount=" + r_readcount + ", mv_seq="
				+ mv_seq + ", r_star=" + r_star + "]";
	}

	

	
	
}
