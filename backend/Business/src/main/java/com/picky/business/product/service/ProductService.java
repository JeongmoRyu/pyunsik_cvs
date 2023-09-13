package com.picky.business.product.service;

import com.picky.business.exception.ProductNotFoundException;
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
    private static final String NOT_FOUND = "값을 가진 제품이 없습니다";

    private int[] getMinMax(List<Integer> values) {
        if (values == null || values.size() > 2) return new int[]{0, Integer.MAX_VALUE};
        int minValue = (values.get(0) != null) ? values.get(0) : 0;
        int maxValue = (values.get(1) != null) ? values.get(1) : Integer.MAX_VALUE;
        return new int[]{minValue, maxValue};
    }

    //Query를 통한 검색
    public List<ProductPreviewResponse> searchProductByQuery(
            String productName, String category,
            List<Integer> price, List<Integer> carb,
            List<Integer> protein, List<Integer> fat, List<Integer> sodium
    ) {
        int[] priceRange = getMinMax(price);
        int[] carbRange = getMinMax(carb);
        int[] proteinRange = getMinMax(protein);
        int[] fatRange = getMinMax(fat);
        int[] sodiumRange = getMinMax(sodium);
        Specification<Product> specification = Product.filterProducts(
                productName, category,
                priceRange[0], priceRange[1],
                        carbRange[0], carbRange[1],
                        proteinRange[0], proteinRange[1],
                        fatRange[0], fatRange[1],
                        sodiumRange[0], sodiumRange[1]
        );
        //TODO: 유저정보 통해서 isFavorite 정보 입력 필요
        return productRepository.findAll(specification)
                .stream()
                .map(product -> ProductPreviewResponse.builder()
                        .productId(product.getId())
                        .productName(product.getProductName())
                        .price(product.getPrice())
                        .filename(product.getFilename())
                        .badge(product.getBadge())
                        .build())
                .collect(Collectors.toList());
    }

    public ProductDetailResponse findProductByProductId(Long id) {
        Product product = Optional.ofNullable(productRepository.findProductById(id))
                .orElseThrow(() -> new ProductNotFoundException(id + NOT_FOUND));


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
                .favoriteCount(product.getFavoriteCount())
                .weight(product.getWeight())
                .kcal(product.getKcal())
                .carb(product.getCarb())
                .protein(product.getProtein())
                .fat(product.getFat())
                .sodium(product.getSodium())
                .comments(commentResponseList)
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
                        .favoriteCount(0)
                        .weight(request.getWeight())
                        .kcal(request.getKcal())
                        .carb(request.getCarb())
                        .protein(request.getProtein())
                        .fat(request.getFat())
                        .sodium(request.getSodium())
                        .convenienceCode(request.getConvenienceCode())
                        .build()
        );
    }

    public void updateProduct(Long id, ProductUpdateRequest request) {
        // 해당 ID의 제품 찾기
        Product currentProduct = productRepository.findById(id)
                .orElseThrow(() -> new ProductNotFoundException(id + NOT_FOUND));

        //필드값 변경
        updateProductFields(currentProduct, request);
        productRepository.save(currentProduct);
    }

    public void deleteProduct(Long id) {
        //findById값이 null이면 예외 던지기, 그렇지 않다면 deleteById 실행
        productRepository.findById(id)
                .ifPresentOrElse(
                        product -> productRepository.deleteById(id),
                        () -> {
                            throw new ProductNotFoundException(id + " NOT FOUND");
                        }
                );

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
}
