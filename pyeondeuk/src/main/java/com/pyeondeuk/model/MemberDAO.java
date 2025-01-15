package com.pyeondeuk.model;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.pyeondeuk.db.SqlSessionManager;
import com.pyeondeuk.model.MemberDTO;

public class MemberDAO {

	// DB와 직접적으로 연결이 시작되는 클래스 !
	// 회원의 정보로 처리할 수 있는 모든 기능을 메소드 정리 !
	// 회원가입, 로그인, 회원정보수정, 회원탈퇴,....

	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSessionFactory();

	public int join(MemberDTO dto) {

		// 1. 데이터베이스 연결하기
		// openSession(true) -> 자동 커밋기능 !
		SqlSession sqlSession = sqlSessionFactory.openSession(true);

		// 2. SQL문장 생성 -> xml 파일로 쿼리문 생성 !
		// 3. 쿼리 실행
		int cnt = sqlSession.insert("join", dto);
		// 4. 결과값 처리
		if (cnt > 0) {
			System.out.println("회원가입 성공");
		} else {
			System.out.println("회원가입 실패...");
		}
		// 5. DB연결 종료
		sqlSession.close();

		return cnt;
	}

	public MemberDTO login(MemberDTO dto) {

		SqlSession sqlSession = sqlSessionFactory.openSession(true); // true 자동 커밋

		// 전체 DB의 내용에서 특정 회원에 대한 하나의 정보만 가지고오기 위함!
		MemberDTO info = sqlSession.selectOne("login", dto);
		sqlSession.close();
		return info;
	}

	public int update(MemberDTO dto) {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		int cnt = sqlSession.update("update", dto);
		sqlSession.close();
		return cnt;
	}
	
	public boolean isNickAvailable(String nick) {
	    SqlSession sqlSession = sqlSessionFactory.openSession(true);
	    int count = sqlSession.selectOne("checkNick", nick);
	    sqlSession.close();
	    return count == 0; // 0이면 사용 가능, 1 이상이면 중복
	}


}
