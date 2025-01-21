package com.pyeondeuk.controller;

import com.pyeondeuk.model.ProdPriceDTO;
import com.pyeondeuk.db.ProdPriceMapper;
import com.pyeondeuk.db.SqlSessionManager;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSessionFactory;

import java.io.IOException;

@WebServlet("/price-chart")
public class PriceChartServlet extends HttpServlet {
    private ProdPriceService prodPriceService;

    @Override
    public void init() throws ServletException {
        try {
            prodPriceService = new ProdPriceService(SqlSessionManager.getSqlSessionFactory());
            
            // Mapper 등록 확인
            SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSessionFactory();
            System.out.println("Mapper 등록 상태: " + sqlSessionFactory.getConfiguration().hasMapper(ProdPriceMapper.class));
            
            System.out.println("Servlet 초기화 성공");
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("MyBatis 초기화 실패: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String prodSeqParam = req.getParameter("prodSeq");
        System.out.println("prodSeqParam: " + prodSeqParam);

        if (prodSeqParam == null || prodSeqParam.isEmpty()) {
            resp.getWriter().write("prodSeq 값을 전달해야 합니다.");
            return;
        }

        try {
            int prodSeq = Integer.parseInt(prodSeqParam);
            ProdPriceDTO price = prodPriceService.getPricesByProdSeq(prodSeq);

            // 디버깅: 데이터 확인
            if (price == null) {
                System.out.println("price 객체가 null입니다. 데이터베이스에서 값을 가져오지 못했습니다.");
                req.setAttribute("error", "해당 상품 번호에 대한 데이터를 찾을 수 없습니다.");
            } else {
                System.out.println("price 데이터: " + price);
                req.setAttribute("price", price);
            }
           

            req.setAttribute("prodSeq", prodSeq);
            req.getRequestDispatcher("/product.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            System.out.println("잘못된 prodSeq 값입니다.");
            resp.getWriter().write("잘못된 prodSeq 값입니다.");
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("서버 오류 발생: " + e.getMessage());
        }
    }
}