package com.pyeondeuk.controller;

import com.pyeondeuk.db.ProdPriceMapper;
import com.pyeondeuk.model.ProdPriceDTO;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

public class ProdPriceService {
    private final SqlSessionFactory sqlSessionFactory;

    public ProdPriceService(SqlSessionFactory sqlSessionFactory) {
        this.sqlSessionFactory = sqlSessionFactory;
        
        // Mapper 등록 확인
        System.out.println("Mapper 등록 상태: " + sqlSessionFactory.getConfiguration().hasMapper(ProdPriceMapper.class));
    }

    public ProdPriceDTO getPricesByProdSeq(int prodSeq) {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            // Mapper 등록 확인
            System.out.println("Mapper 등록 상태: " + sqlSessionFactory.getConfiguration().hasMapper(ProdPriceMapper.class));

            ProdPriceMapper mapper = session.getMapper(ProdPriceMapper.class);
            return mapper.getPricesByProdSeq(prodSeq);
        }
    }
}