package com.picky.business.combination.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
//조합 목록을 조회하는 dto
public class CombinationListResponse {
    private Long combinationId;
    private String combinationName;
    private int totalPrice;
    private int totalKcal;


}
