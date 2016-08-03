package sist.co.Seat;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import sist.co.DBManager.DBManager;
import sist.co.Movie.MovieDAO;
import sist.co.Movie.MovieDTO;

public class SeatDAO implements ISeat{

	//ay : 0803수정할거 : 모든 함수가 예전 seatDTO를 따르므로 수정해야함
	private boolean isS = true;
	private static SeatDAO seatDao;
	
	public SeatDAO() {
	
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

	
	public static SeatDAO getInstance(){						// Singleton에 해당
		if(seatDao == null){
			seatDao = new SeatDAO();
		}
		return seatDao;
	}

	@Override
	public List<SeatDTO> getSeatList(int th_seq, String s_date) {
	
		String sql = " SELECT * FROM SEAT WHERE TH_SEQ=? AND S_DATE=TO_DATE(?, 'YYYY-MM-DD') ORDER BY S_SEQ ";
		
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		List<SeatDTO> slist = new ArrayList<SeatDTO>();

		try {
			conn = DBManager.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, th_seq);
			pstmt.setString(2, s_date);

			rs = pstmt.executeQuery();
			while(rs.next()){
				SeatDTO sdto = new SeatDTO();
				sdto.setS_seq(rs.getInt(1));
				sdto.setTh_seq(rs.getInt(2));
				sdto.setS_name(rs.getString(3));
				sdto.setS_check(rs.getInt(4));
				sdto.setS_date(rs.getDate(5));
				slist.add(sdto);
			}
			
			
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally{
			DBManager.close(conn, pstmt);
		}
		
		return slist;
	}

	@Override
	public boolean adminSeatSetting(int th_seq, String s_name, String s_date) {
		
		String sql = " INSERT INTO SEAT VALUES(S_SEQ.NEXTVAL, ?, ?, 0, TO_DATE(?, 'YYYY-MM-DD')) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
				
		int count = 0;
		
		try{
			conn = DBManager.getConnection();
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, th_seq);
			psmt.setString(2, s_name);
			psmt.setString(3, s_date);
			
			count = psmt.executeUpdate();
			
			
		}catch(SQLException e){
			log("Fail adminSeatSetting");
		}finally{
			DBManager.close(conn, psmt);
			//log("6/6 Success adminSeatSetting");
		}
		
		return count>0?true:false;

	}

	//예매완료하기 직전에 다시한번 해당좌석들만 예매안된건지 확인
	@Override
	public SeatDTO confirmSeatCheck(int th_seq, String s_name, String s_date) {

		String sql = " SELECT * FROM SEAT WHERE TH_SEQ=? AND S_NAME=? AND S_DATE=TO_DATE(?, 'YYYY-MM-DD') ";
		
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		SeatDTO sdto = new SeatDTO();
		try {
			conn = DBManager.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, th_seq);
			pstmt.setString(2, s_name);
			pstmt.setString(3, s_date);
			log("3/6 Success confirmSeatCheck");
			
			rs = pstmt.executeQuery();
			log("4/6 Success confirmSeatCheck");
			while(rs.next()){
				sdto.setS_seq(rs.getInt(1));
				sdto.setTh_seq(rs.getInt(2));
				sdto.setS_name(rs.getString(3));
				sdto.setS_check(rs.getInt(4));
				sdto.setS_date(rs.getDate(5));
			}
			
			
		} catch (SQLException e) {
			log("Fail confirmSeatCheck");
		}finally{
			DBManager.close(conn, pstmt);
			log("6/6 Success confirmSeatCheck");
		}
		
		return sdto;
	}

	@Override
	public boolean reserAfSeat(int s_seq) {
		
		String sql = " UPDATE SEAT SET S_CHECK=1 WHERE S_SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
				
		int count = 0;
		
		try{
			conn = DBManager.getConnection();
			log("2/6 Success reserAfSeat");
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, s_seq);
			log("3/6 Success reserAfSeat");
			count = psmt.executeUpdate();
			log("4/6 Success reserAfSeat");
		}catch(SQLException e){
			log("Fail reserAfSeat");
		}finally{
			DBManager.close(conn, psmt);
			log("6/6 Success reserAfSeat");
		}
		
		return count>0?true:false;
	}

	// 비어있는 좌석(S_CHECK=0)수 계산. 
	@Override
	public int cal_leftSeat(int th_seq, String s_date) {	
		
		String sql = " SELECT S_NAME FROM SEAT WHERE TH_SEQ=? AND S_CHECK=0 AND S_DATE=TO_DATE(?, 'YYYY-MM-DD') ORDER BY S_NAME ";
		
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int count = 0;

		try {
			conn = DBManager.getConnection();
			log("2/6 Success cal_leftSeat");
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, th_seq);
			pstmt.setString(2, s_date);
			log("3/6 Success cal_leftSeat");
			rs = pstmt.executeQuery();
			while(rs.next()){
				count++;
			}
			log("4/6 Success cal_leftSeat");
			
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			log("Fail cal_leftSeat");
		}finally{
			DBManager.close(conn, pstmt);
		}
		
		return count;

	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
