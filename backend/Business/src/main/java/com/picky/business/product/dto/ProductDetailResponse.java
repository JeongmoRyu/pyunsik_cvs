package com.picky.business.product.dto;

import com.picky.business.product.domain.entity.Badge;
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
    private Badge badge;
    private int category;
    private int favoriteCount; //좋아요 수
    private int weight;
    private int kcal;
    private double carb;
    private double protein;
    private double fat;
    private double sodium;
    private List<CommentResponse> comments;
}
