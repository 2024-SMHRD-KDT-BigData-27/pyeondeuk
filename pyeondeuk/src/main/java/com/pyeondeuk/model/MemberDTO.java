package com.pyeondeuk.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@Data  //모든 게터 세터 기본생성자 추가
@AllArgsConstructor  //모든 항목이 들어있는 생성자 추가
@NoArgsConstructor   //위에거 추가해서 사라진 기본생성자 추가
@ToString
public class MemberDTO {

   // 클래스의 구조는 필드(web_member 테이블의 컬럼!) + 메소드
   private String email;
   private String nick;
   private String pw;
   private int reviewSeq;
   private int csSeq;
   private String commentContent;
   private int rating;
   private String createdAt;
  

}