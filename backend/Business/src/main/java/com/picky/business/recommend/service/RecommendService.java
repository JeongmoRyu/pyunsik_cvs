package com.picky.business.recommend.service;


import com.picky.business.common.service.RedisService;
import com.picky.business.connect.service.ConnectAuthService;
import com.picky.business.product.domain.entity.Product;
import com.picky.business.product.service.ProductService;
import com.picky.business.recommend.domain.entity.Recommended;
import com.picky.business.recommend.domain.repository.RecommendRepository;
import com.picky.business.recommend.dto.RecommendProductResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.*;
import java.util.stream.Collectors;

@Service
@Slf4j
@RequiredArgsConstructor
public class RecommendService {


    private static final String FLASK_API_URL = "http://j9a505.p.ssafy.io:8000/recommend?product_id=";
    private final RestTemplate restTemplate = new RestTemplate();

    private final ProductService productService;
    private final ConnectAuthService connectAuthService;
    private final RecommendRepository recommendRepository;
    private final RedisService redisService;

    //유저 선호도 기반
    public List<RecommendProductResponse> getRecommendListByUser(String accessToken) {
        Long userId = getUserId(accessToken);
        if(userId == null){
            Random random = new Random();
            int randomCategory = random.nextInt(6) + 1;
            return getRecommendListByCategory(randomCategory);
        }
        List<Recommended> recommendedList = recommendRepository.findRecommendedByUserId(userId);
        if (recommendedList.isEmpty()) {
            Random random = new Random();
            int randomCategory = random.nextInt(6) + 1;
            return getRecommendListByCategory(randomCategory);
        }

        List<Long> productIds = recommendedList.stream()
                .map(Recommended::getProductId)
                .collect(Collectors.toList());

        List<Product> recommendedProducts = getProduct(productIds);

        return mapToRecommendProductResponse(recommendedProducts);
    }

    //조합기반
    public List<RecommendProductResponse> getRecommendListByCombination(List<Long> productIdList) {
        Set<Long> finalRecommendProductIds = new HashSet<>();
        for (Long productId : productIdList) {
            ResponseEntity<List> response = restTemplate.getForEntity(FLASK_API_URL + productId, List.class);
            if (response.getStatusCode() == HttpStatus.OK) {
                List<Long> recommendedProductIds = response.getBody();
                finalRecommendProductIds.addAll(recommendedProductIds);
            } else {
                log.error("외부 API 호출 실패: 상태 코드 {}", response.getStatusCode());
//                Random random = new Random();
//                int randomCategory = random.nextInt(6) + 1;
//                return getRecommendListByCategory(randomCategory);
            }
        }

        List<Product> recommendedProducts = getProduct(new ArrayList<>(finalRecommendProductIds));
        return mapToRecommendProductResponse(recommendedProducts);
    }


    //
//    public List<RecommendProductResponse> getRecommendListByNutrient(List<Long> productIdList) {
//        // 영양 정보 기반 추천 로직
//        return recommendRepository.findRecommendListByProductId(productIdList);
//    }
//
    //카테고리 기반
    public List<RecommendProductResponse> getRecommendListByCategory(int category) {
        List<Long> productIds;
        try {
            productIds = redisService.getPopularProductsByCategory(category);
        } catch (Exception e) {
            log.error("카테고리기반 추천 에러", e);
            return Collections.emptyList();
        }

        List<Product> recommendedProducts = getProduct(productIds);
        return mapToRecommendProductResponse(recommendedProducts);
    }


    private Long getUserId(String accessToken) {
        return Optional.ofNullable(accessToken)
                .filter(token -> token != null && !token.trim().isEmpty())
                .map(connectAuthService::getUserIdByAccessToken)
                .orElse(null);
    }

    public List<Product> getProduct(List<Long> productId) {
        return productId.stream()
                .map(productService::getProduct
                )
                .collect(Collectors.toList());
    }

    private List<RecommendProductResponse> mapToRecommendProductResponse(List<Product> products) {
        return products.stream()
                .map(product -> {
                    return RecommendProductResponse.builder()
                            .productId(product.getId())
                            .productName(product.getProductName())
                            .price(product.getPrice())
                            .filename(product.getFilename())
                            .build();
                })
                .collect(Collectors.toList());
    }


}
