package com.picky.business.combination.dto;

import lombok.*;

import java.util.List;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
//조합 생성, 수정
public class CombinationInputRequest {
    private String combinationName;
    private List<CombinationCreateItem> products;

}
