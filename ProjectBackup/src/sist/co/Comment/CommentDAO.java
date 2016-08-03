package sist.co.Comment;
 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import sist.co.DBManager.DBManager;

public class CommentDAO {
	
	private static CommentDAO commentdao;
	
	
	public static CommentDAO getInstance(){
		if (commentdao == null) {
			commentdao = new CommentDAO();
		}
		return commentdao;
	
	}
	
	//댓글 리스트로 불러옴
	public List<CommentDTO> selectComment(int r_seq){
		List<CommentDTO> list = new ArrayList<CommentDTO>();
		
		String sql = "select * from r_comment where r_seq = ? order by com_seq asc";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		try {
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, r_seq);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				CommentDTO com = new CommentDTO();
				int i =1;
				
				com.setCom_seq(rs.getInt(i++));
				com.setR_seq(rs.getInt(i++));
				com.setM_id(rs.getString(i++));
				com.setCom_content(rs.getString(i++));
				com.setCom_writedate(rs.getTimestamp(i++));
				
				list.add(com);
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally{
			DBManager.close(conn, pstmt, rs);
		}
		return list;
	}
	// 댓글입력
	public void insertComment(CommentDTO comdto){
		String sql ="insert into r_comment values (comment_seq.nextval,?,?,?,sysdate)";
		
		Connection conn= null;
		PreparedStatement pstmt = null;
		
		
		try {
			conn=DBManager.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, comdto.getR_seq());
			pstmt.setString(2, comdto.getM_id());
			pstmt.setString(3, comdto.getCom_content());
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally{
			DBManager.close(conn, pstmt);
		}
	}
	
	//댓글 삭제
	public void deleteComment(int com_seq){
		String sql = "delete from r_comment where com_seq = ?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		
		try {
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, com_seq);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally{
			DBManager.close(conn, pstmt);
		}
	}
	
	
	//댓글 수정
	public void updateComment(CommentDTO comdto){
		String sql = "update r_comment set com_content = ? where com_seq = ?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		
		try {
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, comdto.getCom_content());
			pstmt.setInt(2, comdto.getCom_seq());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally{
			DBManager.close(conn, pstmt);
		}
	}
	
}
