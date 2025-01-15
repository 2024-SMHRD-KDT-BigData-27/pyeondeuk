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

@WebServlet("/LoginService")
public class LoginService extends HttpServlet {
   private static final long serialVersionUID = 1L;

   protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      
      // 회원의 로그인을 처리하는 서비스!
      
      // 1. 인코딩
      request.setCharacterEncoding("UTF-8");
      
      // 2. 데이터 꺼내오기
      String email = request.getParameter("email");
      String pw = request.getParameter("pw");
      
      // 3. 데이터 처리 -> DB에 해당하는 회원이 있는지 체크하기!
      
      MemberDTO dto = new MemberDTO();
      dto.setEmail(email);
      dto.setPw(pw);                              
      
      MemberDAO dao = new MemberDAO();
      MemberDTO info = dao.login(dto);
      
      // 4. 결과 화면 출력
      if(info != null) {
    	  System.out.println("로그인 성공!");
    	  HttpSession session = request.getSession();
    	  session.setAttribute("info", info);
    	  response.sendRedirect("index.jsp");
      }else {
    	  System.out.println("로그인 실패...");
    	  response.sendRedirect("login.jsp");
      }
      
     
   }

}
