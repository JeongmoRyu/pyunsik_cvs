package com.picky.business.favorite.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class FavoriteListResponse {
    private Long productId;
    private String productName;
    private String filename;
    private int price;
}
