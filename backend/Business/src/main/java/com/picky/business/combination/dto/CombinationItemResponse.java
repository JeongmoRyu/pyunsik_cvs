package com.picky.business.combination.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
//조합 내부의 item들 정보
public class CombinationItemResponse {
    private Long productId;
    private String productName;
    private int price;
    private String filename;
    private int kcal;
    private double carb;
    private double protein;
    private double fat;
    private double sodium;
    private int amount;
}
