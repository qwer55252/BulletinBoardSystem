package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS"; // localhost:3306은 본인 컴퓨터의 설치된 MySQL 서버 자체를 의미
			String dbID = "root";
			String dbPassword = "12345678";
			Class.forName("com.mysql.jdbc.Driver"); // MySQL에접근할 수 있도록 하는 매개체 라이브러리
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword); // 접속 완료 
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL); // 정해진 SQL 문장을 데이터베이스에 삽입하는 형식으로 인스턴스를 가져온다
			pstmt.setString(1, userID); // sql인젝션같은 해킹 기법을 방어하기 위한 수단
			rs = pstmt.executeQuery();
			if (rs.next()) { // userID 가 같은 회원이 존재하면
				if (rs.getString(1).equals(userPassword)) {
					return 1; // 로그인 성공
				}
				else 
					return 0; // 비밀번호 불일치
			}
			return -1; // 아이디가 없음 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; //데이터베이스 오류 
	} // 로그인 기능 구현 완료
}
