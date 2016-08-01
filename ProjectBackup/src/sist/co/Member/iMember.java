package sist.co.Member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public interface iMember {
	int AddMember(MemberDTO dto);
	boolean IdDuple(String id);
	boolean EmailDuple(String email);
	int login(String m_id, String m_pw);
	MemberDTO selectMemberDTO(String m_id);
}
