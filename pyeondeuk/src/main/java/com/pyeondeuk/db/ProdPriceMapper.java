package com.pyeondeuk.db;

import com.pyeondeuk.model.ProdPriceDTO;

public interface ProdPriceMapper {
    ProdPriceDTO getPricesByProdSeq(int prodSeq);
}