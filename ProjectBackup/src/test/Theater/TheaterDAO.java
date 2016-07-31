package test.Theater;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import sist.co.DBManager.DBManager;
import test.Reservation.ReservationDAO;
import test.Reservation.ReservationDTO;

public class TheaterDAO implements iTheaterDAO {
	
	private boolean isS = true;
	private static TheaterDAO theaterDAO;
	  
	public static TheaterDAO getInstance(){
		if (theaterDAO == null) {
			theaterDAO = new TheaterDAO();
		}
		return theaterDAO;
	}
	

	@Override
	public TheaterDTO getTheater(int th_seq) {
		
		String sql = " SELECT * FROM THEATER WHERE TH_SEQ=? ";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		TheaterDTO tdto = null;

		try{
			conn = DBManager.getConnection();
			log("2/6 success getTheater");
			
			pstmt = conn.prepareStatement(sql);
			log("3/6 success getTheater");
			
			pstmt.setInt(1, th_seq);
			
			rs = pstmt.executeQuery();
			log("4/6 success getTheater");
			
			while(rs.next()){
				int i = 1;
				tdto = new TheaterDTO();
				
				tdto.setTh_seq(rs.getInt(i++));
				tdto.setTh_name(rs.getString(i++));
				tdto.setMv_seq(rs.getInt(i++));
				tdto.setTh_cinema(rs.getString(i++));
				tdto.setTh_num(rs.getInt(i++));
				tdto.setTh_totalseat(rs.getInt(i++));
				tdto.setTh_leftseat(rs.getInt(i++));
				tdto.setTh_time(rs.getDate(i++));
			}
			log("5/6 success getTheater");
			
		}catch(SQLException e){
			
			log("Fail getTheater");
			
		}finally {
			DBManager.close(conn, pstmt, rs);
			log("6/6 success getTheater");
		}
		
		return tdto;
	}
	
	public void log(String msg){
		if(isS){ //isS가 true일때
			System.out.println(this.getClass() + ":" + msg);
		}
	}

	public void log(String msg, Exception e ){
		if(isS){ //isS가 true일때
			System.out.println(e + ":" + this.getClass() + ":" + msg);
		}
	}

}
