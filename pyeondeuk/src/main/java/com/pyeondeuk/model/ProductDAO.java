package com.pyeondeuk.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.pyeondeuk.db.SqlSessionManager;

public class ProductDAO {
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSessionFactory();

	public List<ProductDTO> getPBProducts() {
		SqlSession session = sqlSessionFactory.openSession();
		try {
			return session.selectList("com.pyeondeuk.db.ProductMapper.getPBProducts");
		} finally {
			session.close();
		}
	}

	public ProductDTO products_calling(int PROD_SEQ) {
		SqlSession session = sqlSessionFactory.openSession();
		ProductDTO info = null;
		try {
			info = session.selectOne("products_calling", PROD_SEQ);
		} finally {
			session.close();
		}
		return info;
	}

	public List<ProductDTO> getAllProducts() {
		SqlSession session = sqlSessionFactory.openSession();
		try {
			return session.selectList("com.pyeondeuk.db.MemberMapper.getAllProducts");
		} finally {
			session.close();
		}
	}

	public List<ProductDTO> searchProducts(String query) {
		List<ProductDTO> products = getAllProducts(); // 모든 상품 가져오기
		List<ProductDTO> filteredProducts = new ArrayList<>();

		for (ProductDTO product : products) {
			if (product.getPROD_NAME().toLowerCase().contains(query.toLowerCase())
					|| product.getPROD_CATEGORY().toLowerCase().contains(query.toLowerCase())) {
				filteredProducts.add(product);
			}
		}
		return filteredProducts;
	}

	public ProductDTO products_PB_calling(int PROD_SEQ) {
		SqlSession session = sqlSessionFactory.openSession();
		ProductDTO info = null;
		try {
			info = session.selectOne("products_PB_calling", PROD_SEQ);
		} finally {
			session.close();
		}
		return info;
	}

	public List<ProductDTO> products_keyword_calling(String keyword) {
		SqlSession session = sqlSessionFactory.openSession();
		List<ProductDTO> info = null;
		try {
			info = session.selectList("products_keyword_calling", keyword);
		} finally {
			session.close();
		}
		return info;
	}

	public List<ProductDTO> products_store_calling(int BRAND_SEQ, String PROD_CATEGORY, int page, int pageSize) {
		SqlSession session = sqlSessionFactory.openSession();
		List<ProductDTO> products = new ArrayList<>();

		Map<String, Object> params = new HashMap<>();
		params.put("BRAND_SEQ", BRAND_SEQ);
		params.put("PROD_CATEGORY", PROD_CATEGORY);
		params.put("page", (page - 1) * pageSize); // 0-based 오프셋 계산
		params.put("pageSize", pageSize); // 페이지 크기

		products = session.selectList("products_store_calling", params);
		session.close();
		return products;
	}

	public List<ProductDTO> getPBProducts(int brandSeq, int pagePB, int pageSize) {
		SqlSession session = sqlSessionFactory.openSession();
		List<ProductDTO> products = null;
		try {
			Map<String, Object> params = new HashMap<>();
			params.put("BRAND_SEQ", brandSeq);
			params.put("pagePB", pagePB);
			params.put("pageSize", pageSize);
			products = session.selectList("products_pb_calling", params);
		} finally {
			session.close();
		}
		return products;
	}

	public List<ProductDTO> products_store_calling2(int storeId, String category, String prodCategory, String sort,  int page,
			int pageSize) {
		SqlSession session = sqlSessionFactory.openSession();
		List<ProductDTO> products = new ArrayList<>();
        System.out.println("storeId: " + storeId);
        System.out.println("category: " + category);
        System.out.println("prodCategory: " + prodCategory);
        System.out.println("page: " + page);
        System.out.println("pageSize: " + pageSize);
		try {
			Map<String, Object> params = new HashMap<>();
			params.put("storeId", storeId);
			params.put("CATEGORY", category);
			params.put("PROD_CATEGORY", prodCategory);
			params.put("sort", sort);
			int upperLimit = page * pageSize;
			int lowerLimit = (page - 1) * pageSize;
			params.put("upperLimit", upperLimit);
			params.put("lowerLimit", lowerLimit);

			products = session.selectList("com.pyeondeuk.db.ProductMapper.products_store_calling2", params);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return products;
	}

}