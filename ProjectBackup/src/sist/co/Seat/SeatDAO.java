package sist.co.Seat;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import sist.co.DBManager.DBManager;
import sist.movie.MovieDAO;
import sist.movie.MovieDTO;

public class SeatDAO implements ISeat{

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
	public List<SeatDTO> getSeatList(int th_seq) {
	
		String sql = " SELECT * FROM SEAT WHERE TH_SEQ=? ";
		
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		List<SeatDTO> slist = new ArrayList<SeatDTO>();

		try {
			conn = DBManager.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, th_seq);

			rs = pstmt.executeQuery();
			while(rs.next()){
				SeatDTO sdto = new SeatDTO();
				sdto.setS_seq(rs.getInt(1));
				sdto.setTh_seq(rs.getInt(2));
				sdto.setS_name(rs.getString(3));
				sdto.setS_check(rs.getInt(4));
				slist.add(sdto);
			}
			
			
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally{
			DBManager.close(conn, pstmt);
		}
		
		return slist;
	}
	
	
	
	
}
