package sist.co.Movie;

import java.util.List;

public interface IMovie {
 
	MovieDTO getmoviedetail(int seq);
	boolean addlike(int seq, int likeorhate, String id);
	List<MovieDTO> getOnMovieList();
	
	// SNS/ReviewWrite에서 사용됨
	List<MovieDTO> getMovie(); 
	
	String getMvIMG(int mv_seq);
}
