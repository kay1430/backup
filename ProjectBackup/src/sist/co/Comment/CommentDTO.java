package sist.co.Comment;

import java.sql.Timestamp;

public class CommentDTO {
	private int com_seq;
	private int r_seq;
	private String m_id;
	private String com_content;
	private Timestamp com_writedate;
	
	public CommentDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getCom_seq() {
		return com_seq;
	}

	public void setCom_seq(int com_seq) {
		this.com_seq = com_seq;
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

	public String getCom_content() {
		return com_content;
	}

	public void setCom_content(String com_content) {
		this.com_content = com_content;
	}

	public Timestamp getCom_writedate() {
		return com_writedate;
	}

	public void setCom_writedate(Timestamp com_writedate) {
		this.com_writedate = com_writedate;
	}

	@Override
	public String toString() {
		return "CommentDTO [com_seq=" + com_seq + ", r_seq=" + r_seq + ", m_id=" + m_id + ", com_content=" + com_content
				+ ", com_writedate=" + com_writedate + "]";
	}
	
	
}
