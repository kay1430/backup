package sist.co.Member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public interface iMember {
	boolean AddMember(MemberDTO dto);
	boolean IdDuple(String id);
	boolean EmailDuple(String email);
	MemberDTO login(MemberDTO dto);
}
