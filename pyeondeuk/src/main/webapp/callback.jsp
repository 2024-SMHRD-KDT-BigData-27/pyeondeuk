<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.lang.StringBuilder" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>네이버 로그인 콜백</title>
</head>
<body>
<%
    // 토큰 가져오기
    String token = request.getParameter("token");
    if (token != null && !token.isEmpty()) {
        try {
            // 네이버 사용자 정보 API 호출
            String apiURL = "https://openapi.naver.com/v1/nid/me";
            URL url = new URL(apiURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Authorization", "Bearer " + token);

            // 응답 처리
            int responseCode = conn.getResponseCode();
            if (responseCode == 200) { // 성공
                BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
                StringBuilder responseContent = new StringBuilder(); // 변수 이름 변경
                String inputLine;
                while ((inputLine = in.readLine()) != null) {
                    responseContent.append(inputLine);
                }
                in.close();

                // 사용자 정보 출력
                out.println("<h2>사용자 정보</h2>");
                out.println("<pre>" + responseContent.toString() + "</pre>");
            } else { // 실패
                out.println("<h2>네이버 로그인 실패</h2>");
                out.println("<p>응답 코드: " + responseCode + "</p>");
            }
        } catch (Exception e) {
            out.println("<h2>에러 발생</h2>");
            out.println("<pre>" + e.getMessage() + "</pre>");
        }
    } else {
        out.println("<h2>로그인 실패</h2>");
        out.println("<p>토큰이 없습니다.</p>");
    }
%>
</body>
<
