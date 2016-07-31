package sist.co.Review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import sist.co.DBManager.DBManager;

public class ReviewDAO {

	
	private static ReviewDAO reviewDao;
	
	
	public static ReviewDAO getInstance(){
		if (reviewDao == null) {
			reviewDao = new ReviewDAO();
		}
		return reviewDao;
	
	}
	
	
	//review 게시판 처음에 보여주기 위해 List<ReviewDTO> 형태로 리턴함
	public List<ReviewDTO> selectAllReview(){
		
		List<ReviewDTO> list = new ArrayList<ReviewDTO>();
		
		String sql = "select * from review order by r_seq desc";
		
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		try {
			conn=DBManager.getConnection();
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			while(rs.next()){
				ReviewDTO redto = new ReviewDTO();
				int i = 1;
				redto.setR_seq(rs.getInt(i++));
				redto.setM_id(rs.getString(i++));
				redto.setR_title(rs.getString(i++));
				redto.setR_content(rs.getString(i++));
				redto.setR_writedate(rs.getTimestamp(i++));
				redto.setR_like(rs.getInt(i++));
				redto.setR_readcount(rs.getInt(i++));
				
				list.add(redto);
			}
			
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally{
			DBManager.close(conn, pstmt, rs);
		}
		
		return list;
	}
	
	//review 게시판 글 작성 할 때 사용됨
	public int addReview(ReviewDTO redto){
		int result = -1;
		
		String sql ="insert into review values (review_seq.nextval,?,?,?,sysdate,0,0)";
		
		Connection conn=null;
		PreparedStatement pstmt = null;
		
		
		try {
			conn=DBManager.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, redto.getM_id());
			pstmt.setString(2, redto.getR_title());
			pstmt.setString(3, redto.getR_content());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally{
			DBManager.close(conn, pstmt);
		}
		
		
		return result;
	}

	//review 게시판 detail에 사용됨
	public ReviewDTO getReviewDTO(int r_seq){
		ReviewDTO redto = null;
		
		String sql = "select * from review where r_seq=?";
		
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		try {
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1,r_seq);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				redto = new ReviewDTO();
				int i = 1;
				
				redto.setR_seq(rs.getInt(i++));
				redto.setM_id(rs.getString(i++));
				redto.setR_title(rs.getString(i++));
				redto.setR_content(rs.getString(i++));
				redto.setR_writedate(rs.getTimestamp(i++));
				redto.setR_like(rs.getInt(i++));
				redto.setR_readcount(rs.getInt(i++));
				
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally{
			DBManager.close(conn, pstmt, rs);
		}
		
		
		return redto;
	}

	//review 게시판 detail 눌렀을시 readcount 증가용 메서드
	public void addReadCount(int r_seq){
		String sql = "update review set r_readcount = r_readcount+1 where r_seq = ?";
		
		int result = 0;
		
		Connection conn=null;
		PreparedStatement pstmt = null;
		
		
		try {
			conn = DBManager.getConnection();
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setInt(1,r_seq);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally{
			DBManager.close(conn, pstmt);
		}
	}
	
	//review 게시판 detail 안에서 좋아요 누르면 증가
	public void addLike(int r_seq){
		String sql = "update review set r_like = r_like+1 where r_seq = ?";
		
		int result = 0;
		
		Connection conn=null;
		PreparedStatement pstmt = null;
		
		
		try {
			conn = DBManager.getConnection();
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setInt(1,r_seq);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally{
			DBManager.close(conn, pstmt);
		}
	}
	
	// moviedetail에서 해당 영화의 리뷰 불러오기 by ay
	public List<ReviewDTO> seereview(int mv_seq){
		
		String sql = " SELECT M_ID, R_TITLE, R_CONTENT FROM REVIEW WHERE MV_SEQ=? ";
		
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		List<ReviewDTO> rlist = new ArrayList<ReviewDTO>();

		try {
			conn = DBManager.getConnection();
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setInt(1,mv_seq);
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				ReviewDTO rdto = new ReviewDTO();
				rdto.setM_id(rs.getString(1));
				rdto.setR_title(rs.getString(2));
				rdto.setR_content(rs.getString(3));
				System.out.println("rdto:" + rdto.getM_id());
				rlist.add(rdto);
			}
			
			
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally{
			DBManager.close(conn, pstmt);
		}
		
		return rlist;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
