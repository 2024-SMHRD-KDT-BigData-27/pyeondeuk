package com.pyeondeuk.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pyeondeuk.model.ProductDAO;
import com.pyeondeuk.model.ProductDTO;

@WebServlet("/orderByService")
public class orderByService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");

		String category = request.getParameter("strCategory");
		String eventType = request.getParameter("strEventType"); // 1p1, 2p1
		int storeId = Integer.parseInt(request.getParameter("storeId"));
		int page = Integer.parseInt(request.getParameter("page"));
		String sort = request.getParameter("sort") != null ? request.getParameter("sort") : "default";

		int pageSize = 20;
		int lowerLimit = (page - 1) * pageSize + 1;
		int upperLimit = page * pageSize;

		ProductDAO dao = new ProductDAO();
		StringBuilder onePlusOneHtml = new StringBuilder();
		StringBuilder twoPlusOneHtml = new StringBuilder();
		StringBuilder pbProductHtml = new StringBuilder();

		// 1+1 상품 조회
		if (eventType == null || eventType.equals("") || eventType.equals("1p1")) {
			List<ProductDTO> onePlusOneProducts = dao.products_store_calling2(storeId, category, "1+1 상품", sort,
					lowerLimit, upperLimit);
			for (ProductDTO product : onePlusOneProducts) {
				String brand = mapBrand(product.getBRAND_SEQ());
				onePlusOneHtml.append(createProductHtml(product, brand));
			}
		}

		// 2+1 상품 조회
		if (eventType == null || eventType.equals("") || eventType.equals("2p1")) {
			List<ProductDTO> twoPlusOneProducts = dao.products_store_calling2(storeId, category, "2+1 상품", sort,
					lowerLimit, upperLimit);
			for (ProductDTO product : twoPlusOneProducts) {
				String brand = mapBrand(product.getBRAND_SEQ());
				twoPlusOneHtml.append(createProductHtml(product, brand));
			}
		}

		// PB 상품 조회
		List<ProductDTO> pbProducts = dao.products_store_calling2((storeId-4), category, "PB 상품", sort, lowerLimit,
				upperLimit);
		for (ProductDTO product : pbProducts) {
			String brand = mapBrand(product.getBRAND_SEQ());
			pbProductHtml.append(createProductHtml(product, brand));
		}

		// CU 단독 운영 상품 조회
		List<ProductDTO> cuExclusiveProducts = dao.products_store_calling2((storeId-4), category, "CU 단독 운영 상품", sort,
				lowerLimit, upperLimit);
		for (ProductDTO product : cuExclusiveProducts) {
			String brand = mapBrand(product.getBRAND_SEQ());
			pbProductHtml.append(createProductHtml(product, brand));
		}

		// JSON 응답 생성
		PrintWriter out = response.getWriter();
		out.println("{");
		out.println("\"onePlusOne\": \"" + escapeJson(onePlusOneHtml.toString()) + "\",");
		out.println("\"twoPlusOne\": \"" + escapeJson(twoPlusOneHtml.toString()) + "\",");
		out.println("\"pbProducts\": \"" + escapeJson(pbProductHtml.toString()) + "\"");
		out.println("}");
	}

	private String mapBrand(String brandSeq) {
		switch (brandSeq) {
		case "1":
			return "이마트24";
		case "2":
			return "CU";
		case "3":
			return "GS25";
		case "4":
			return "세븐일레븐";
		default:
			return "알 수 없음";
		}
	}

	private String createProductHtml(ProductDTO product, String brand) {
		return "<div class='col-3'>" + "<section class='box feature'>" + "<a href='./product.jsp?PROD_SEQ="
				+ product.getPROD_SEQ() + "' class='image featured' style='text-decoration: none;'>" + "<img src='"
				+ product.getPROD_IMG() + "' alt='" + product.getPROD_NAME() + "' width='200px' />" + "</a>"
				+ "<div class='inner'>" + "<header>" + "<h1 style='text-align: center;'>" + product.getPROD_NAME()
				+ "</h1>" + "<h2 style='text-align: center;'>" + product.getPROD_PRICE() + "원</h2>"
				+ "<p style='text-align: center;'>" + brand + "</p>" + "</header>" + "</div>" + "</section>" + "</div>";
	}

	private String escapeJson(String html) {
		if (html == null) {
			return "";
		}
		return html.replace("\\", "\\\\") // 백슬래시 이스케이프
				.replace("\"", "\\\"") // 큰따옴표 이스케이프
				.replace("\n", "\\n") // 줄바꿈 이스케이프
				.replace("\r", "\\r"); // 캐리지 리턴 이스케이프
	}
}
