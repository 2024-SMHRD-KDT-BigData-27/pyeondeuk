let page = 1;  // 초기 페이지 번호


$(document).ready(function() {
    loadProducts(page);  // 첫 번째 페이지 데이터 로드

    // '더보기' 버튼 클릭 시
    $("#btn_more_cu").click(function() {
        page++;  // 페이지 번호 증가
        loadProducts(page);  // 다음 페이지 데이터 로드
    });
});

function loadProducts(page) {
    $.ajax({
        url: 'loadMoreProducts.jsp',  // AJAX 요청을 처리할 JSP 파일
        type: 'GET',
        data: { storeId: storeId, page: page },  // storeId와 페이지 번호를 서버로 전달
        success: function(response) {
            $("#product-container").append(response);  // 응답으로 받은 HTML 추가
        },
        error: function() {
            alert('상품을 불러오는 데 실패했습니다.');
        }
    });
}


let page2p1 = 1; // 2+1 초기 페이지 번호

$(document).ready(function() {
    loadProducts2p1(page2p1); // 첫 번째 페이지 데이터 로드

    // '더보기' 버튼 클릭 시
    $("#btn_more_2p1_cu").click(function() {
        page2p1++; // 페이지 번호 증가
        loadProducts2p1(page2p1); // 다음 페이지 데이터 로드
    });
});

function loadProducts2p1(page2p1) {
    $.ajax({
        url: 'loadMoreProducts_2p1.jsp', // AJAX 요청을 처리할 JSP 파일
        type: 'GET',
        data: { storeId: storeId, page: page2p1 }, // storeId와 페이지 번호를 서버로 전달
		success: function(response) {
		    console.log("응답 HTML:", response); // 응답 확인
		    $("#product-2+1-container").append(response);
		    console.log("DOM 업데이트 완료");
		}
,
        error: function() {
            alert('2+1 상품을 불러오는 데 실패했습니다.');
        }
    });
}

