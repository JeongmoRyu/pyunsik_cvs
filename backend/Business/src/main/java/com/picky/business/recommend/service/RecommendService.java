package com.picky.business.recommend.service;

import com.picky.business.product.domain.entity.Product;
import com.picky.business.product.service.ProductService;
import com.picky.business.recommend.dto.RecommendProductResponse;
import com.picky.business.recommend.repository.RecommendRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class RecommendService {
    private final ProductService productService;

    public List<Product> getProduct(List<Long> productId){
        return productId.stream()
                .map(productService::getProduct
                )
                .collect(Collectors.toList());
    }

    private final RecommendRepository recommendRepository;

    public List<RecommendProductResponse> getRecommendListByUser(String accessToken) {
        // 유저 선호도 기반 추천 로직
        return recommendRepository.findRecommendListByUser(accessToken);
    }

    public List<RecommendProductResponse> getRecommendListByCombination(List<Long> productIdList) {
        // 조합 상품 기반 추천 로직
        return recommendRepository.findRecommendListByProductId(productIdList);
    }

    public List<RecommendProductResponse> getRecommendListByNutrient(List<Long> productIdList) {
        // 영양 정보 기반 추천 로직
        return recommendRepository.findRecommendListByProductId(productIdList);
    }

    public List<RecommendProductResponse> getRecommendListByCategory(String category) {
        // 카테고리 별 인기 상품 추천 로직
        return recommendRepository.findRecommendListByCategory(category);
    }

}
