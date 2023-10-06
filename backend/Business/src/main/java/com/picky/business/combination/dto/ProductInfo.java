package com.picky.business.combination.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
//조합 생성, 수정에 들어갈 정보
public class ProductInfo {
    private Long productId;
    private String productName;
    private int price;
    private String filename;
    private int amount;
}
