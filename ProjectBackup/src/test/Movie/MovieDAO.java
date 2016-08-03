package test.Movie;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import sist.co.DBManager.DBManager;
import test.Theater.TheaterDAO;
import test.Theater.TheaterDTO;

public class MovieDAO implements iMovieDAO {
	  
	private boolean isS = true;
	private static MovieDAO movieDAO;
	
	public static MovieDAO getInstance(){
		if (movieDAO == null) {
			movieDAO = new MovieDAO();
		}
		return movieDAO;
	}

	@Override
	public MovieDTO getMovie(int mv_seq) {
        String sql = " SELECT * FROM MOVIE WHERE MV_SEQ=? ";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		MovieDTO mdto = null;

		try{
			conn = DBManager.getConnection();
			log("2/6 success getMovie");
			
			pstmt = conn.prepareStatement(sql);
			log("3/6 success getMovie");
			
			pstmt.setInt(1, mv_seq);
			
			rs = pstmt.executeQuery();
			log("4/6 success getMovie");
			
			while(rs.next()){
				int i = 1;
				mdto = new MovieDTO();
				
				mdto.setMv_seq(rs.getInt(i++));
				mdto.setMv_title(rs.getString(i++));
				mdto.setMv_openday(rs.getDate(i++));
				mdto.setMv_genre(rs.getString(i++));
				mdto.setMv_story(rs.getString(i++));
				mdto.setMv_img(rs.getString(i++));
				mdto.setMv_count(rs.getInt(i++));
				mdto.setMv_like(rs.getInt(i++));
				mdto.setMv_hate(rs.getInt(i++));
				mdto.setMv_on(rs.getInt(i++));
				
			}
			log("5/6 success getMovie");
			
		}catch(SQLException e){
			
			log("Fail getMovie");
			
		}finally {
			DBManager.close(conn, pstmt, rs);
			log("6/6 success getMovie");
		}
		
		return mdto;
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
