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
	
	MemberDTO dto = new MemberDTO();
	public static MemberDAO getInstance(){
		if(memberDAO==null){
			memberDAO = new MemberDAO();
		}
		return memberDAO;
	}
	
	@Override
	public boolean AddMember(MemberDTO dto) {
		String sql = " INSERT INTO MEMBER "
					+ " (M_ID, M_PW, M_NAME, M_EMAIL, M_AUTH) "
					+ " VALUES(?,?,?,?, 3) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int count = 0;
		
		try{
			conn = DBManager.getConnection();
			log("2/5 Success addMember");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getM_id());
			psmt.setString(2, dto.getM_pw());
			psmt.setString(3, dto.getM_name());
			psmt.setString(4, dto.getM_email());
			
			System.out.println("dto:" + dto.toString());
			log("3/5 Success addMember");
			
			count = psmt.executeUpdate();
			log("4/5 Success addMember");
		}
		catch(SQLException e){
			log("Fail addMember", e);
		}
		finally{
			DBManager.close(conn, psmt, rs);
			log("5/5 Success addMember");
		}
		return count>0?true:false;
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
	public MemberDTO login(MemberDTO dto) {
		String sql = " SELECT M_ID, M_NAME, M_EMAIL, M_AUTH FROM MEMBER "
					+ " WHERE M_ID=? AND M_PW=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		MemberDTO mem = null;
		try{
			conn = DBManager.getConnection();
			log("2/6 Success login");
			psmt=conn.prepareStatement(sql);
			psmt.setString(1, dto.getM_id());
			psmt.setString(2, dto.getM_pw());
			log("3/6 Success login");
			
			rs = psmt.executeQuery();
			log("4/6 Success login");
			
			while(rs.next()){
				String id = rs.getString(1);
				String name = rs.getString(2);
				String email = rs.getString(3);
				int auth = rs.getInt(4);
				mem = new MemberDTO();
				mem.setM_id(id);
				mem.setM_pw(null);
				mem.setM_name(name);
				mem.setM_email(email);
				mem.setM_auth(auth);
				
				mem.toString();
			}
			log("5/6 Success login");
		}
		catch(SQLException e){
			log("Fail login",e);
		}
		finally{
			DBManager.close(conn, psmt, rs);
			log("6/6 Success login");
		}
		return mem;
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
