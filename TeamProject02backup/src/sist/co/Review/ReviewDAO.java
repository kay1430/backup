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
				redto.setMv_seq(rs.getInt(i++));
				redto.setR_title(rs.getString(i++));
				redto.setR_content(rs.getString(i++));
				redto.setR_writedate(rs.getTimestamp(i++));
				redto.setR_like(rs.getInt(i++));
				redto.setR_readcount(rs.getInt(i++));
				redto.setR_star(rs.getInt(i++));
				
				
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
		
		String sql ="insert into review values (review_seq.nextval,?,?,?,?,sysdate,0,0,?)";
		
		Connection conn=null;
		PreparedStatement pstmt = null;
		
		
		try {
			conn=DBManager.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, redto.getM_id());
			pstmt.setInt(2, redto.getMv_seq());
			pstmt.setString(3, redto.getR_title());
			pstmt.setString(4, redto.getR_content());
			pstmt.setInt(5, redto.getR_star());
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
				redto.setMv_seq(rs.getInt(i++));
				redto.setR_title(rs.getString(i++));
				redto.setR_content(rs.getString(i++));
				redto.setR_writedate(rs.getTimestamp(i++));
				redto.setR_like(rs.getInt(i++));
				redto.setR_readcount(rs.getInt(i++));
				redto.setR_star(rs.getInt(i++));
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
	
	// ReviewList에서 검색기능
	public List<ReviewDTO> selectContent(String check, String selecting){
		List<ReviewDTO> selList = new ArrayList<ReviewDTO>();
		
		String sql = " ";
		
		if(check.equals("1")){
			//제목으로 검색
			sql = "select * from review where regexp_like(r_title,?)";
		}else if(check.equals("2")){
			//본문으로 검색
			sql = "select * from review where regexp_like(r_content,?)";
		}
		
		
		Connection conn = null;
		PreparedStatement pstmt= null;
		ResultSet rs = null;
		
		try {
			conn=DBManager.getConnection();
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, selecting);
			rs=pstmt.executeQuery();
			
			while(rs.next()){
				ReviewDTO redto = new ReviewDTO();
				int i = 1;
				redto.setR_seq(rs.getInt(i++));
				redto.setM_id(rs.getString(i++));
				redto.setMv_seq(rs.getInt(i++));
				redto.setR_title(rs.getString(i++));
				redto.setR_content(rs.getString(i++));
				redto.setR_writedate(rs.getTimestamp(i++));
				redto.setR_like(rs.getInt(i++));
				redto.setR_readcount(rs.getInt(i++));
				redto.setR_star(rs.getInt(i++));
				
				/*System.out.println("r_seq = "+redto.getR_seq());*/
				selList.add(redto);
			}
			
		} catch (SQLException e) {
			System.out.println("DAO");
			System.out.println(e.getMessage());
		}finally{
			DBManager.close(conn, pstmt, rs);
		}
		
		return selList;
	}
	
	
	// ReviewList에서 댓글 수 표시할때 사용
	public int countComment(int r_seq){
		int count = 0;
		
		String sql = "select * from r_comment where r_seq=?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		try {
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, r_seq);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				count += 1;
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally{
			DBManager.close(conn, pstmt, rs);
		}
		
		return count;
	}
	
	
	// ReviewDelete에서 삭제할때
	public int deleteReview(int r_seq){
		int result = -1;
		
		String sql1 = "delete from review where r_seq=?";
		String sql2 = "delete from r_comment where r_seq=?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		
		try {
			conn = DBManager.getConnection();
			conn.setAutoCommit(false);
			
			pstmt = conn.prepareStatement(sql1);
			pstmt.setInt(1, r_seq);
			
			result = pstmt.executeUpdate();
			
			pstmt.clearParameters();
			
			pstmt = conn.prepareStatement(sql2);
			pstmt.setInt(1, r_seq);
			result *= pstmt.executeUpdate();
			
			conn.commit();
			
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			try{
				conn.rollback();
			}catch(Exception e1){
				System.out.println(e1.getMessage());
			}
		}finally{
			try{
				conn.setAutoCommit(true);
			}catch(Exception e2){
				System.out.println(e2.getMessage());
			}
			
			DBManager.close(conn, pstmt);
		}
		
		
		
		return result;
	}
	
	public void updateReview(ReviewDTO dto){
		String sql = "update review set r_title = ?,r_content=?,mv_seq=? where r_seq=?";
		
		Connection conn=null;
		PreparedStatement pstmt = null;
		
		
		try {
			conn=DBManager.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getR_title());
			pstmt.setString(2, dto.getR_content());
			pstmt.setInt(3, dto.getMv_seq());
			
			pstmt.setInt(4, dto.getR_seq());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally{
			DBManager.close(conn, pstmt);
		}
		
		
	}
	
	
	
	

}
