<%@page import="com.pyeondeuk.model.EventDAO"%>
<%@page import="com.pyeondeuk.model.EventDTO"%>
<%@page import="java.awt.Event"%>
<%@page import="com.pyeondeuk.model.ProductDAO"%>
<%@page import="com.pyeondeuk.model.ProductDTO"%>
<%@page import="com.pyeondeuk.model.MemberDTO"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>

<html>

<head>
<title>편득이</title>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="resources/css/main3.css" />
<link rel="stylesheet" href="resources/css/font.css" />
</head>
<style>

.col-3 .inner header h1 {
	white-space: nowrap; /* 텍스트를 한 줄로 제한 */
	overflow: hidden; /* 넘친 텍스트 숨김 */
	text-overflow: ellipsis; /* 넘친 부분에 '...' 표시 */
}

.col-3 .box.feature img {
	max-width: 100%; /* 부모의 너비에 맞게 크기 조정 */
	max-height: 100%;
	height: auto; /* 이미지 비율 유지 */
}
</style>

<body class="is-preload homepage">
	<div id="page-wrapper">

		<!-- Header -->
		<div id="header-wrapper">
			<header id="header" class="container">

				<!-- Logo -->
				<div id="logo">
					<a href="index.jsp"><img src="resources/images/logo.png"
						width="200px"></a>
				</div>



				<%
				MemberDTO info = (MemberDTO) session.getAttribute("info");
				ProductDAO dao_P = new ProductDAO();
				String brand = ""; // brand 변수 선언
				%>




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

						<li><a href="event.jsp">이벤트</a></li>
						<li><a href="map.jsp">편의점찾기</a></li>
						<%
						if (info == null) {
						%>
						<li><a href="login.jsp">로그인</a></li>
						<%
						} else {
						%>
						<!-- 로그인 후 Logout.jsp로 이동할 수 있는'로그아웃'링크와 '개인정보수정'링크를 출력하시오. -->
						<li><a href="LogoutService">로그아웃</a></li>
						<li><a href="update.jsp">회원정보</a></li>
						<%
						}
						%>

					</ul>
				</nav>

			</header>
		</div>

		<!-- 이벤트 배너 -->
		
		
		<div class="slider-container">
			<button class="arrow left">&lt;</button>
			<div class="flex-container">
			<%	
		for(int i=32; i > 0 ; i--){
		EventDAO evt_dao = new EventDAO();
		EventDTO evt_dto = evt_dao.getEvents(i);
		%>
				<div class="col-3">
					<section class="event">
						<a href="<%=evt_dto.getEVENT_URL() %>" class="event_img"> <img
							src="<%=evt_dto.getEVENT_SRC() %>"
							style="padding: 50px;" width="700px" height="400px">
						</a>
					</section>
				</div>
				<% } %>
			</div>
			<button class="arrow right">&gt;</button>
		</div>
		<script>
			const slider = document.querySelector('.flex-container');
			const leftArrow = document.querySelector('.arrow.left');
			const rightArrow = document.querySelector('.arrow.right');

			let currentIndex = 0;
			const totalItems = document.querySelectorAll('.col-3').length;
			const itemWidth = 600; // 개별 배너의 너비

			// 왼쪽 버튼 클릭
			leftArrow.addEventListener('click', () => {
				if (currentIndex > 0) {
					currentIndex--;
					updateSlider();
				}
			});

			// 오른쪽 버튼 클릭
			rightArrow.addEventListener('click', () => {
				if (currentIndex < totalItems - 1) {
					currentIndex++;
					updateSlider();
				}
			});

			// 슬라이더 위치 업데이트
			function updateSlider() {
				slider.style.transform = `translateX(-${currentIndex * itemWidth}px)`;
			}
		</script>

		<br>
		<!-- 플러스 상품 시작 -->
		<h1 style="text-align: center;">
			2025년 1월 <span style="color: orangered;">플러스상품</span>
		</h1>

		<form action="serchService" method="get">
			<input type="text" id="search" name="search"
				placeholder=" 찾으시는 1+1, 2+1 상품명을 입력해주세요. " required>
			<button type="submit" id="button" style="background-color: #696969;">검색</button>
		</form>
		<br>
		
		<%
		List<ProductDTO> search_result = (List<ProductDTO>) request.getAttribute("search_result"); 
		if (search_result == null) {

		%>

		<div id="features-wrapper">
			<div class="container">
				<div class="row">
					<%
					for (int i = 1; i <= 20; i++) {
					
						ProductDTO dto_P = dao_P.products_calling(i);
						switch (Integer.parseInt(dto_P.getBRAND_SEQ())) {
						    case 1:
						        brand = "이마트24";
						        break;
						    case 2:
						        brand = "CU";
						        break;
						    case 3:
						        brand = "GS25";
						        break;
						    case 4:
						        brand = "세븐일레븐";
						        break;
						    default:
						        brand = "알 수 없음"; // 예외 상황 처리
						        break;
						}
					%>
					
					<div class="col-3">
						<section class="box feature">
							<a href="./price-chart?prodSeq=<%=dto_P.getPROD_SEQ()%>" class="image featured"><img
								src="<%=dto_P.getPROD_IMG()%>"></a>
							<div class="inner">
								<header>
									<a href="./page2.html" id="page_move" style="text-decoration: none;">
										<h1 style="text-align: center;"><%=dto_P.getPROD_NAME()%></h1>
										<h2 style="text-align: center;"><%=dto_P.getPROD_PRICE()%>원</h2>
										<p style="text-align: center; color: #696969;"><%=brand %></p>
									</a>
								</header>
							</div>
						</section>
					</div>
					<%
					}
					%>
				</div>
			</div>
		</div>


		<br>
		<!-- PB상품 시작 -->
		<h1 style="text-align: center;">
			2025년 1월 <span style="color: orangered;">PB상품</span>
		</h1>

		<form action="serchService" method="get">
			<input type="text" id="search" name="search" placeholder=" 찾으시는 PB 상품명을 입력해주세요. "
				required>
			<button type="submit" id="button" style="background-color: #696969;">검색</button>
		</form>
		<br>
		

		<div id="features-wrapper">
         <div class="container">
            <div class="row">
               <%
               for (int i = 1; i <= 20; i++) {
                  ProductDTO dto_P = dao_P.products_PB_calling(i);
                  switch (Integer.parseInt(dto_P.getBRAND_SEQ())) {
				    case 1:
				        brand = "이마트24";
				        break;
				    case 2:
				        brand = "CU";
				        break;
				    case 3:
				        brand = "GS25";
				        break;
				    case 4:
				        brand = "세븐일레븐";
				        break;
				    default:
				        brand = "알 수 없음"; // 예외 상황 처리
				        break;
				}
               %>
               <div class="col-3">
                  <section class="box feature">
                     <a href="./price-chart?prodSeq=<%=dto_P.getPROD_SEQ()%>" class="image featured" style="text-decoration: none;"><img
                        src="<%=dto_P.getPROD_IMG() %>"
                        width="200px"></a>
                     <div class="inner">
                        <header>
                           <h1 style="text-align: center;"><%=dto_P.getPROD_NAME() %></h1>
                           <h2 style="text-align: center;"><%=dto_P.getPROD_PRICE()%>원</h2>
                           <p style="text-align: center;"><%=brand %></p>
                        </header>
                     </div>
                  </section>
               </div>
               <%
               }
               %>
            </div>
         </div>
      </div>
      <%}else{ %>
      
      
      <div id="features-wrapper">
      <div class="container">
      <div class="row">


    	
    	  <%for (ProductDTO product : search_result){
    		  switch (Integer.parseInt(product.getBRAND_SEQ())) {
			    case 1:
			        brand = "이마트24";
			        break;
			    case 2:
			        brand = "CU";
			        break;
			    case 3:
			        brand = "GS25";
			        break;
			    case 4:
			        brand = "세븐일레븐";
			        break;
			    default:
			        brand = "알 수 없음"; // 예외 상황 처리
			        break;
			}
            
          %>
        
          <div class="col-3">
             <section class="box feature">
                <a href="./price-chart?prodSeq=<%=product.getPROD_SEQ()%>" class="image featured searchImg" style="text-decoration: none;"><img
                   src="<%=product.getPROD_IMG() %>" class="innerimg"></a>
                <div class="inner">
                   <header>
                      <h1 style="text-align: center;"><%=product.getPROD_NAME() %></h1>
                      <h2 style="text-align: center;"><%=product.getPROD_PRICE()%>원</h2>
                      <p style="text-align: center;"><%=brand %></p>
                   </header>
                </div>
             </section>
          </div>
          <%
          }
    	  
    	  %>
    	  </div>
          </div>
       </div>
    	 <% 	 }
          %>
      
      


		<!-- Footer -->
		<div id="footer-wrapper">
			<footer id="footer" class="container">
				<div class="row">
					<section class="문의하기">
						<h3>문의하기</h3>
						<p>
							주소 : 광주 서구 월드컵4강로 27 <br /> 이메일 : bigdataty@gmail.com<br />
							전화번호 : 010-6235-5916
						</p>
					</section>
				</div>
		</div>
		<div class="row">
			<div class="col-12">
				<div id="copyright">
					<ul class="menu">
						<li>&copy; 태버지 주식회사</li>
						<li>Design: <a href="./ty.html">태버지와 아이들</a></li>
					</ul>
				</div>
			</div>
		</div>
		</footer>
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
