package sist.movie;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import sist.co.DBManager.DBManager;

public class ReservationDAO implements IReservation{

	private boolean isS = true;
	private static ReservationDAO ReservationDao;
	
	public ReservationDAO() {
	
	}
	
	public void log(String msg){
		if(isS){
			System.out.println(getClass() + ":" + msg);					// getClass() == this.getClass()
		}
	}
	
	public void log(String msg, Exception e){							// Exception 까지 출력되도록 
		if(isS){
			System.out.println(e + ":" + getClass() + ":" + msg);		// getClass() == this.getClass()
		}
	}

	
	public static ReservationDAO getInstance(){						// Singleton에 해당
		if(ReservationDao == null){
			ReservationDao = new ReservationDAO();
		}
		return ReservationDao;
	}
	
	@Override
	public boolean judgereserve(int seq, String id) {
		
		String sql = " SELECT * FROM RESERVATION WHERE MV_SEQ=? AND M_ID=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
				
		boolean isS = false;
		
		try{
			conn = DBManager.getConnection();
			log("2/6 Success judgereserve");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			psmt.setString(2, id);
			log("3/6 Success judgereserve");
			
			rs = psmt.executeQuery();
			log("4/6 Success judgereserve");
			while(rs.next()){
				isS = true;		// 해당하는 데이터가 있으면 true
			}
			System.out.println("isS:" + isS);
			
		}catch(SQLException e){
			log("Fail judgereserve");
		}finally{
			DBManager.close(conn, psmt, rs);
			log("6/6 Success judgereserve");
		}

		return isS;
	}

	@Override
	public int judgepoll(int seq, String id) {
	
		String sql = " SELECT R_POLL FROM RESERVATION WHERE MV_SEQ=? AND M_ID=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
				
		int r_poll = 0;
		
		try{
			conn = DBManager.getConnection();
			log("2/6 Success judgereserve");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			psmt.setString(2, id);
			log("3/6 Success judgereserve");
			
			rs = psmt.executeQuery();
			log("4/6 Success judgereserve");
			while(rs.next()){
				r_poll = rs.getInt(1);
			}
			System.out.println("r_poll:" + r_poll);
			
		}catch(SQLException e){
			log("Fail judgereserve");
		}finally{
			DBManager.close(conn, psmt, rs);
			log("6/6 Success judgereserve");
		}
				
		return r_poll;	// 0: 투표 X, 1: 좋아요, 2: 싫어요 => true : 투표했음

	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
