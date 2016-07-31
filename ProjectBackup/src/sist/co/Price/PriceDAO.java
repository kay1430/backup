package sist.co.Price;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import sist.co.DBManager.DBManager;
import sist.movie.MovieDAO;
import sist.movie.MovieDTO;

public class PriceDAO implements IPrice{

	private boolean isS = true;
	private static PriceDAO priceDao;
	
	public void log(String msg){
		if(isS){
			System.out.println(getClass() + ":" + msg);					// getClass() == this.getClass()
		}
	}
	
	public void log(String msg, Exception e){							// Exception 까지 출력되도록 
		if(isS){
			System.out.println(e + ":" + getClass() + ":" + msg);		// getClass() == this.getClass()
		}
	}

	
	public static PriceDAO getInstance(){						// Singleton에 해당
		if(priceDao == null){
			priceDao = new PriceDAO();
		}
		return priceDao;
	}
	
	@Override
	public List<PriceDTO> getPriceList() {

		String sql = " SELECT * FROM PRICE ";
		
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		List<PriceDTO> plist = new ArrayList<PriceDTO>();

		try {
			conn = DBManager.getConnection();
			pstmt=conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			while(rs.next()){
				PriceDTO pdto = new PriceDTO();
				pdto.setP_seq(rs.getInt(1));
				pdto.setP_grade(rs.getString(2));
				pdto.setP_price(rs.getInt(3));
				plist.add(pdto);
			}
			
			
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally{
			DBManager.close(conn, pstmt);
		}
		
		return plist;
	}

	
	
}
