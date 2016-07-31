package test.Member;

import sist.co.Member.MemberDTO;

public interface testiMemberDAO {
	boolean updateMember (String pw, String email, String id);
	boolean outMember (MemberDTO dto);  
}
