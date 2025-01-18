<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pyeondeuk.model.EventDTO" %>
<%@ page import="com.pyeondeuk.model.EventDAO" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <link rel="stylesheet" href="resources/css/event.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>이벤트 페이지</title>
</head>

<body class="is-preload homepage">
    <div id="page-wrapper">

        <!-- Header -->
        <div id="header-wrapper">
            <header id="header" class="container">
                <div id="logo">
                    <a href="index.jsp"><img src="resources/images/logo.png" width="200px"></a>
                </div>
                <nav id="nav">
                    <ul>
                        <li><a href="index.jsp">메인페이지</a></li>
                        <li><a href="#">할인상품</a></li>
                        <li><a href="#">PB상품</a></li>
                        <li><a href="event.html">이벤트</a></li>
                        <li><a href="map.jsp">편의점찾기</a></li>
                        <li><a href="login.jsp">로그인</a></li>
                    </ul>
                </nav>
            </header>
        </div>

        <!-- 이벤트 정보 출력 -->
        <h1 style="text-align: center;">2025년 1월 <span style="color: orangered;">이벤트</span></h1>

        <div id="features-wrapper">
            <div class="container">
                <div class="row">
                    <% 
                        EventDAO eventDAO = new EventDAO();
                        
                        		for (int i = 1 ; i <50; i++){
                        	EventDTO event = eventDAO.getEvents(i);
                        	if (event != null){
                        
                      %>
                    <div class="col-3">
                        <section class="box feature">
                            <a href="<%= event.getEVENT_URL() %>" target="_blank" class="image featured">
                                <img src="<%=event.getEVENT_SRC() %>" alt="이벤트 이미지">
                            </a>
                            <div class="inner">
                                <header>
                                    <h2 style="text-align: center;"><%= event.getEVENT_NAME() %></h2>
                                </header>
                            </div>
                        </section>
                    </div>
                    <% 
                        		}else{
                        			System.out.print("null 값 발생");
                        		}
                        } 
                    %>
                </div>
            </div>
        </div>
    </div>

    <script src="./jquery.min.js"></script>
    <script src="./jquery.dropotron.min.js"></script>
    <script src="./browser.min.js"></script>
    <script src="./breakpoints.min.js"></script>
    <script src="./util.js"></script>
    <script src="./main.js"></script>
</body>

</html>
