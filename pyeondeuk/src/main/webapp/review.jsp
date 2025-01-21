<%@page import="com.pyeondeuk.model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<link rel="stylesheet" href="resources/css/review.css">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>리뷰 작성</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/d3-cloud@1.2.5/build/d3.layout.cloud.min.js"></script>
<script src="https://d3js.org/d3.v6.min.js"></script>
<style>
@font-face {
	font-family: 'Ownglyph_ryuttung-Rg';
	src:
		url('https://fastly.jsdelivr.net/gh/projectnoonnu/2405-2@1.0/Ownglyph_ryuttung-Rg.woff2')
		format('woff2');
	font-weight: normal;
	font-style: normal;
}

#csNick {
    font-family: 'Ownglyph_ryuttung-Rg', sans-serif; 
    font-size: 39px; 
    color: #942b8f;
    font-weight: 575;
}

.store-info {
	text-align: center;
	background-color: #ffffff;
	border-radius: 10px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	padding: 20px;
	margin: 20px auto;
	width: 960px;
}

.store-info h3 {
	color: #343a40;
	font-size: 30px;
	font-weight: bold;
	margin-bottom: 15px;
}

.store-info p {
	margin: 10px 0;
	font-size: 18px;
	color: #495057;
}

.store-info span {
	font-weight: bold;
	color: #4d8bc9;

}

.store-info img {
	display: block;
	margin: 30px auto;
	height: 28px;
}

#averageRatingImage {
	display: block;
}

#word-cloud {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 300px; /* 워드클라우드 영역의 높이 */
    width: 100%; /* 화면 가로 중앙 */
    text-align: center;
    margin: auto;
}

</style>
</head>

<body>
	<%
	// 세션과 URL 파라미터 가져오기
	MemberDTO info = (MemberDTO) session.getAttribute("info");
	String email = (info != null) ? info.getEmail() : "";
	String csSeq = request.getParameter("csSeq");
	String csName = request.getParameter("csName");
	String csNick = request.getParameter("csNick");
	String csTag = request.getParameter("csTag");
	String roadAddressName = request.getParameter("roadAddressName");
	String addressName = request.getParameter("addressName");
	String rating = request.getParameter("rating");
	System.out.println("csSeq in JSP: " + csSeq);
	%>

	<script>
    $(document).ready(function () {
        const email = "<%=email%>";
        const csSeq = "<%=csSeq != null ? csSeq : ""%>";

        console.log(csSeq);
        // 별점 이미지를 설정하는 함수
        function getStarImage(rating) {
            let starImage = '';
            if (rating >= 4.5) starImage = './resources/images/5star.png';
            else if (rating >= 3.5) starImage = './resources/images/4star.png';
            else if (rating >= 2.5) starImage = './resources/images/3star.png';
            else if (rating >= 1.5) starImage = './resources/images/2star.png';
            else starImage = './resources/images/1star.png';
            return starImage;
        }

        // 별점 클릭 이벤트
        let selectedRating = 0;
        $('.star_rating > .star').click(function () {
            $('.star_rating > .star').removeClass('on');
            $(this).addClass('on').prevAll('.star').addClass('on');
            selectedRating = $(this).data('value');
            console.log("선택된 별점 값:", selectedRating);
        });

        // 리뷰 등록 버튼 클릭 이벤트
        $('.btn02').on('click', function () {
            if (!email) {
                alert("로그인이 필요합니다. 로그인 페이지로 이동합니다.");
                window.location.href = 'login.jsp';
                return;
            }

            const commentContent = $('.star_box').val().trim();

            if (!commentContent) {
                alert("리뷰 내용을 작성해주세요.");
                return;
            }

            if (selectedRating === 0) {
                alert("별점을 선택해주세요.");
                return;
            }

            // AJAX 요청으로 리뷰 등록
            $.ajax({
                type: "POST",
                url: "/pyeondeuk/submitReview",
                data: {
                    csSeq: csSeq,
                    email: email,
                    commentContent: commentContent,
                    rating: selectedRating
                },
                success: function (response) {
                    if (response.success) {
                        alert("리뷰가 성공적으로 등록되었습니다.");
                        $('.star_box').val(''); // 리뷰 입력 내용 초기화
                        $('.star_rating > .star').removeClass('on'); // 별점 초기화
                        selectedRating = 0;
                        loadReviews(csSeq);
                    } else {
                        alert("리뷰 등록에 실패했습니다.");
                    }
                },
                error: function () {
                    alert("리뷰 등록 중 오류가 발생했습니다.");
                }
            });
        });

     // 리뷰 목록 불러오기 및 워드 클라우드 생성
        function loadReviews(csSeq) {
            $.ajax({
                type: "GET",
                url: "/pyeondeuk/fetchReviews",
                data: { csSeq: csSeq },
                success: function (reviews) {
                    const reviewList = $('#reviewList');
                    reviewList.empty();

                    const wordCounts = {};
                    reviews.forEach(review => {
                        const words = review.commentContent ? review.commentContent.split(/\s+/) : [];
                        words.forEach(word => {
                            const trimmedWord = word.trim().toLowerCase();
                            if (trimmedWord.length > 1) {
                                wordCounts[trimmedWord] = (wordCounts[trimmedWord] || 0) + 1;
                            }
                        });

                        const reviewItem = 
                            `<li>
                                <div class="nick">${review.nick}</div>
                                <div class="rating">${'★'.repeat(review.rating)}</div>
                                <div class="review-content">${review.commentContent}</div>
                                <div class="created-at">작성일: ${review.createdAt}</div>
                            </li>`;
                        reviewList.append(reviewItem);
                    });

                    // 워드 클라우드 생성
                    createWordCloud(wordCounts);

                    // 평균 별점 이미지 설정
                    const averageRating = parseFloat("<%=rating != null ? rating : "0"%>");
                    const starImage = getStarImage(averageRating);
                    $('#averageRatingImage').attr('src', starImage);
                },
                error: function () {
                    alert("리뷰 목록을 가져오는 데 실패했습니다.");
                }
            });
        }

        // 워드 클라우드 생성 함수
   function createWordCloud(wordCounts) {
    const data = Object.keys(wordCounts).map(word => ({
        text: word,
        size: Math.max(Math.min(wordCounts[word] * 10, 120), 5) // 최소 크기 10, 최대 크기 100
    }));

    console.log("워드 클라우드 데이터 준비 완료:", data);

    const width = document.getElementById("wordCloud").offsetWidth;
    const height = document.getElementById("wordCloud").offsetHeight;

    if (width === 0 || height === 0) {
        console.error("WordCloud 요소 크기 오류: 크기를 확인하세요.");
        return;
    }

    const layout = d3.layout.cloud()
        .size([width, height])
        .words(data)
        .padding(5)
        .rotate(() => ~~(Math.random() * 2) * 90)
        .fontSize(d => d.size)
        .on("end", draw)
        .on("word", word => console.log("단어 추가됨:", word));

    layout.start();

    function draw(words) {
        console.log("워드 클라우드 렌더링 시작...");
        d3.select("#wordCloud")
        .html("") // 기존 내용 제거
        .append("svg")
        .attr("width", width)
        .attr("height", height)
        .append("g")
        .attr("transform", `translate(${width / 2},${height / 2})`) 
        .selectAll("text")
        .data(words)
        .enter().append("text")
        .style("font-size", d => `${d.size}px`) 
        .style("fill", () => `hsl(${Math.random() * 360},100%,50%)`)
        .attr("text-anchor", "middle")
        .attr("transform", d => `translate(${d.x},${d.y})rotate(${d.rotate})`) 
        .text(d => d.text);
    }
}
        // 페이지 로드 시 리뷰 목록 불러오기 및 워드 클라우드 생성
        loadReviews(csSeq);

        console.log(typeof $);
    });
</script>

	<div class="store-info">
		<h3><%=csName != null ? csName : "알 수 없는 편의점"%></h3>
		<img id="averageRatingImage" src="" alt="별점 이미지">
		<p>
			<span id = 'csNick'>' <%=csNick != "" ? csNick : "별명 없음"%> '
			</span>
		</p>
		<p>
			<span><%=csTag != "" ? csTag : "태그 없음"%></span>
		</p>
		<p>
			도로명 주소: <%=roadAddressName != null ? roadAddressName : "도로명 주소 없음"%>
		</p>
		<p>
			지번 주소: <%=addressName != null ? addressName : "주소 없음"%>
		</p>

	</div>

	<div class="star_rating">
		<span class="star" data-value="1"></span> <span class="star"
			data-value="2"></span> <span class="star" data-value="3"></span> <span
			class="star" data-value="4"></span> <span class="star" data-value="5"></span>
	</div>

	<textarea class="star_box" placeholder="해당 편의점에 대한 리뷰 내용을 작성해주세요."></textarea>
	<input type="submit" class="btn02" value="리뷰 등록" style="color: white;" />

	<div id="wordCloud" style="width: 100%; height: 300px;"></div>

	<div id="reviewDisplay">
		<h4 style="text-align: center;">작성된 리뷰</h4>
		<ul id="reviewList"></ul>
	</div>

</body>

</html>
