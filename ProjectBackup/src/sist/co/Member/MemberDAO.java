package sist.co.Member;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import sist.co.DBManager.DBManager;

import java.sql.Connection;

public class MemberDAO implements iMember {
	
	private boolean isS = true;
	private static MemberDAO memberDAO;
	
	
	public static MemberDAO getInstance(){
		if(memberDAO==null){
			memberDAO = new MemberDAO();
		}
		return memberDAO;
	}
	
	@Override
	public int AddMember(MemberDTO dto) {
		String sql = " INSERT INTO MEMBER "
					+ " (M_ID, M_PW, M_NAME, M_EMAIL, M_AUTH,m_photo) "
					+ " VALUES(?,?,?,?, 3,?) ";
		
		int result=-1;
		String m_photo = " ";
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		try{
			conn = DBManager.getConnection();
			log("2/5 Success addMember");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getM_id());
			psmt.setString(2, dto.getM_pw());
			psmt.setString(3, dto.getM_name());
			psmt.setString(4, dto.getM_email());
			
			if(dto.getM_photo() != null){
				m_photo=dto.getM_photo();
			}
			
			psmt.setString(5, m_photo);
			result = psmt.executeUpdate();
		}
		catch(SQLException e){
			System.out.println(e.getMessage());
		}
		finally{
			DBManager.close(conn, psmt, rs);
		}
		return result;
	}
	
	@Override
	public boolean IdDuple(String id) {
		String sql = " SELECT M_NAME FROM MEMBER "
					+ " WHERE M_ID=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		String name = null;
		boolean ck = false;
		
		try{
			conn = DBManager.getConnection();
			log("2/6 Success IdDuple");
		
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			log("3/6 Success IdDuple");
			
			rs = psmt.executeQuery();
			log("4/6 Success IdDuple");
			
			while(rs.next()){
				name = rs.getString("m_name");
			}
			System.out.println("id 있음? ="+name);
			log("5/6 Success IdDuple");
			if(name==null){
				ck = true;
			}
			else{
				ck = false;
			}
		}
		catch(SQLException e){
			log("Fail IdDuple", e);
		}
		finally{
			DBManager.close(conn, psmt, rs);
			log("6/6 Success IdDuple");
		}
		
		return ck;
	}
	
	@Override
	public boolean EmailDuple(String email) {
		String sql = " SELECT M_NAME FROM MEMBER "
					+ " WHERE M_EMIL =? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		String name = null;
		boolean ck = false;
		
		try{
			conn = DBManager.getConnection();
			log("2/6 Success EmailDuple");
		
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, email);
			log("3/6 Success EmailDuple");
			
			rs = psmt.executeQuery();
			log("4/6 Success EmailDuple");
			
			while(rs.next()){
				name = rs.getString(1);
			}
			log("5/6 Success EmailDuple");
			if(name==null){
				ck = false;
			}
			else{
				ck = true;
			}
		}
		catch(SQLException e){
			log("Fail EmailDuple", e);
		}
		finally{
			DBManager.close(conn, psmt, rs);
			log("6/6 Success EmailDuple");
		}
		return ck;
	}

	@Override
	public int login(String m_id, String m_pw) {
		String sql = "select m_pw from Member where m_id=?";
		
		int result = -1;
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		MemberDTO mem = null;
		try{
			conn = DBManager.getConnection();
			psmt=conn.prepareStatement(sql);
			psmt.setString(1, m_id);

			rs = psmt.executeQuery();
			
			while(rs.next()){
				if(rs.getString("m_pw").equals(m_pw)){
					//나중에 admin 계정 아이디 비밀번호 필요할시 여기서 조건문
					
					//입력받은 m_id 와 m_pw 가 모두 일치
					//1을 리턴함  -->무엇이 잘못됐는지 확인가능
					result = 1;	
				}else{
					//아이디는 일치하나 비밀번호가 틀렸을 경우
					result = 0;
				}
			}
			//이 모든 조건이 실행 안되면 -1 을 리턴
		}
		catch(SQLException e){
			System.out.println(e.getMessage());
		}
		finally{
			DBManager.close(conn, psmt, rs);
			log("6/6 Success login");
		}
		return result;
	}

	//이 메서드는 로그인이 확인되면 member 테이블 정보를 모아온다.
	
	@Override
	public MemberDTO selectMemberDTO(String m_id) {
		MemberDTO memberdto = null;
		
		String sql = "select * from member where m_id = ?";
		
		Connection conn= null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		try {
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, m_id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				memberdto = new MemberDTO();
				int i =1;
				memberdto.setM_id(rs.getString(i++));
				memberdto.setM_pw(rs.getString(i++));
				memberdto.setM_name(rs.getString(i++));
				memberdto.setM_email(rs.getString(i++));
				memberdto.setM_auth(rs.getInt(i++));
				memberdto.setM_photo(rs.getString(i++));
				
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally{
			DBManager.close(conn, pstmt, rs);
			
		}
		
		
		return memberdto;
	}
	
	
	
	
	
	public void log(String msg){
		if(isS){
			System.out.println(getClass() + ": "+ msg);
		
		}
	}
	public void log(String msg, Exception e){
		if(isS){
			System.out.println(e + ": " + getClass() + ": "+ msg);
		
		}
	}

}
