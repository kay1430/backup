package test.Reservation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import sist.co.DBManager.DBManager;
import test.Movie.MovieDTO;

public class ReservationDAO implements iReservateionDAO {
  
	private boolean isS = true;
	private static ReservationDAO reservDAO;
	
	public static ReservationDAO getInstance(){
		if (reservDAO == null) {
			reservDAO = new ReservationDAO();
		}
		return reservDAO;
	}
	
	@Override
	public List<ReservationDTO> getHistoryList(String m_id) {
		String sql = " SELECT * FROM RESERVATION WHERE R_TIME<SYSDATE and m_id=?";
		//지난 예매내역
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		List<ReservationDTO> rList = new ArrayList<ReservationDTO>();
		log("1/6 success getHistoryList");
		
		try{
			conn = DBManager.getConnection();
			log("2/6 success getHistoryList");
			
			pstmt = conn.prepareStatement(sql);
			log("3/6 success getHistoryList");
			pstmt.setString(1, m_id);
			rs = pstmt.executeQuery();
			log("4/6 success getHistoryList");
			
			while(rs.next()){
				int i = 1;
				ReservationDTO dto = new ReservationDTO();
				
				dto.setR_seq(rs.getInt(i++));
				dto.setM_id(rs.getString(i++));
				dto.setTh_seq(rs.getInt(i++));
				dto.setMv_seq(rs.getInt(i++));
				dto.setR_poll(rs.getInt(i++));
				dto.setR_totalprice(rs.getInt(i++));
				dto.setR_adult(rs.getInt(i++));
				dto.setR_student(rs.getInt(i++));
				dto.setR_elder(rs.getInt(i++));
				dto.setR_time(rs.getDate(i++));
				dto.setR_thname(rs.getString(i++));
				dto.setR_cinema(rs.getString(i++));
						 
				rList.add(dto);	
			}
			log("5/6 success getHistoryList");
			
		}catch(SQLException e){
			
			log("Fail getHistoryList");
			
		}finally {
			DBManager.close(conn, pstmt, rs);
			log("6/6 success getHistoryList");
		}
		
		return rList;
	}

	@Override
	public List<ReservationDTO> getTicketList() {
		String sql = " SELECT * FROM RESERVATION WHERE R_TIME>SYSDATE ";
		//내 티켓보기
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		List<ReservationDTO> rList = new ArrayList<ReservationDTO>();
		log("1/6 success getTicketList");
		
		try{
			conn = DBManager.getConnection();
			log("2/6 success getTicketList");
			
			pstmt = conn.prepareStatement(sql);
			log("3/6 success getTicketList");
			
			rs = pstmt.executeQuery();
			log("4/6 success getTicketList");
			
			while(rs.next()){
				int i = 1;
				ReservationDTO dto = new ReservationDTO();
				
				dto.setR_seq(rs.getInt(i++));
				dto.setM_id(rs.getString(i++));
				dto.setTh_seq(rs.getInt(i++));
				dto.setMv_seq(rs.getInt(i++));
				dto.setR_poll(rs.getInt(i++));
				dto.setR_totalprice(rs.getInt(i++));
				dto.setR_adult(rs.getInt(i++));
				dto.setR_student(rs.getInt(i++));
				dto.setR_elder(rs.getInt(i++));
				dto.setR_time(rs.getDate(i++));
				dto.setR_thname(rs.getString(i++));
				dto.setR_cinema(rs.getString(i++));
						 
				rList.add(dto);	
			}
			log("5/6 success getTicketList");
			
		}catch(SQLException e){
			
			log("Fail getTicketList");
			
		}finally {
			DBManager.close(conn, pstmt, rs);
			log("6/6 success getTicketList");
		}
		
		return rList;
	}

	@Override
	public ReservationDTO getTicket(int r_seq) {
		 String sql = " SELECT * FROM RESERVATION WHERE R_SEQ=? ";
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			ReservationDTO rdto = null;
			log("1/6 success getTicket");

			try{
				conn = DBManager.getConnection();
				log("2/6 success getTicket");
				
				pstmt = conn.prepareStatement(sql);
				log("3/6 success getTicket");
				
				pstmt.setInt(1, r_seq);
				
				rs = pstmt.executeQuery();
				log("4/6 success getTicket");
				
				while(rs.next()){
					int i = 1;
					rdto = new ReservationDTO();
					
					rdto.setR_seq(rs.getInt(i++));
					rdto.setM_id(rs.getString(i++));
					rdto.setTh_seq(rs.getInt(i++));
					rdto.setMv_seq(rs.getInt(i++));
					rdto.setR_poll(rs.getInt(i++));
					rdto.setR_totalprice(rs.getInt(i++));
					rdto.setR_adult(rs.getInt(i++));
					rdto.setR_student(rs.getInt(i++));
					rdto.setR_elder(rs.getInt(i++));
					rdto.setR_time(rs.getDate(i++));
					rdto.setR_thname(rs.getString(i++));
					rdto.setR_cinema(rs.getString(i++));
					
				}
				log("5/6 success getTicket");
				
			}catch(SQLException e){
				
				log("Fail getTicket");
				
			}finally {
				DBManager.close(conn, pstmt, rs);
				log("6/6 success getTicket");
			}
			
			return rdto;
	}
	@Override
	public boolean cancleReserv(int r_seq) {
		String sql = " DELETE FROM RESERVATION WHERE R_SEQ=? ";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		int count = 0;
		log("6/6 success cancleReserv");
		
		try{
			conn = DBManager.getConnection();
			log("2/6 success cancleReserv");
			
			pstmt = conn.prepareStatement(sql);
			log("3/6 success cancleReserv");
			
			pstmt.setInt(1, r_seq);
			
			count = pstmt.executeUpdate();
			log("4/6 success cancleReserv");
			
			
		}catch(SQLException e){
			
			log("Fail cancleReserv");
			
		}finally {
			DBManager.close(conn, pstmt);
			log("6/6 success cancleReserv");
		}
		return count>0?true:false;
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
