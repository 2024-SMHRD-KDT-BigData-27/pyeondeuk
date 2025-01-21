<%@ page import="com.pyeondeuk.model.ProductDAO"%>
<%@ page import="com.pyeondeuk.model.ProductDTO"%>
<%@ page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%
String storeIdParam = request.getParameter("storeId");
String pagePBParam = request.getParameter("pagePB");
String brand = "";

// 필수 파라미터 검증
if (storeIdParam == null || pagePBParam == null) {
    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
    out.println("필수 파라미터가 없습니다.");
    return;
}

int storeId, pagePB;
try {
    storeId = Integer.parseInt(storeIdParam);
    pagePB = Integer.parseInt(pagePBParam);
} catch (NumberFormatException e) {
    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
    out.println("잘못된 파라미터 형식입니다.");
    return;
}

// storeId 및 페이징 계산
storeId -= 4; // PB 상품용 storeId 계산
int pageSize = 20;
int offset = (pagePB - 1) * pageSize;

// DAO 호출 및 데이터 가져오기
ProductDAO dao = new ProductDAO();
List<ProductDTO> pbProducts;
try {
    pbProducts = dao.getPBProducts(storeId, offset, pageSize);
} catch (Exception e) {
    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    out.println("DB 처리 중 오류가 발생했습니다: " + e.getMessage());
    e.printStackTrace();
    return;
}

// 결과 출력
if (pbProducts == null || pbProducts.isEmpty()) {
%>
<div id="noDataMessage">
    <p>현재 이마트 PB 상품은 준비 중입니다. 다른 매장을 확인해보세요!</p>
</div>
<script>
    document.getElementById('btn_more_pb').style.display = 'none';
</script>
<%
    return;
}

for (ProductDTO product : pbProducts) {
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
        <a href="./price-chart?prodSeq=<%=product.getPROD_SEQ()%>" class="image featured">
            <img src="<%=product.getPROD_IMG()%>" alt="상품 이미지">
        </a>
        <div class="inner">
            <header>
                <h1 style="text-align: center;"><%=product.getPROD_NAME()%></h1>
                <h2 style="text-align: center;"><%=product.getPROD_PRICE()%>원</h2>
                <p style="text-align: center;"><%=brand%></p>
            </header>
        </div>
    </section>
</div>
<%
}
%>
