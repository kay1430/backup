package sist.movie;

import java.util.List;

public interface ITheater {
	
	List<TheaterDTO> getTheaterList(int mv_seq);
	List<TheaterDTO> getTh_num(int mv_seq, String th_name, String th_cinema);
}
