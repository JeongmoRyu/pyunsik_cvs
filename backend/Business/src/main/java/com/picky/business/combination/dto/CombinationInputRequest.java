package com.picky.business.combination.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
//조합 생성, 수정
public class CombinationInputRequest {
    private String combinationName;
    private List<ProductInfo> products;

}
