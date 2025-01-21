<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@page import="com.pyeondeuk.model.ProductDTO"%>
<%@page import="com.pyeondeuk.model.ProductDAO"%>

<!DOCTYPE html>
<html lang="ko">
<%
ProductDAO dao = new ProductDAO();

String PROD_SEQ = request.getParameter("prodSeq");
int PROD_num = Integer.parseInt(PROD_SEQ);
ProductDTO dto = dao.products_calling(PROD_num);
%>
<%
int brandProdSeq = Integer.parseInt(dto.getBRAND_SEQ());
%>
<%
String brandName = "";

switch (brandProdSeq) {
	case 1 :
		brandName = "이마트24";
		break;
	case 2 :
		brandName = "CU";
		break;
	case 3 :
		brandName = "GS25";
		break;
	case 4 :
		brandName = "세븐일레븐";
		break;
	default :
		brandName = "알 수 없는 브랜드";
		break;
}
%>
<%
double unitPrice = Double.parseDouble(dto.getUNIT_PRICE()); // 개당 가격 값
java.text.DecimalFormat df = new java.text.DecimalFormat("#.##"); // 소수점 2자리 제한
String formattedPrice = df.format(unitPrice); // 포맷된 값
%>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>상품 상세 페이지</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<link rel="stylesheet" href="resources/css/page_2.css">
<link rel="stylesheet" href="resources/css/page.css">
<style>
/* 모달 중앙 정렬을 위한 스타일 */
.modal-content {
	margin: 350px;
	margin-left: 700px;
	text-align: center;
}

.modal .close {
	position: absolute;
	top: 10px;
	right: 10px;
	cursor: pointer;
	font-size: 20px;
}

.modal button {
	margin-top: 10px;
	padding: 10px 20px;
	background-color: #444444;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

.modal button:hover {
	background-color: #696969;
}

#chartTitle {
	margin : 50px;
	padding: 30px;
	font-size: 23px;
}

</style>
</head>
<body>
	<div id="header-wrapper">
		<header id="header" class="container">

			<!-- Logo -->
			<div id="logo">

				<a href="index.jsp"><img src="resources/images/logo.png"
					width="200px"></a>

			</div>

			<!-- Nav -->
			<nav id="nav">
				<ul>
					<li class="current"><a href="index.jsp">메인페이지</a></li>
					<li><a href="#">할인상품</a>
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

					<li><a href="#">PB상품</a>
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

					<li><a href="event.html">이벤트</a></li>

					<li><a href="map.jsp">편의점찾기</a></li>
					<li><a href="login.jsp">로그인</a></li>

				</ul>
				</li>

				</ul>
			</nav>

		</header>
	</div>

	<br>
	<!-- 플러스 상품 시작  -->
	<h1 style="text-align: center;">2025년 1월 할인상품을 만나보세요 !</h1>

	<form action="https://www.google.com/search" method="get">
		<input type="text" id="search" placeholder=" 찾으시는 상품명을 입력해주세요. "
			required>
		<button type="submit" id="button">검색</button>
	</form>
	<br>
	<p style="text-align: center;">일부 점포는 행사에서 제외될 수 있으며, 행사상품 이미지는 실제와
		다를 수 있습니다.</p>
	<div class="product-page">
		<!-- 상품 정보 -->

		<div class="product-container">
			<div class="product-image-container">
				<img src="<%=dto.getPROD_IMG()%>" alt="상품 이미지"
					class="product-image">
				<div class="badge"><%=dto.getPROD_CATEGORY()%></div>
			</div>
			<div class="product-details">
				<h2><%=dto.getPROD_NAME()%></h2>
				<p class="price">
					<%=dto.getPROD_PRICE()%>
					<span class="discount">개당 <%=formattedPrice%> 원
					</span>
				</p>

				<div class="store-tag"><%=brandName%></div>
			</div>
		</div>

		<!-- 공유 및 위치 버튼 -->
		<div class="actions">
			<button class="action-button share" onclick="showShareLink()">공유하기</button>
			<a href="map.jsp"><button class="action-button location">위치보기</button></a>
		</div>

		<!-- 공유 링크 표시 모달 -->
		<div id="shareModal" class="modal" style="display: none;">
			<div class="modal-content">
				<span class="close" onclick="closeShareLink()">&times;</span>
				<p>아래 링크를 복사하여 공유하세요</p>
				<input type="text" id="shareLink" value="" readonly>
				<button onclick="copyShareLink()">링크 복사</button>
			</div>
		</div>
		<span id=chartTitle>가격 변화 그래프</span>



		<canvas id="priceChart" width="800" height="400"></canvas>
		<script>
            // JSP 데이터를 JSON으로 변환
            const price = {
                price_2024_07: ${price.price_2024_07},
                price_2024_08: ${price.price_2024_08},
                price_2024_09: ${price.price_2024_09},
                price_2024_10: ${price.price_2024_10},
                price_2024_11: ${price.price_2024_11},
                price_2024_12: ${price.price_2024_12},
                price_2025_01: ${price.price_2025_01}
            };

            console.log("Price Data:", price);

            if (price) {
                const ctx = document.getElementById('priceChart').getContext('2d');
                new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: ["2024_07", "2024_08", "2024_09", "2024_10", "2024_11", "2024_12", "2025_01"],
                        datasets: [{
                            data: [
                                price.price_2024_07,
                                price.price_2024_08,
                                price.price_2024_09,
                                price.price_2024_10,
                                price.price_2024_11,
                                price.price_2024_12,
                                price.price_2025_01
                            ],
                            borderColor: 'rgba(75, 192, 192, 1)',
                            borderWidth: 3.9,
                            fill: false
                        }]
                    },
                    options: {
                        responsive: true,
                        plugins: {
                            legend: {
                                display: false // 범례 제거
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });
            } else {
                console.error("가격 데이터를 불러오지 못했습니다.");
            }
            
            function showShareLink() {
                // 현재 페이지 URL 가져오기
                const currentUrl = window.location.href;

                // 공유 모달 표시
                const shareModal = document.getElementById('shareModal');
                shareModal.style.display = 'block';

                // 공유 링크에 현재 페이지 URL 삽입
                const shareLinkInput = document.getElementById('shareLink');
                shareLinkInput.value = currentUrl;
             }

             function closeShareLink() {
                // 공유 모달 닫기
                const shareModal = document.getElementById('shareModal');
                shareModal.style.display = 'none';
             }

             function copyShareLink() {
                // 공유 링크 복사
                const shareLinkInput = document.getElementById('shareLink');
                shareLinkInput.select();
                document.execCommand('copy');

                // 복사 완료 알림
                alert('링크가 복사되었습니다: ' + shareLinkInput.value);
             }
             </script>

		<!-- Footer -->
		<div id="footer-wrapper">
			<footer id="footer" class="container">
				<div class="row">
					<!-- Contact -->
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
	<script src="./script.js"></script>
</body>

</html>
