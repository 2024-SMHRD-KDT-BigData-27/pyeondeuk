package com.pyeondeuk.model;

import java.util.ArrayList;
import java.util.List;

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





}