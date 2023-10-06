package com.picky.business.recommend.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
//추천상품 Response
public class RecommendProductResponse {
    private Long productId;
    private String productName;
    private int price;
    private String filename;
}
