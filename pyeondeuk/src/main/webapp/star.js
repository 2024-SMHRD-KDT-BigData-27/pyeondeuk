$(document).ready(function () {
    let selectedRating = 0;

    // 별점 클릭 이벤트
	$('.star_rating > .star').click(function () {
	    $('.star_rating > .star').removeClass('on selected'); // 기존 선택 제거
	    $(this).addClass('on selected').prevAll('.star').addClass('on'); // 선택 및 이전 별들 활성화
	    selectedRating = $(this).data('value'); // 선택된 별점 값 저장
	    console.log("선택된 별점 값:", selectedRating); // 디버깅 로그
	});


    // 리뷰 등록 버튼 클릭 이벤트
    $('#submitReview').click(function () {
        const reviewContent = $('#reviewInput').val().trim(); // 리뷰 내용
        const storeName = "서울 강남구 XX 편의점"; // 지점명 고정 값

        // 리뷰나 별점이 입력되지 않았을 때 경고
        if (!reviewContent) {
            alert('리뷰 내용을 작성해주세요.');
            return;
        }
        if (selectedRating === 0) {
            alert('별점을 선택해주세요.');
            return;
        }

        // 작성된 리뷰를 화면에 추가
        const newReview = `
            <li>
                <div class="store-name">${storeName}</div>
                <div class="rating">별점: ${'★'.repeat(selectedRating)}</div>
                <div class="review-content">${reviewContent}</div>
            </li>
        `;
        $('#reviewList').append(newReview); // 리뷰 목록에 추가

        // 입력 필드 초기화
        $('#reviewInput').val('');
        $('.star_rating > .star').removeClass('on');
        selectedRating = 0;
    });
});
$(document).ready(function () {
	$(".btn02").on("click", function () {
	    const csSeq = 1; // 지점 번호 (임시 값)
	    const email = "test@example.com"; // 이메일 (임시 값)
	    const commentContent = $(".star_box").val(); // 리뷰 내용
	    const rating = $(".star_rating .selected").data("value"); // 선택된 별점 값

	    // 별점과 리뷰 내용 유효성 검사
	    if (!commentContent) {
	        alert("리뷰 내용을 작성해주세요.");
	        return;
	    }
	    if (!rating) {
	        alert("별점을 선택해주세요.");
	        return;
	    }

	    // 디버깅 로그로 값 확인
	    console.log("csSeq 값:", csSeq);
	    console.log("email 값:", email);
	    console.log("리뷰 내용:", commentContent);
	    console.log("별점 값:", rating);

	    // AJAX 요청
	    $.ajax({
	        type: "POST",
	        url: "/pyeondeuk/submitReview",
	        data: {
	            csSeq: csSeq,
	            email: email,
	            commentContent: commentContent,
	            rating: rating
	        },
	        success: function (response) {
	            if (response.success) {
	                alert("리뷰가 성공적으로 등록되었습니다.");
					loadReviews(csSeq); // 리뷰 목록 새로고침
	            } else {
	                alert("리뷰 등록에 실패했습니다.");
	                console.error("서버 응답:", response);
	            }
	        },
	        error: function (jqXHR, textStatus, errorThrown) {
	            alert("에러가 발생했습니다.");
	            console.error("AJAX 에러:", textStatus, errorThrown);
	            console.error("응답:", jqXHR.responseText);
	        }
	    });
	});
	
	// 리뷰 목록 불러오기
	function loadReviews() {
		if (!csSeq) {
		       console.error("csSeq 값이 정의되지 않았습니다."); // 디버깅 로그
		       return;
		   }
		   console.log("AJAX 요청 시작. csSeq:", csSeq); // 디버깅 로그
	    $.ajax({
	        type: "GET",
	        url: "/pyeondeuk/fetchReviews", // 리뷰 가져오기 URL
			data: { csSeq: csSeq }, // 요청 시 csSeq 값을 전달
	        success: function (reviews) {
				console.log("리뷰 데이터:", reviews); // 디버깅
	            const reviewList = $('#reviewList');
	            reviewList.empty(); // 기존 리뷰 제거

	            reviews.forEach(review => {
	                const reviewItem = `
	                    <li>
	                    
	                        <div class="nick">닉네임: ${review.nick}</div>
	                        <div class="rating">별점: ${'★'.repeat(review.rating)}</div>
	                        <div class="review-content">${review.commentContent}</div>
	                        <div class="created-at">작성일: ${review.createdAt}</div>
	                    </li>
	                `;
	                reviewList.append(reviewItem);
	            });
	        },
			error: function (jqXHR, textStatus, errorThrown) {
			            console.error("AJAX 요청 실패:", textStatus, errorThrown); // 디버깅용
			            alert("리뷰 목록을 가져오는 데 실패했습니다.");
	        }
	    });
	}

	// 페이지 로드 시 리뷰 목록 로드
	
	    const csSeq = 606;
		loadReviews(csSeq);


});

