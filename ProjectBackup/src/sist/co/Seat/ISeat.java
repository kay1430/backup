package sist.co.Seat;

import java.util.List;

public interface ISeat {

	List<SeatDTO> getSeatList(int th_seq, String s_date);
	boolean adminSeatSetting(int th_seq, String s_name, String s_date);
	SeatDTO confirmSeatCheck(int th_seq, String s_name, String s_date);
	boolean reserAfSeat(int s_seq);
	int cal_leftSeat(int th_seq, String s_date);
}
