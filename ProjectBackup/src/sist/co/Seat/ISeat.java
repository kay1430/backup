package sist.co.Seat;

import java.util.List;

public interface ISeat {

	List<SeatDTO> getSeatList(int th_seq);
	boolean adminSeatSetting(int th_seq, String s_name);
}
