package com.pyeondeuk.controller;

import com.pyeondeuk.model.MemberDAO;
import com.pyeondeuk.model.MemberDTO;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/fetchReviews")
public class FetchReviewsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");
        
        System.out.println("서블릿 연결");

        String csSeqParam = request.getParameter("csSeq"); // 요청 파라미터에서 csSeq 값 가져오기
        MemberDAO dao = new MemberDAO();

        List<MemberDTO> reviews;
        if (csSeqParam != null) {
            int csSeq = Integer.parseInt(csSeqParam); // csSeq 값 변환
            
            System.out.println(csSeq);
            reviews = dao.getReviewsByCsSeq(csSeq); // 특정 지점의 리뷰 조회
        } else {
            reviews = dao.getAllReviews(); // 전체 리뷰 조회
        }

        Gson gson = new Gson();
        String json = gson.toJson(reviews); // 리뷰 리스트를 JSON 형식으로 변환
        response.getWriter().write(json); // JSON 응답 전송
    }
}