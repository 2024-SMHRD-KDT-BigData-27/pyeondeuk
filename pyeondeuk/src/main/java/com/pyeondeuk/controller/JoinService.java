package com.pyeondeuk.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pyeondeuk.model.MemberDAO;
import com.pyeondeuk.model.MemberDTO;


@WebServlet("/JoinService")
public class JoinService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 회원가입을 처리하기 위한 서비스 
		// 1. 인코딩 작업 
		request.setCharacterEncoding("UTF-8");
		// 2. 데이터 꺼내오기 
		String email = request.getParameter("email");
		String nick = request.getParameter("nick");
		String pw = request.getParameter("pw");
		// 3. 데이터 처리하기
		//System.out.println(email + "/"+pw+"/"+tel+"/"+address);
		
		// DTO 호출
		MemberDTO dto = new MemberDTO(email,nick,pw);
		// DB에 접근을 위한 기능을 호출하는 객체 !
		MemberDAO dao = new MemberDAO();
		
		// 이메일 중복 확인
        if (!dao.isEmailAvailable(email)) {
            request.setAttribute("error", "이미 사용 중인 이메일입니다.");
            RequestDispatcher rd = request.getRequestDispatcher("sign.jsp");
            rd.forward(request, response);
            return;
        }

        // 닉네임 중복 확인
        if (!dao.isNickAvailable(nick)) {
            request.setAttribute("error", "이미 사용 중인 닉네임입니다.");
            RequestDispatcher rd = request.getRequestDispatcher("sign.jsp");
            rd.forward(request, response);
            return;
        }
		int result = dao.join(dto);
		// 4. 결과 화면 출력 
		if (result > 0) {
	         // 성공시 join_success.jsp 이동
	         // +) 어떤 이메일로 회원가입을 했는지 해당 정보를 가지고 이동!
	         // -> 정보를 가지고 페이지를 이동해야 한다! -> 포워드 방식으로 이동!
	         // 정보를 공유할 수 있는 영역 -> reqeust 영역!

	         request.setAttribute("email", email);
	         RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
	         rd.forward(request, response);

	      } else {
	         // 실패시 다시 main.jsp로 이동!
	         response.sendRedirect("login.jsp");
	      }
		
		
	}

}
