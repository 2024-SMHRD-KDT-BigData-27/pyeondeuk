package com.pyeondeuk.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pyeondeuk.model.MemberDAO;
import com.pyeondeuk.model.MemberDTO;




@WebServlet("/UpdateService")
public class UpdateService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		MemberDTO info = (MemberDTO)session.getAttribute("info");
		
		String email = info.getEmail();
		String nick = request.getParameter("nick");
		String pw = request.getParameter("pw");
		
		MemberDTO dto = new MemberDTO(email,nick,pw);
		MemberDAO dao = new MemberDAO();
		int cnt = dao.update(dto);
		
		if(cnt>0) {
			System.out.println("회원정보 수정 성공!");
			session.setAttribute("info", dto);
		}else {
			System.out.println("회원정보 수정 실패...");
		}
		response.sendRedirect("index.jsp");
	}

}