package com.pyeondeuk.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProdPriceDTO {
    private int prodSeq;
    private double price_2024_07;
    private double price_2024_08;
    private double price_2024_09;
    private double price_2024_10;
    private double price_2024_11;
    private double price_2024_12;
    private double price_2025_01;
}