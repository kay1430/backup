package sist.co.Theater;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import sist.co.DBManager.DBManager;

public class TheaterDAO implements ITheater{

	private boolean isS = true;
	private static TheaterDAO TheaterDao;
	
	public TheaterDAO() {
	
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

	
	public static TheaterDAO getInstance(){						// Singleton에 해당
		if(TheaterDao == null){
			TheaterDao = new TheaterDAO();
		}
		return TheaterDao;
	}
	
	
	
	// sysdate >= th_s_date 이면서 sysdate <= th_e_date 인 Theater data만 불러와야함. 
	@Override
	public List<TheaterDTO> getTheaterList(int mv_seq) {
		
		String sql = " SELECT * FROM THEATER WHERE MV_SEQ=? AND SYSDATE>=TH_S_DATE AND SYSDATE<=TH_E_DATE ORDER BY MV_SEQ ";
		
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
				thdto.setTh_time(rs.getTimestamp(i++));
				thdto.setTh_s_date(rs.getDate(i++));
				thdto.setTh_e_date(rs.getDate(i++));
				
				thlist.add(thdto);
			}
			
			
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally{
			DBManager.close(conn, psmt);
		}
		return thlist;
	}

	// 상영시간표 출력시 사용 . but, 현재 Reserve.jsp의 getTheaterMatch() 메소드가 대체 (0804)
	@Override
	public List<TheaterDTO> getTh_num(int mv_seq, String th_name, String th_cinema) {	
		
		String sql = " SELECT TH_SEQ, TH_NUM, TO_CHAR(TH_TIME, 'YYYY-MM-DD HH24:MI:SS') FROM THEATER WHERE MV_SEQ=? AND TH_NAME=? AND TH_CINEMA=? ";
		
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
				thdto.setTh_seq(rs.getInt(1));
				thdto.setTh_num(rs.getInt(2));
				thdto.setTh_time(rs.getTimestamp(3));
				
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
	public TheaterDTO getTheaterinform(int th_seq) {
		String sql = " SELECT * FROM THEATER WHERE TH_SEQ=? ";
		
		Connection conn=null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		TheaterDTO thdto = new TheaterDTO();

		try {
			conn = DBManager.getConnection();
			psmt=conn.prepareStatement(sql);
			psmt.setInt(1, th_seq);
			
			
			rs = psmt.executeQuery();
			while(rs.next()){
				int i = 1;
				thdto.setTh_seq(rs.getInt(i++));
				thdto.setTh_name(rs.getString(i++));
				thdto.setMv_seq(rs.getInt(i++));
				thdto.setTh_cinema(rs.getString(i++));
				thdto.setTh_num(rs.getInt(i++));
				thdto.setTh_totalseat(rs.getInt(i++));
				thdto.setTh_time(rs.getTimestamp(i++));
				thdto.setTh_s_date(rs.getDate(i++));
				thdto.setTh_e_date(rs.getDate(i++));
			}
			
			
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally{
			DBManager.close(conn, psmt);
		}
		return thdto;
	}


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
