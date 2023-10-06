package com.picky.business.recommend.service;


import com.picky.business.common.service.RedisService;
import com.picky.business.connect.service.ConnectAuthService;
import com.picky.business.product.domain.entity.Product;
import com.picky.business.product.domain.repository.ProductRepository;
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
    private static final double CARB = 130.0;
    private static final double PROTEIN = 60.0;
    private static final double FAT = 51.0;
    private static final double SODIUM = 2000.0;

    private final RestTemplate restTemplate = new RestTemplate();
    private final Random random = new Random();

    private final ProductService productService;
    private final ConnectAuthService connectAuthService;
    private final RecommendRepository recommendRepository;
    private final RedisService redisService;
    private final ProductRepository productRepository;

    //유저 선호도 기반
    public List<RecommendProductResponse> getRecommendListByUser(String accessToken) {
        Long userId = getUserId(accessToken);
        if (userId == null) {
            int randomCategory = random.nextInt(6) + 1;
            return getRecommendListByCategory(randomCategory);
        }
        List<Recommended> recommendedList = recommendRepository.findRecommendedByUserId(userId);
        if (recommendedList.isEmpty()) {
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
            ResponseEntity<Map> response = restTemplate.getForEntity(FLASK_API_URL + productId, Map.class);
            if (response.getStatusCode() == HttpStatus.OK) {
                Map<String, List<Object>> recommendedProductIds = (Map<String, List<Object>>) response.getBody();
                if (recommendedProductIds != null && recommendedProductIds.containsKey("Recommended Products")) {
                    List<Object> recommendedProductIdObjects = recommendedProductIds.get("Recommended Products");
                    for (Object obj : recommendedProductIdObjects) {
                        if (obj instanceof Integer) {
                            finalRecommendProductIds.add(Long.valueOf((Integer) obj));
                        } else if (obj instanceof Long) {
                            finalRecommendProductIds.add((Long) obj);
                        }
                    }
                }
            } else {
                log.error("외부 API 호출 실패: 상태 코드 {}", response.getStatusCode());
                int randomCategory = random.nextInt(6) + 1;
                return getRecommendListByCategory(randomCategory);
            }
        }
        if (!finalRecommendProductIds.isEmpty()) {
            List<Product> recommendedProducts = getProduct(new ArrayList<>(finalRecommendProductIds));
            return mapToRecommendProductResponse(recommendedProducts);
        } else {
            int randomCategory = random.nextInt(6) + 1;
            return getRecommendListByCategory(randomCategory);
        }
    }

    public List<RecommendProductResponse> getRecommendListByNutrient(List<Long> productIdList) {
        List<Product> selectedProducts = getProduct(productIdList);

        Set<Integer> selectedCategories = new HashSet<>();
        for (Product product : selectedProducts) {
            selectedCategories.add(product.getCategory());
        }

        double totalCarb = 0;
        double totalProtein = 0;
        double totalFat = 0;
        double totalSodium = 0;

        for (Product product : selectedProducts) {
            totalCarb += product.getCarb();
            totalProtein += product.getProtein();
            totalFat += product.getFat();
            totalSodium += product.getSodium();
        }

        double requiredCarb = CARB - totalCarb;
        double requiredProtein = PROTEIN - totalProtein;
        double requiredFat = FAT - totalFat;
        double requiredSodium = SODIUM - totalSodium;

        List<Product> allProducts = productRepository.findAll();

        List<Product> recommendedProducts = allProducts.stream()
                .filter(product -> !selectedCategories.contains(product.getCategory())) // 선택된 카테고리를 제외
                .filter(product ->
                        product.getCarb() <= requiredCarb &&
                                product.getProtein() <= requiredProtein &&
                                product.getFat() <= requiredFat &&
                                product.getSodium() <= requiredSodium)
                .sorted(Comparator.comparingDouble(product ->
                        Math.abs(product.getCarb() - requiredCarb) +
                                Math.abs(product.getProtein() - requiredProtein) +
                                Math.abs(product.getFat() - requiredFat) +
                                Math.abs(product.getSodium() - requiredSodium))) // 점수에 따라 정렬
                .limit(10)
                .collect(Collectors.toList());

        return mapToRecommendProductResponse(recommendedProducts);
    }

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
                .map(product -> RecommendProductResponse.builder()
                        .productId(product.getId())
                        .productName(product.getProductName())
                        .price(product.getPrice())
                        .filename(product.getFilename())
                        .build()
                )
                .collect(Collectors.toList());
    }
}
