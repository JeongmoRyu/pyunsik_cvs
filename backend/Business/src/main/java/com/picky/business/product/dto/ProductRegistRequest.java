package com.picky.business.product.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
//product 등록
public class ProductRegistRequest {
    private String productName;
    private int price;
    private String filename;
    private String badge;
    private int category;
    private int weight;
    private int kcal;
    private double carb;
    private double protein;
    private double fat;
    private double sodium;
    private int convenienceCode;

}
