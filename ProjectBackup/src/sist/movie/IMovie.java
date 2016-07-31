package sist.movie;

import java.util.List;

public interface IMovie {

	MovieDTO getmoviedetail(int seq);
	boolean addlike(int seq, int likeorhate, String id);
	List<MovieDTO> getOnMovieList();
	
}
