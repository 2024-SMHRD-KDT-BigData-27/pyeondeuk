let page = 1; // 1+1 초기 페이지 번호
let page2p1 = 1; // 2+1 초기 페이지 번호
let pagePB = 1; // PB 초기 페이지 번호

$(document).ready(function() {
    // 현재 storeId 값 확인
    const storeId = getStoreId(); // storeId 가져오기

    // 1+1과 2+1 상품 로드
    if ([1, 2, 3, 4].includes(storeId)) {
        loadProducts(page); // 1+1 상품 첫 번째 페이지 로드
        loadProducts2p1(page2p1); // 2+1 상품 첫 번째 페이지 로드

        // 1+1 더보기 버튼 클릭
        $("#btn_more_cu").click(function() {
            page++;
            loadProducts(page);
        });

        // 2+1 더보기 버튼 클릭
        $("#btn_more_2p1_cu").click(function() {
            page2p1++;
            loadProducts2p1(page2p1);
        });
    }

    // PB 상품 로드
    if ([5, 6, 7, 8].includes(storeId)) {
        loadPBProducts(pagePB); // PB 상품 첫 번째 페이지 로드

        // PB 더보기 버튼 클릭
        $("#btn_more_pb").click(function() {
            pagePB++;
            loadPBProducts(pagePB);
        });
    }
});

// 1+1 상품 로드 함수
function loadProducts(page) {
    $.ajax({
        url: 'loadMoreProducts.jsp',
        type: 'GET',
        data: { storeId: getStoreId(), page: page },
        success: function(response) {
            $("#product-container").append(response); // 응답 HTML 추가
        },
        error: function(xhr, status, error) {
            console.error('1+1 상품 로드 오류:', error);
            alert('상품을 불러오는 데 실패했습니다.');
        }
    });
}

// 2+1 상품 로드 함수
function loadProducts2p1(page2p1) {
    $.ajax({
        url: 'loadMoreProducts_2p1.jsp',
        type: 'GET',
        data: { storeId: getStoreId(), page: page2p1 },
        success: function(response) {
            console.log("응답 HTML:", response); // 응답 확인
            $("#product-2p1-container").append(response);
            console.log("DOM 업데이트 완료");
        },
        error: function(xhr, status, error) {
            console.error('2+1 상품 로드 오류:', error);
            alert('2+1 상품을 불러오는 데 실패했습니다.');
        }
    });
}

// PB 상품 로드 함수
function loadPBProducts(pagePB) {
    $.ajax({
        url: 'loadMorePBProducts.jsp',
        type: 'GET',
        data: { storeId: getStoreId(), pagePB: pagePB },
        success: function(response) {
            console.log("응답 HTML:", response); // 응답 확인
            $("#pb-product-container").append(response);
            console.log("DOM 업데이트 완료");
        },
        error: function(xhr, status, error) {
            console.error('PB 상품 로드 오류:', error);
            alert('PB 상품을 불러오는 데 실패했습니다.');
        }
    });
}

// storeId 가져오는 함수
function getStoreId() {
    const params = new URLSearchParams(window.location.search);
    return parseInt(params.get("storeId"), 10);
}
