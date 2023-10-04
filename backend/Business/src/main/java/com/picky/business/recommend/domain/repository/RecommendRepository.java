package com.picky.business.recommend.domain.repository;

import com.picky.business.recommend.dto.RecommendProductResponse;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class RecommendRepository {

    public List<RecommendProductResponse> findRecommendListByUser(String accessToken) {
        return null;
    }

    public List<RecommendProductResponse> findRecommendListByProductId(List<Long> productIdList) {
        return null;
    }

    public List<RecommendProductResponse> findRecommendListByCategory(String category) {
        return null;
    }
}
