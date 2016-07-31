package sist.movie;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import sist.co.DBManager.DBManager;

public class TheaterDAO_backup implements ITheater{

	private boolean isS = true;
	private static TheaterDAO_backup TheaterDao;
	
	public TheaterDAO_backup() {
	
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

	
	public static TheaterDAO_backup getInstance(){						// Singleton에 해당
		if(TheaterDao == null){
			TheaterDao = new TheaterDAO_backup();
		}
		return TheaterDao;
	}
	
	
	
	
	@Override
	public List<TheaterDTO> getTheaterList(int mv_seq) {
		
		String sql = " SELECT * FROM THEATER WHERE MV_SEQ=? ";
		
		Connection conn=null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<TheaterDTO> thlist = new ArrayList<TheaterDTO>();

		try {
			conn = DBManager.getConnection();
			psmt=conn.prepareStatement(sql);
			psmt.setInt(1, mv_seq);
			
			
			rs = psmt.executeQuery();
			while(rs.next()){
				TheaterDTO thdto = new TheaterDTO();
				int i = 1;
				thdto.setTh_seq(rs.getInt(i++));
				thdto.setTh_name(rs.getString(i++));
				thdto.setMv_seq(rs.getInt(i++));
				thdto.setTh_cinema(rs.getString(i++));
				thdto.setTh_num(rs.getInt(i++));
				thdto.setTh_totalseat(rs.getInt(i++));
				thdto.setTh_leftseat(rs.getInt(i++));
				thdto.setTh_time(rs.getTimestamp(i++));
				
				thlist.add(thdto);
			}
			
			
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally{
			DBManager.close(conn, psmt);
		}
		return thlist;
	}

	@Override
	public List<TheaterDTO> getTh_num(int mv_seq, String th_name, String th_cinema) {
		
		String sql = " SELECT TH_NUM, TO_CHAR(TH_TIME, 'YYYY-MM-DD HH24:MI:SS') FROM THEATER WHERE MV_SEQ=? AND TH_NAME=? AND TH_CINEMA=? ";
		
		Connection conn=null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<TheaterDTO> thlist = new ArrayList<TheaterDTO>();

		try {
			conn = DBManager.getConnection();
			psmt=conn.prepareStatement(sql);
			psmt.setInt(1, mv_seq);
			psmt.setString(2, th_name);
			psmt.setString(3, th_cinema);
			
			rs = psmt.executeQuery();
			while(rs.next()){
				TheaterDTO thdto = new TheaterDTO();
				thdto.setTh_num(rs.getInt(1));
				System.out.println("into:"+thdto.getTh_num());
				thdto.setTh_time(rs.getTimestamp(2));
				System.out.println("into:"+thdto.getTh_time());
				
				thlist.add(thdto);
			}
			
			
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally{
			DBManager.close(conn, psmt);
		}
		
		return thlist;
	}
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
