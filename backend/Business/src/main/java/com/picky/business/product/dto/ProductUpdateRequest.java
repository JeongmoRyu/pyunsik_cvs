package com.picky.business.product.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
//product update
public class ProductUpdateRequest {
    private String productName;
    private Integer price;
    private String filename;
    private String badge;
    private Integer category;
    private Integer weight;
    private Integer kcal;
    private Double carb;
    private Double protein;
    private Double fat;
    private Double sodium;
    private List<Integer> convenienceCode;
}
