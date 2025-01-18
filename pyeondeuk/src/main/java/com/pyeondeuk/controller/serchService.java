package com.pyeondeuk.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pyeondeuk.model.ProductDAO;
import com.pyeondeuk.model.ProductDTO;


@WebServlet("/serchService")
public class serchService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		request.setCharacterEncoding("UTF-8");
	    String search = request.getParameter("search");
	    ProductDAO dao = new ProductDAO();
	    List<ProductDTO> dto = dao.products_keyword_calling(search);

	    System.out.println("검색 키워드: " + search);
	    System.out.println("검색 결과 크기: " + (dto != null ? dto.size() : "null"));

	    request.setAttribute("search_result", dto);
	    request.getRequestDispatcher("index.jsp").forward(request, response);
		
	}

}
