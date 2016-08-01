package sist.co.Member;

public class MemberDTO {
	
	private String m_id;
	private String m_pw;
	private String m_name;
	private String m_email;
	private int m_auth;
	private String m_photo;
	
	public MemberDTO() {}
	
	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}

	public String getM_pw() {
		return m_pw;
	}

	public void setM_pw(String m_pw) {
		this.m_pw = m_pw;
	}

	public String getM_name() {
		return m_name;
	}

	public void setM_name(String m_name) {
		this.m_name = m_name;
	}

	public String getM_email() {
		return m_email;
	}

	public void setM_email(String m_email) {
		this.m_email = m_email;
	}

	public int getM_auth() {
		return m_auth;
	}

	public void setM_auth(int m_auth) {
		this.m_auth = m_auth;
	}

	public String getM_photo() {
		return m_photo;
	}

	public void setM_photo(String m_photo) {
		this.m_photo = m_photo;
	}

	@Override
	public String toString() {
		return "MemberDTO [m_id=" + m_id + ", m_pw=" + m_pw + ", m_name=" + m_name + ", m_email=" + m_email
				+ ", m_auth=" + m_auth + ", m_photo=" + m_photo + "]";
	}
	
	
	
}

