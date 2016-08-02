package sist.co.ShowMovie;

public class MovieVO {
	 
	private String title;
	private int like;
	private String date;
	private String reser;
	private String movie_img;
	private int num;
	
	public MovieVO() {
		// TODO Auto-generated constructor stub
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getLike() {
		return like;
	}

	public void setLike(int like) {
		this.like = like;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getReser() {
		return reser;
	}

	public void setReser(String reser) {
		this.reser = reser;
	}

	public String getMovie_img() {
		return movie_img;
	}

	public void setMovie_img(String movie_img) {
		this.movie_img = movie_img;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	@Override
	public String toString() {
		return "MovieVO [title=" + title + ", like=" + like + ", date=" + date + ", reser=" + reser + ", movie_img="
				+ movie_img + ", getTitle()=" + getTitle() + ", getLike()=" + getLike() + ", getDate()=" + getDate()
				+ ", getReser()=" + getReser() + ", getMovie_img()=" + getMovie_img() + ", getClass()=" + getClass()
				+ ", hashCode()=" + hashCode() + ", toString()=" + super.toString() + "]";
	}
	
	
	

}
