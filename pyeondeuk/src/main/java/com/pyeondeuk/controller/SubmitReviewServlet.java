package com.pyeondeuk.controller;
import java.io.IOException;
import java.io.PrintWriter;

import com.pyeondeuk.model.MemberDAO;
import com.pyeondeuk.model.MemberDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/submitReview")
public class SubmitReviewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        System.out.println("서블릿 연결");
        // 클라이언트에서 받은 데이터
        try {
            // 파라미터 읽기 및 Null 체크
            String csSeqParam = request.getParameter("csSeq");
            String email = request.getParameter("email");
            String commentContent = request.getParameter("commentContent");
            String ratingParam = request.getParameter("rating");

            if (csSeqParam == null || ratingParam == null || email == null || commentContent == null) {
                throw new IllegalArgumentException("필수 파라미터가 누락되었습니다.");
            }

            // 숫자 변환
            int csSeq = Integer.parseInt(csSeqParam);
            int rating = Integer.parseInt(ratingParam);

            System.out.println("csSeq: " + csSeq);
            System.out.println("rating: " + rating);

            // DTO 생성
            MemberDTO review = new MemberDTO();
            review.setCsSeq(csSeq);
            review.setEmail(email);
            review.setCommentContent(commentContent);
            review.setRating(rating);

            // DAO를 통해 데이터베이스에 저장
            MemberDAO dao = new MemberDAO();
            boolean isSuccess = dao.saveReview(review);

            // 결과 응답
            response.setContentType("application/json; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.print("{\"success\": " + isSuccess + "}");
            out.close();
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.setContentType("application/json; charset=UTF-8");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            PrintWriter out = response.getWriter();
            out.print("{\"success\": false, \"error\": \"잘못된 숫자 형식입니다.\"}");
            out.close();
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
            response.setContentType("application/json; charset=UTF-8");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            PrintWriter out = response.getWriter();
            out.print("{\"success\": false, \"error\": \"" + e.getMessage() + "\"}");
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("application/json; charset=UTF-8");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            PrintWriter out = response.getWriter();
            out.print("{\"success\": false, \"error\": \"서버 내부 오류가 발생했습니다.\"}");
            out.close();
        }
    }
}