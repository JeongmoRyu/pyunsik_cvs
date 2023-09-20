package com.picky.business.product.dto;

import lombok.*;

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
    private String badge;
    private int category;
    private long favoriteCount; //좋아요 수
    private int weight;
    private int kcal;
    private double carb;
    private double protein;
    private double fat;
    private double sodium;
    private int convenienceCode;
    private Boolean isFavorite;
    private List<CommentResponse> comments;
}
