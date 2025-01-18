package com.pyeondeuk;

import com.pyeondeuk.model.MemberDAO;
import com.pyeondeuk.model.MemberDTO;

public class test {
    public static void main(String[] args) {
        MemberDAO dao = new MemberDAO();
        MemberDTO review = new MemberDTO();
        review.setCsSeq(1);
        review.setEmail("test@example.com");
        review.setCommentContent("리뷰 내용");
        review.setRating(3);

        boolean result = dao.saveReview(review);
        System.out.println("리뷰 저장 결과: " + result);
    }
}
