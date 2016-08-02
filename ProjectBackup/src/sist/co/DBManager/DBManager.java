package sist.co.DBManager;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class DBManager {

	//DB 연결부분
	public static Connection getConnection(){
		Connection conn=null;
		 
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String db_id="hr";
		String db_pw="hr";
		
		
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("연결성공");
			conn = DriverManager.getConnection(url,db_id,db_pw);
		} catch (Exception e) {
			System.out.println("DBManager 연결부분");
			e.printStackTrace();
		}
		return conn;
	}
	
	//DAO 작업시 select 작업 할 때 사용됨  
	public static void close(Connection conn, PreparedStatement pstmt, ResultSet rs){
		try{
			rs.close();
			pstmt.close();
			conn.close();
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
	}
	//DAO 작업시 insert,update,delete 등 에 사용됨
	public static void close(Connection conn, PreparedStatement pstmt){
		try{
			pstmt.close();
			conn.close();
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
	}
}
