package sist.co.Reservation;

import java.util.List;
  
public interface iReservateionDAO {
	//ay
	boolean judgereserve(int seq, String id);
	int judgepoll(int seq, String id);
	boolean reserve(ReservationDTO rdto);
	
	//bom
	List<ReservationDTO> getHistoryList(String m_id);
	List<ReservationDTO> getTicketList(String m_id);
	//ReservationDTO getTicket(int r_seq);
	boolean cancleReserv(int r_seq, int th_req);
}
