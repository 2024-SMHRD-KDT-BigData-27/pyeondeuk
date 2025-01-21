<%@page import="com.pyeondeuk.model.MemberDTO"%>
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
               <% MemberDTO info =(MemberDTO) session.getAttribute("info"); %>
    

				<!-- Nav -->
				<nav id="nav">
					<ul>
						<li class="current"><a href="index.jsp">메인페이지</a></li>
						<li><a href="store.jsp?storeId=1">플러스상품</a>
							<ul>
								<li><a href="store.jsp?storeId=1"><img
										src="resources/images/emart.png" width="70px"></a></li>
								<li><a href="store.jsp?storeId=2"><img
										src="resources/images/cu.png" width="50px"></a></li>
								<li><a href="store.jsp?storeId=3"><img
										src="resources/images/gs.png" width="60px"></a></li>
								<li><a href="store.jsp?storeId=4"><img
										src="resources/images/seven.png" width="70px"></a></li>
							</ul></li>

						<li><a href="store.jsp?storeId=5">PB상품</a>
							<ul>
								<li><a href="store.jsp?storeId=5"><img
										src="resources/images/emart.png" width="70px"></a></li>
								<li><a href="store.jsp?storeId=6"><img
										src="resources/images/cu.png" width="50px"></a></li>
								<li><a href="store.jsp?storeId=7"><img
										src="resources/images/gs.png" width="60px"></a></li>
								<li><a href="store.jsp?storeId=8"><img
										src="resources/images/seven.png" width="70px"></a></li>
							</ul></li>
						<li><a href="event.jsp" style="background-color: #444; color: white;">이벤트</a></li>
						<li><a href="map.jsp">편의점찾기</a></li>
						<%if(info == null){%>
                  		<li><a href="login.jsp">로그인</a></li>
                  		<%}else{ %>
                     <!-- 로그인 후 Logout.jsp로 이동할 수 있는'로그아웃'링크와 '개인정보수정'링크를 출력하시오. -->
                     <li><a href="LogoutService">로그아웃</a></li>
                     <li><a href="update.jsp">회원정보</a></li>
                  <%} %>
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
                        
                        		for (int i = 32; i >0; i--){
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
