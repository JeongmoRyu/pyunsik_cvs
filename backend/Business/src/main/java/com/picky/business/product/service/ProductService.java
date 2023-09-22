package com.picky.business.product.service;

import com.picky.business.connect.service.ConnectAuthService;
import com.picky.business.exception.ProductNotFoundException;
import com.picky.business.favorite.domain.repository.FavoriteRepository;
import com.picky.business.product.domain.entity.Product;
import com.picky.business.product.domain.repository.ProductRepository;
import com.picky.business.product.dto.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.function.Consumer;
import java.util.function.Supplier;
import java.util.stream.Collectors;

@Service
@Slf4j
@RequiredArgsConstructor
public class ProductService {
    private final ProductRepository productRepository;
    private final ConnectAuthService connectAuthService;
    private final FavoriteRepository favoriteRepository;
    private static final String NOT_FOUND = "값을 가진 제품이 없습니다";
    private static final String DELETED = "값을 가진 제품이 삭제되었습니다";

    private int[] getMinMax(List<Integer> values) {
        if (values == null || values.size() > 2) return new int[]{0, Integer.MAX_VALUE};
        int minValue = (values.get(0) != null) ? values.get(0) : 0;
        int maxValue = (values.get(1) != null) ? values.get(1) : Integer.MAX_VALUE;
        return new int[]{minValue, maxValue};
    }

    private int[] getSafeMinMax(List<Integer> values, int[] defaultValues) {
        return (values != null) ? getMinMax(values) : defaultValues;
    }

    //Query를 통한 검색
    public List<ProductPreviewResponse> searchProductByQuery(
            String productName, String category,
            List<Integer> price, List<Integer> carb,
            List<Integer> protein, List<Integer> fat, List<Integer> sodium, String accessToken
    ) {
        int[] defaultRange = {0, Integer.MAX_VALUE};

        int[] priceRange = getSafeMinMax(price, defaultRange);
        int[] carbRange = getSafeMinMax(carb, defaultRange);
        int[] proteinRange = getSafeMinMax(protein, defaultRange);
        int[] fatRange = getSafeMinMax(fat, defaultRange);
        int[] sodiumRange = getSafeMinMax(sodium, defaultRange);
        productName = (productName != null) ? productName.replace(" ", "") : null;
        Specification<Product> specification = Product.filterProducts(
                productName, category,
                priceRange[0], priceRange[1],
                carbRange[0], carbRange[1],
                proteinRange[0], proteinRange[1],
                fatRange[0], fatRange[1],
                sodiumRange[0], sodiumRange[1]
        );

        // accessToken이 null이면 null, 아니면 userId 반환
        Long userId = Optional.ofNullable(accessToken)
                .filter(token -> token != null && !token.trim().isEmpty())
                .map(connectAuthService::getUserIdByAccessToken)
                .orElse(null);

        return productRepository.findAll(specification)
                .stream()
                .map(product -> {
                    // accessToken이 null이 아니면 favorite 확인
                    Boolean isFavorite = Optional.ofNullable(userId)
                            .map(id -> favoriteRepository.findByUserIdAndProductId(id, product.getId()) != null)
                            .orElse(null);

                    return ProductPreviewResponse.builder()
                            .productId(product.getId())
                            .productName(product.getProductName())
                            .price(product.getPrice())
                            .filename(product.getFilename())
                            .badge(product.getBadge())
                            .favoriteCount(productRepository.countActiveFavoritesByProductId(product.getId()))
                            .convenienceCode(product.getConvenienceCode())
                            .isFavorite(isFavorite)
                            .build();
                })
                .collect(Collectors.toList());
    }

    public ProductDetailResponse findProductByProductId(Long productId, String accessToken) {
        Product product = getProduct(productId);
        // accessToken이 null이면 null, 아니면 userId 반환
        Long userId = Optional.ofNullable(accessToken)
                .filter(token -> token != null && !token.trim().isEmpty())
                .map(connectAuthService::getUserIdByAccessToken)
                .orElse(null);

        // accessToken이 null이 아니면 favorite 확인
        Boolean isFavorite = Optional.ofNullable(userId)
                .map(id -> favoriteRepository.findByUserIdAndProductId(id, productId) != null)
                .orElse(null);

        // 댓글 불러오기
        List<CommentResponse> commentResponseList = Optional.ofNullable(product.getComments())
                .orElse(Collections.emptyList())
                .stream()
                .map(comment -> CommentResponse.builder()
                        .nickname(comment.getUserNickname())
                        .content(comment.getContent())
                        .createdAt(comment.getCreatedAt().toString())
                        .build())
                .collect(Collectors.toList());

        return ProductDetailResponse.builder()
                .productName(product.getProductName())
                .price(product.getPrice())
                .filename(product.getFilename())
                .badge(product.getBadge())
                .category(product.getCategory())
                .favoriteCount(productRepository.countActiveFavoritesByProductId(productId))
                .weight(product.getWeight())
                .kcal(product.getKcal())
                .carb(product.getCarb())
                .protein(product.getProtein())
                .fat(product.getFat())
                .isFavorite(isFavorite)
                .sodium(product.getSodium())
                .comments(commentResponseList)
                .convenienceCode(product.getConvenienceCode())
                .build();
    }

    public void addProduct(ProductRegistRequest request) {
        productRepository.save(
                Product.builder()
                        .productName(request.getProductName())
                        .price(request.getPrice())
                        .filename(request.getFilename())
                        .badge(request.getBadge())
                        .category(request.getCategory())
                        .weight(request.getWeight())
                        .kcal(request.getKcal())
                        .carb(request.getCarb())
                        .protein(request.getProtein())
                        .fat(request.getFat())
                        .sodium(request.getSodium())
                        .convenienceCode(request.getConvenienceCode())
                        .isDeleted(false)
                        .build()
        );
    }

    public void updateProduct(Long id, ProductUpdateRequest request) {
        Product product = getProduct(id);
        updateProductFields(product, request);
        productRepository.save(product);
    }

    public void deleteProduct(Long id) {
        Product product = getProduct(id);
        product.setIsDeleted(true);
        productRepository.save(product);
    }

    private void updateProductFields(Product currentProduct, ProductUpdateRequest request) {
        updateIfNotNull(request::getProductName, currentProduct::setProductName);
        updateIfNotNull(request::getPrice, currentProduct::setPrice);
        updateIfNotNull(request::getFilename, currentProduct::setFilename);
        updateIfNotNull(request::getBadge, currentProduct::setBadge);
        updateIfNotNull(request::getCategory, currentProduct::setCategory);
        updateIfNotNull(request::getWeight, currentProduct::setWeight);
        updateIfNotNull(request::getKcal, currentProduct::setKcal);
        updateIfNotNull(request::getCarb, currentProduct::setCarb);
        updateIfNotNull(request::getProtein, currentProduct::setProtein);
        updateIfNotNull(request::getFat, currentProduct::setFat);
        updateIfNotNull(request::getSodium, currentProduct::setSodium);
        updateIfNotNull(request::getConvenienceCode, currentProduct::setConvenienceCode);
    }

    private <T> void updateIfNotNull(Supplier<T> getter, Consumer<T> setter) {
        T value = getter.get();
        if (value != null) {
            setter.accept(value);
        }
    }

    public Product getProduct(Long id) {
        return productRepository.findById(id)
                .map(product -> {
                    if (product.getIsDeleted() == null || product.getIsDeleted()) {
                        throw new ProductNotFoundException(id + DELETED);
                    }
                    return product;
                })
                .orElseThrow(() -> new ProductNotFoundException(id + NOT_FOUND));
    }
}
