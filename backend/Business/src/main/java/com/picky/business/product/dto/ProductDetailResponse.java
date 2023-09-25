package com.picky.business.product.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
//제품 상세보기
public class ProductDetailResponse {
    private String productName;
    private int price;
    private String filename;
    private int category;
    private long favoriteCount; //좋아요 수
    private int weight;
    private int kcal;
    private double carb;
    private double protein;
    private double fat;
    private double sodium;
    private List<Integer> convenienceCode;
    private List<Integer> promotionCode;
    private Boolean isFavorite;
    private List<CommentResponse> comments;
}
