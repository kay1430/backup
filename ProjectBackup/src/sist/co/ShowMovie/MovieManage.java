package sist.co.ShowMovie;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class MovieManage {
	 
	
	public List<MovieVO> getMovieVO() throws IOException{
		
		List<MovieVO> movieList = new ArrayList<MovieVO>();
		MovieVO movieVO = null;
		Document doc = Jsoup.connect("http://www.cgv.co.kr/movies/").get();
		
		
		Elements titleEle =doc.select("div.box-contents strong.title");		//타이틀 다 불러오기
		Elements likeEle = doc.select("div.box-contents span.like span.count strong i");
		Elements imgs = doc.select("div.box-image span.thumb-image img[src]");
		Elements reserEle = doc.select("div.box-contents div.score strong.percent span");
		Elements dateEle = doc.select("div.box-contents span.txt-info strong");
		

		
		/*System.out.println("imgs : "+imgs.text());
		System.out.println("likeEle = "+likeEle.text());*/
		// <div class="box-contents">
		// <span class="like"> 
		// <span class="count"> 
		
		for(int i=0;i<7;i++){

			Element titleE = titleEle.get(i);
			Element likeE = likeEle.get(i);
			Element img = imgs.get(i);
			Element reserE = reserEle.get(i);
			Element dateE = dateEle.get(i);
			
			
			String[] myarray = img.toString().split("=");
			
			System.out.println("myarray[1] = "+myarray[1]);
			int a1 = myarray[1].indexOf(" ");
			
			
			String movie_img = myarray[1].substring(0,a1);
			String title = titleE.text();
			int like = Integer.parseInt(likeE.text().replace(",", ""));
			String reser=reserE.text();
			String date = dateE.text();
			
			
			movieVO = new MovieVO();
			
			movieVO.setNum(i);
			movieVO.setTitle(title);
			movieVO.setLike(like);
			movieVO.setMovie_img(movie_img);
			movieVO.setReser(reser);
			movieVO.setDate(date);

			movieList.add(movieVO);
		}
		return movieList;
	}

	
	
}
