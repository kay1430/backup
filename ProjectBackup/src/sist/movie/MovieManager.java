package sist.movie;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class MovieManager {

	public List<MovieDTO> getCGVData() throws IOException{
		
		List<MovieDTO> list = new ArrayList<MovieDTO>();
		Document doc = Jsoup.connect("http://www.cgv.co.kr/movies/").get();
		
		Elements titleEle = doc.select("div.box-contents strong.title");
		Elements imgpathEle = doc.select("div.box-image span.thumb-image img[src]");
		System.out.println("img = "+imgpathEle);
		

		for (int i = 0; i < 7; i++) {
			Element titleE = titleEle.get(i);
			Element imgpathE = imgpathEle.get(i);
			System.out.println("imgpathE = "+imgpathE);
			
			
			String title = titleE.text();
			String imgpath = imgpathE.text();
			System.out.println("imgpath = "+imgpath);
			
			
			MovieDTO m = new MovieDTO();
			m.setMv_title(title);
			m.setMv_img(imgpath);
			
			list.add(m);
		}
		return list;
	
	}
	
}




































