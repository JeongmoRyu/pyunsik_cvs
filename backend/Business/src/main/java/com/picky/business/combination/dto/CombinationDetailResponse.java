package com.picky.business.combination.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

//조합 detail
@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CombinationDetailResponse {
    private String combinationName;
    private Long combinationId;
    private int totalPrice;
    private int totalKcal;
    private double totalCarb;
    private double totalProtein;
    private double totalFat;
    private double totalSodium;
    private List<ProductInfo> combinationItems;

}
