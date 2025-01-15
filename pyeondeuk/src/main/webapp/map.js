// 지도 생성
var mapContainer = document.getElementById('map');
var mapOption = {
    center: new kakao.maps.LatLng(37.5665, 126.9780), // 초기 좌표 (서울)
    level: 3
};
var map = new kakao.maps.Map(mapContainer, mapOption);

// 편의점 데이터
var stores = [
    { name: 'CU 서울역점', lat: 37.5550, lng: 126.9691 },
    { name: 'GS25 강남점', lat: 37.4979, lng: 127.0276 },
    { name: '7-Eleven 홍대점', lat: 37.5558, lng: 126.9237 }
];

// 편의점 리뷰 데이터
var reviews = {};

// 모달 요소
var modal = document.getElementById('review-modal');
var overlay = document.getElementById('overlay');
var storeNameElement = document.getElementById('store-name');
var reviewInput = document.getElementById('review-input');
var tagsContainer = document.getElementById('tags-container');
var nicknameElement = document.getElementById('nickname');

// 마커 생성 및 클릭 이벤트
stores.forEach(store => {
    var marker = new kakao.maps.Marker({
        map: map,
        position: new kakao.maps.LatLng(store.lat, store.lng),
        title: store.name
    });

    kakao.maps.event.addListener(marker, 'click', function () {
        openModal(store.name);
    });
});

// 모달 열기
function openModal(storeName) {
    storeNameElement.innerText = storeName;
    reviewInput.value = '';
    tagsContainer.innerHTML = '';
    nicknameElement.innerText = '';
    modal.style.display = 'block';
    overlay.style.display = 'block';
}

// 모달 닫기
document.getElementById('close-modal').addEventListener('click', function () {
    modal.style.display = 'none';
    overlay.style.display = 'none';
});

// 리뷰 제출
document.getElementById('submit-review').addEventListener('click', function () {
    var storeName = storeNameElement.innerText;
    var reviewText = reviewInput.value.trim();

    if (reviewText === '') {
        alert('리뷰를 입력하세요!');
        return;
    }

    // 리뷰 저장
    if (!reviews[storeName]) {
        reviews[storeName] = [];
    }
    reviews[storeName].push(reviewText);

    // 리뷰 기반 태그 및 별명 생성
    generateTagsAndNickname(storeName);

    // 모달 닫기
    modal.style.display = 'none';
    overlay.style.display = 'none';
});

function generateTagsAndNickname(storeName) {
    var storeReviews = reviews[storeName];
    var wordCount = {};

    // 단어 빈도수 계산
    storeReviews.forEach(review => {
        review.split(' ').forEach(word => {
            wordCount[word] = (wordCount[word] || 0) + 1;
        });
    });

    // 태그 생성
    tagsContainer.innerHTML = '';
    Object.keys(wordCount).forEach(word => {
        var tag = document.createElement('span');
        tag.innerText = `#${word}`;
        tagsContainer.appendChild(tag);
    });

    // 별명 생성
    var mostFrequentWords = Object.keys(wordCount)
        .sort((a, b) => wordCount[b] - wordCount[a])
        .slice(0, 2); // 상위 2개의 단어
    nicknameElement.innerText = `별명: ${storeName} (${mostFrequentWords.join(', ')})`;
}
/**
 * 
 */