<%@page import="com.pyeondeuk.model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>편의점 지도</title>
<link rel="stylesheet" href="resources/css/main3.css" />
<link rel="stylesheet" href="resources/css/font.css" />
<script
	src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=818db477dcf4c15dd62010e4fcb787b6&autoload=false"></script>
<style>
@font-face {
	font-family: 'Ownglyph_ryuttung-Rg';
	src:
		url('https://fastly.jsdelivr.net/gh/projectnoonnu/2405-2@1.0/Ownglyph_ryuttung-Rg.woff2')
		format('woff2');
	font-weight: normal;
	font-style: normal;
}

#nickname {
	font-family: 'Ownglyph_ryuttung-Rg', sans-serif;
	font-size: 23px;
	color: #942b8f;
	font-weight: 575;
	margin: 0;
	padding: 5px;
	display: inline-block;
	text-align: center;
	line-height: 1.
}

#tag {
	color: #4d8bc9;
}

#map {
	width: 100%;
	height: 600px;
}

.custom-overlay {
	background-color: rgba(255, 255, 255, 0.7);
	backdrop-filter: blur(5px);
	padding: 13px 20px;
	border-radius: 8px;
	text-align: center;
	box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
	font-size: 14px;
	color: #4e555b;
}

#star {
	height: 20px;
	margin: 0;
}

.custom-overlay b {
	display: block;
	font-size: 17px;
	margin: 0px;
}

.custom-overlay p {
	margin: 2px 0;
	line-height: 1.45
}

.custom-overlay .custom-button {
	margin-top: 6px;
	background-color: #6c757d;
	color: #fff;
	border: none;
	padding: 4px 10px;
	border-radius: 4px;
	font-size: 12px;
	cursor: pointer;
	transition: background-color 0.3s, box-shadow 0.3s;
}

.custom-overlay .custom-button:hover {
	background-color: #5a6268;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.custom-overlay .custom-button:active {
	background-color: #4e555b;
}

#loading {
	position: absolute;
	top: 300px;
	left: 50%;
	transform: translateX(-50%);
	background: rgba(0, 0, 0, 0.7);
	color: white;
	padding: 5px 10px;
	border-radius: 5px;
	display: none;
	z-index: 1000;
}
</style>
</head>
<body>
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
				%>


				<!-- Nav -->
				<nav id="nav">
					<ul>
						<li class="current"><a href="index.jsp" style="color:#696969; background-color:transparent;">메인페이지</a></li>
						<li><a href="#">할인상품</a>
							<ul>
								<li><a href="store.jsp?storeId=1"><img
										src="resources/images/emart.png" width="70px"></a></li>
								<li><a href=store.jsp?storeId=2><img
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

						<li><a href="event.jsp">이벤트</a></li>
						<li><a href="map.jsp" style="background-color: #444; color: white;">편의점찾기</a></li>
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

		<br>
		<div id="loading">로딩 중...</div>
		<div id="map"></div>

		<script>
	       // 상세보기 페이지로 이동하는 함수
        function redirectToPage(csSeq, csName, csNick, csTag, roadAddressName, addressName, rating) {
            console.log('redirectToPage 호출됨:', { csSeq, csName, csNick, csTag, roadAddressName, addressName, rating });

            csNick = csNick;
            csTag = csTag;
            roadAddressName = roadAddressName;
            addressName = addressName;
            rating = rating;

            const url = `review.jsp?csSeq=${csSeq}&csName=${encodeURIComponent(csName)}&csNick=${encodeURIComponent(csNick)}&csTag=${encodeURIComponent(csTag)}&roadAddressName=${encodeURIComponent(roadAddressName)}&addressName=${encodeURIComponent(addressName)}&rating=${rating}`;
            console.log('생성된 URL:', url);

            window.location.href = url;
        }

        kakao.maps.load(function () {
            var mapContainer = document.getElementById('map');
            var defaultLat = 35.1595; // 기본 위도
            var defaultLng = 126.8526; // 기본 경도

            var mapOption = {
                center: new kakao.maps.LatLng(defaultLat, defaultLng), // 기본 중심 좌표
                level: 3 // 확대 수준
            };

            var map = new kakao.maps.Map(mapContainer, mapOption);
            var markers = []; // 기존 마커를 관리할 배열
         

            var markerImages = {
                1: "./resources/images/emart24_marker.png",
                2: "./resources/images/cu_marker.png",
                3: "./resources/images/gs25_marker.png",
                4: "./resources/images/seven_marker.png"
            };

            function loadStores(lat, lng) {
                document.getElementById('loading').style.display = 'block';

                fetch(`<%=request.getContextPath()%>/getNearbyStores?latitude=` + lat + `&longitude=` + lng + `&radius=0.7`)
                    .then(response => response.json())
                    .then(data => {
                        document.getElementById('loading').style.display = 'none';
                        markers.forEach(marker => marker.setMap(null));
                        markers = [];
                        var overlays = [];

                        data.forEach(store => {
                        	 var rating = store.rating || 0; // 기본값 0
                        	    var starImage;

                        	    // 별점 이미지 결정
                        	    if (rating >= 4.5) starImage = './resources/images/5star.png';
                        	    else if (rating >= 3.5) starImage = './resources/images/4star.png';
                        	    else if (rating >= 2.5) starImage = './resources/images/3star.png';
                        	    else if (rating >= 1.5) starImage = './resources/images/2star.png';
                        	    else starImage = './resources/images/1star.png';

                        	    var markerImageUrl = markerImages[store.brandSeq];
                        	    var markerImage = new kakao.maps.MarkerImage(
                        	        markerImageUrl,
                        	        new kakao.maps.Size(38, 50)
                        	    );
                          
                            var marker = new kakao.maps.Marker({
                                map: map,
                                position: new kakao.maps.LatLng(store.latitude, store.longitude),
                                image: markerImage
                            });

                            var overlayContent = document.createElement('div');
                            overlayContent.className = 'custom-overlay';

                            overlayContent.innerHTML = `
                                <b>${store.csName}</b>
                                <img id="star" src="${starImage}" alt="별점"><br>
                                <span id="nickname">' ${store.csNick || '리뷰가 없어요 ㅠ'} '</span><br>
                                ${store.csTag ? `<span id="tag">${store.csTag}</span><br>` : ''}
                                <p>${store.roadAddressName ? `도로명주소: ${store.roadAddressName}<br>` : ''}
                                ${store.addressName ? `지번주소: ${store.addressName}` : ''}
                                </p>
                            `;

                            var button = document.createElement('button');
                            button.className = 'custom-button';
                            button.innerText = '상세보기';

                            button.addEventListener('click', function (event) {
                                console.log('상세보기 버튼 클릭됨');

                                const url = `review.jsp?csSeq=${store.csSeq}&csName=${encodeURIComponent(store.csName)}&csNick=${encodeURIComponent(store.csNick || '')}&csTag=${encodeURIComponent(store.csTag || '')}&roadAddressName=${encodeURIComponent(store.roadAddressName || '')}&addressName=${encodeURIComponent(store.addressName || '')}&rating=${store.rating || 0}`;
                                
                                window.open(url, '_blank');
                            });
                            overlayContent.appendChild(button);

                            var overlay = new kakao.maps.CustomOverlay({
                                content: overlayContent,
                                position: marker.getPosition(),
                                clickable: true,
                                yAnchor: 1.25,
                                map: null
                            });

                            // 지도 클릭 시 오버레이 닫기
                            kakao.maps.event.addListener(map, 'click', function () {
                                overlay.setMap(null);
                            });

                            // 마커 클릭 시 기존 오버레이 제거 후 새 오버레이 표시
                            kakao.maps.event.addListener(marker, 'click', function () {
                                console.log("Marker clicked:", store.csName); // 디버깅 로그
                                overlays.forEach(activeOverlay => activeOverlay.setMap(null)); // 기존 오버레이 제거
                                overlays = []; // 배열 초기화

                                overlay.setMap(map); // 새 오버레이 표시
                                overlays.push(overlay); // 활성화된 오버레이 배열에 추가
                            });

                            markers.push(marker);
                        });
                    })
                    .catch(error => {
                        document.getElementById('loading').style.display = 'none';
                        console.error('Error loading stores:', error);
                    });
            }

            // GPS 기반 중심 좌표 가져오기
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function (position) {
                    var lat = position.coords.latitude;
                    var lng = position.coords.longitude;

                    var gpsCenter = new kakao.maps.LatLng(lat, lng);
                    map.setCenter(gpsCenter);

                    loadStores(lat, lng); // GPS 좌표 기반으로 상점 불러오기
                }, function (error) {
                    console.warn('GPS 정보를 가져올 수 없습니다. 기본 위치로 설정합니다.');
                    loadStores(defaultLat, defaultLng);
                });
            } else {
                console.warn('GPS를 지원하지 않는 브라우저입니다. 기본 위치로 설정합니다.');
                loadStores(defaultLat, defaultLng);
            }

            kakao.maps.event.addListener(map, 'idle', function () {
                var center = map.getCenter();
                loadStores(center.getLat(), center.getLng());
            });
        });
</script>



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
