<%@page import="java.util.List"%>
<%@ page import="com.pyeondeuk.model.ProductDAO"%>
<%@ page import="com.pyeondeuk.model.ProductDTO"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%
int storeId = Integer.parseInt(request.getParameter("storeId"));
int currentPage = Integer.parseInt(request.getParameter("page"));
int pageSize = 20; // 한 번에 불러올 상품 개수

ProductDAO dao = new ProductDAO();
List<ProductDTO> productList = dao.products_store_calling(storeId, "1+1 상품", currentPage, pageSize);

for (ProductDTO product : productList) {
%>

<div class="col-3">
	<section class="box feature">
		<a href="./page2.html" class="image featured searchImg"
			style="text-decoration: none;"><img
			src="<%=product.getPROD_IMG()%>" class="innerimg"></a>
		<div class="inner">
			<header>
				<h1 style="text-align: center;"><%=product.getPROD_NAME()%></h1>
				<h2 style="text-align: center;"><%=product.getPROD_PRICE()%></h2>
				<p style="text-align: center;">CU</p>
			</header>
		</div>
	</section>
</div>
<%
}
%>
