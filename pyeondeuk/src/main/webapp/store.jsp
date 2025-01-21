<%@page import="com.pyeondeuk.model.MemberDTO"%>
<%@page import="com.pyeondeuk.model.ProductDAO"%>
<%@page import="com.pyeondeuk.model.ProductDTO"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE HTML>

<html lang="ko">
<%
int storeId = Integer.parseInt(request.getParameter("storeId"));
ProductDAO dao = new ProductDAO();
String brandLogo = ""; // brandLogo 변수 선언

switch (storeId) {
    case 1: case 5:
        brandLogo = "emart.png";
        break;
    case 2: case 6:
        brandLogo = "cu.png";
        break;
    case 3: case 7:
        brandLogo = "gs.png";
        break;
    case 4: case 8:
        brandLogo = "seven.png";
        break;
    default:
        brandLogo = "default.png"; // 예외 처리 (필요 시)
        break;
}

System.out.println("브랜드 로고: " + brandLogo);

%>



<head>
<title>편득이</title>
<meta charset="UTF-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="resources/css/cu.css" />
<link rel="stylesheet" href="resources/css/main3.css" />
</head>
<style>
h2 {
	font-size: 35px;
	display: flex;
    justify-content: center;
}

.dropdown {
	width: 100px;
	position: relative;
	display: inline-block;
}

.dropdown select {
	width: 100%;
	padding: 8px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 4px;
	appearance: none;
	-webkit-appearance: none;
	-moz-appearance: none;
	background:
		url('data:image/svg+xml;charset=US-ASCII,<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24"><path fill="%23000" d="M7 10l5 5 5-5z"/></svg>')
		no-repeat right 10px center;
	background-color: #fff;
	background-size: 12px;
	cursor: pointer;
}

/* 드롭다운 옵션 스타일 */
.dropdown select option {
	padding: 8px;
}

#product-2+1-container {
	display: flex;
	flex-wrap: wrap;
	gap: 10px;
}

#product-2+1-container .col-3 {
	display: block; /* 혹은 적절한 flex/grid */
}

/* 선택된 옵션 강조 스타일 */
.dropdown select option:checked {
	background-color: #0066cc;
	color: white;
}

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

<body class="is-preload no-sidebar">
	<div id="page-wrapper">

		<!-- Header -->
		<div id="header-wrapper">
			<header id="header" class="container">

				<!-- Logo -->
				<div id="logo">

					<a href="index.jsp"><img src="resources/images/logo.png"
						width="200px"></a>

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
						<li><a href="event.jsp">이벤트</a></li>
						<li><a href="map.jsp">편의점찾기</a></li>
						<%if(info == null){%>
                  		<li><a href="login.jsp">로그인</a></li>
                  		<%}else{ %>
                     <!-- 로그인 후 Logout.jsp로 이동할 수 있는'로그아웃'링크와 '개인정보수정'링크를 출력하시오. -->
                     <li><a href="LogoutService">로그아웃</a></li>
                     <li><a href="update.jsp">회원정보</a></li>
                  <%} %>
					</ul>
					</li>

					</ul>
				</nav>

			</header>
		</div>

		<!-- Main -->
		<div id="main-wrapper">
			<div class="container">
				<div id="content">

					<!-- Content -->
					<article>

						<h2>
							<img src="resources/images/<%=brandLogo%>" width="150px">
						</h2>



						<article class="s-a"></article>
						<h3>2025년 1월 행사상품</h3>

						<ul
							style="display: flex; list-style-type: none; padding: 0; margin-bottom: 20px; width: 100%;">
							<li style="flex-grow: 1; margin-right: 10px;">
								<div class="dropdown" style="width: 100%; border-radius: 10px;">
									<select id="strEventType" name="strEventType"
										onchange="filterAndSortProducts()"
										style="width: 100%; border-radius: 5px;">
										<option value="">행사 전체</option>
										<option value="1p1">1+1</option>
										<option value="2p1">2+1</option>
									</select>
								</div>
							</li>

							<li style="flex-grow: 1; margin-right: 10px;">
								<div class="dropdown" style="width: 100%; border-radius: 10px;">
									<input type="hidden" id="storeId" name="storeId"
										value="<%=storeId%>"> <select id="strCategory"
										name="strCategory" onchange="filterAndSortProducts()">
										<option value="">카테고리 전체</option>
										<option value="음료">음료</option>
										<option value="간편식사">간편식사</option>
										<option value="과자">과자</option>
										<option value="아이스크림">아이스크림</option>
										<option value="식품">식품</option>
										<option value="생활용품">생활용품</option>
										<option value="기타">기타</option>
									</select>
								</div>
							</li>

							<li style="flex-grow: 1;">
								<div class="dropdown" style="width: 100%; border-radius: 10px;">
									<select id="strSort" name="strSort"
										onchange="filterAndSortProducts()">
										<option value="priceAsc">가격 낮은 순</option>
										<option value="priceDesc">가격 높은 순</option>
										<option value="productNameAsc">상품명 오름차순</option>
										<option value="productNameDesc">상품명 내림차순</option>
									</select>
								</div>
							</li>
						</ul>



						<form action="serchService" method="get">
							<input type="text" id="search" name="search"
								placeholder=" 찾으시는 상품명을 입력해주세요. " required>
							<button type="submit" id="button"
								style="background-color: #696969;">검색</button>
						</form>


					</article>

					<br>

					<div id="product-sections" style="<%=storeId <= 4 ? "" : "display: none;"%>">
						<h2 style="<%=storeId <= 4 ? "" : "display: none;"%>">1+1</h2>
						<br>

						<div id="features-wrapper" style="<%=storeId <= 4 ? "" : "display: none;"%>">
							<div class="container" style="<%=storeId <= 4 ? "" : "display: none;"%>">
								<div class="row" id="product-container" style="<%=storeId <= 4 ? "" : "display: none;"%>">
									<!-- 최초 로딩 시 1번째 페이지의 상품들만 보여줍니다 -->
								</div>
							</div>
						</div>



						<div id="data-container" style="<%=storeId <= 4 ? "" : "display: none;"%>">
							<button class="add" id="btn_more_cu" style="<%=storeId <= 4 ? "" : "display: none;"%> width: 1400px; height:39px; background-color: #444444;">+</button>
						</div>


						<br> <br>
						<h2 style="<%=storeId <= 4 ? "" : "display: none;"%>">2+1</h2>
						<br>

						<div id="features-wrapper" style="<%=storeId <= 4 ? "" : "display: none;"%>">
							<div class="container" style="<%=storeId <= 4 ? "" : "display: none;"%>">
								<div class="row" id="product-2p1-container" style="<%=storeId <= 4 ? "" : "display: none;"%>">
									<!-- 최초 로딩 시 1번째 페이지의 상품들만 보여줍니다 -->
								</div>
							</div>
						</div>

						<div id="data-container" style="<%=storeId <= 4 ? "" : "display: none;"%>">
							<button class="add" id="btn_more_2p1_cu" style="<%=storeId <= 4 ? "" : "display: none;"%> width: 1400px; height:39px; background-color: #444444;">+</button>
						</div>
					</div>

					
				

					<div id="product-sections" style="<%=storeId > 4 ? "" : "display: none;"%>">
						<h2 style="<%=storeId > 4 ? "" : "display: none;"%>">PB 상품</h2>
						<br>
						<div id="features-wrapper" style="<%=storeId > 4 ? "" : "display: none;"%>">
							<div class="container">
								<div class="row" id="pb-product-container"style="<%=storeId > 4 ? "" : "display: none;"%>">
									<!-- PB 상품 리스트 -->
								</div>
							</div>
						</div>

						<div id="data-container" style="<%=storeId > 4 ? "" : "display: none;"%>">
							<button class="add" id="btn_more_pb" style="<%=storeId > 4 ? "" : "display: none;"%> width: 1400px; height: 39px; background-color: #444444;">+</button>
						</div>
					</div>







				</div>
			</div>
		</div>

		<!-- Footer -->
		<div id="footer-wrapper">
			<footer id="footer" class="container">
				<div class="row">
					<!-- Contact -->
					<section class="문의하기">
						<a href="#" class="top-link" style="color: #444444;">맨 위로</a> <br>
						<br> <br>
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

	<!-- Scripts -->

	<script type="text/javascript">
		var storeId =
	<%=storeId%>
		; // JSP에서 storeId를 JavaScript로 전달

		$(document).ready(function() {
			loadProducts(1); // 첫 번째 페이지 데이터 로드

			// 더보기 버튼 클릭 시
			$("#btn_more_cu").click(function() {
				page++; // 페이지 번호 증가
				loadProducts(page); // 페이지에 해당하는 상품을 추가로 로드
			});
		});

		function loadProducts(page) {
			$.ajax({
				url : 'loadMoreProducts.jsp', // AJAX 요청을 처리할 JSP 파일
				type : 'GET',
				data : {
					storeId : storeId,
					page : page
				}, // storeId와 페이지 번호를 서버로 전달
				success : function(response) {
					// 응답으로 받은 HTML을 페이지에 추가
					$("#product-container").append(response);
				},
				error : function() {
					alert('상품을 불러오는 데 실패했습니다.');
				}
			});
		}
	</script>

	<script type="text/javascript">
		$(document).ready(function() {
			loadProducts2p1(1); // 첫 번째 페이지 데이터 로드

			// '더보기' 버튼 클릭 시
			$("#btn_more_2p1_cu").click(function() {
				page2p1++; // 페이지 번호 증가
				loadProducts2p1(page2p1); // 다음 페이지 데이터 로드
			});
		});

		function loadProducts2p1(page) {
			$.ajax({
				url : 'loadMoreProducts_2p1.jsp', // AJAX 요청을 처리할 JSP 파일
				type : 'GET',
				data : {
					storeId : storeId,
					page : page2p1
				}, // storeId와 페이지 번호를 서버로 전달
				success : function(response) {
					$("#product-2p1-container").append(response); // 응답으로 받은 HTML 추가
				},
				error : function() {
					alert('2+1 상품을 불러오는 데 실패했습니다.');
				}
			});
		}
	</script>

	<script type="text/javascript">
		$(document).ready(function() {
			loadPBProducts(1); // 첫 번째 페이지 데이터 로드

			// '더보기' 버튼 클릭 시
			$("#btn_more_2p1_cu").click(function() {
				pagePB++; // 페이지 번호 증가
				loadPBProducts(pagePB); // 다음 페이지 데이터 로드
			});
		});

		function loadPBProducts(page) {
			$.ajax({
				url : 'loadMorePBProducts.jsp', // AJAX 요청을 처리할 JSP 파일
				type : 'GET',
				data : {
					storeId : storeId,
					page : pagePB
				}, // storeId와 페이지 번호를 서버로 전달
				success : function(response) {
					$("#pb-product-container").append(response); // 응답으로 받은 HTML 추가
				},
				error : function() {
					alert('PB 상품을 불러오는 데 실패했습니다.');
				}
			});
		}
	</script>

	<script type="text/javascript">
	function filterProducts() {
        const category = document.getElementById("strCategory").value || "";

        fetch(`/pyeondeuk/orderByService?storeId=${storeId}&strCategory=${category}&page=1`)
            .then(response => response.json())
            .then(data => {
                document.getElementById("product-container").innerHTML = data.onePlusOne;
                document.getElementById("product-2p1-container").innerHTML = data.twoPlusOne;
            })
            .catch(error => console.error("Error:", error));
    }
</script>


	<script type="text/javascript">
	function filterAndSortProducts() {
	    const eventType = document.getElementById("strEventType").value || "";
	    const category = document.getElementById("strCategory").value || "";
	    const sort = document.getElementById("strSort").value || "default";

	    fetch(`/pyeondeuk/orderByService?storeId=${storeId}&strCategory=${category}&strEventType=${eventType}&sort=${sort}&page=1`)
	        .then(response => response.json())
	        .then(data => {
	            // 1+1 및 2+1 상품 목록 갱신
	            document.getElementById("product-container").innerHTML = unescapeJson(data.onePlusOne);
	            document.getElementById("product-2p1-container").innerHTML = unescapeJson(data.twoPlusOne);
	            document.getElementById("pb-product-container").innerHTML = unescapeJson(data.pbProducts);
	            
	            
	        })
	        .catch(error => console.error("Error:", error));
	}

	function unescapeJson(jsonStr) {
	    return jsonStr.replace(/\\n/g, '\n')
	                  .replace(/\\r/g, '\r')
	                  .replace(/\\"/g, '"')
	                  .replace(/\\\\/g, '\\'); // JSON의 백슬래시를 복원
	}

	</script>

	// 드롭다운 변경 시 필터 및 정렬 실행
	document.getElementById("strSort").addEventListener("change",
	filterAndSortProducts);
	document.getElementById("strCategory").addEventListener("change",
	filterAndSortProducts);

	</script>

	<script src="./jquery.min.js"></script>
	<script src="./jquery.dropotron.min.js"></script>
	<script src="./browser.min.js"></script>
	<script src="./breakpoints.min.js"></script>
	<script src="./util.js"></script>
	<script src="./main.js"></script>
	<script src="./script.js"></script>

</body>

</html>