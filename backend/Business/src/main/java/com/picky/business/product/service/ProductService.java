package com.picky.business.product.service;

import com.picky.business.connect.service.ConnectAuthService;
import com.picky.business.exception.NotFoundException;
import com.picky.business.favorite.domain.repository.FavoriteRepository;
import com.picky.business.log.service.LogService;
import com.picky.business.product.domain.entity.ConvenienceInfo;
import com.picky.business.product.domain.entity.Product;
import com.picky.business.product.domain.repository.ConvenienceRepository;
import com.picky.business.product.domain.repository.ProductRepository;
import com.picky.business.product.dto.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.function.Consumer;
import java.util.function.Supplier;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Service
@Slf4j
@RequiredArgsConstructor
public class ProductService {
    private final ProductRepository productRepository;
    private final ConnectAuthService connectAuthService;
    private final FavoriteRepository favoriteRepository;
    private final ConvenienceRepository convenienceRepository;
    private final LogService logService;
    private static final String NOT_FOUND = "값을 가진 제품이 없습니다";
    private static final String DELETED = "값을 가진 제품이 삭제되었습니다";


    public List<ProductPreviewResponse> searchProductByKeyword(String keyword, String accessToken) {
        keyword = (keyword != null) ? keyword.replace(" ", "") : null;
        if (keyword != null && !keyword.isEmpty()) {
            logService.saveLogSearch(keyword);
        }
        Long userId = getUserId(accessToken);
        List<Product> products = productRepository.findByProductNameContaining(keyword);
        return getSearchList(products, userId);
    }

    //Query를 통한 검색
    public List<ProductPreviewResponse> searchProductByQuery(
            String category,
            List<Integer> price, List<Integer> carb,
            List<Integer> protein, List<Integer> fat, List<Integer> sodium,
            List<Integer> inputConvenienceCode, List<Integer> inputPromotionCode,
            String accessToken
    ) {
        Specification<Product> specification = Product.filterProducts(
                category,
                price, carb, protein, fat, sodium,
                inputConvenienceCode, inputPromotionCode
        );

        // accessToken이 null이면 null, 아니면 userId 반환
        Long userId = getUserId(accessToken);
        List<Product> products = productRepository.findAll(specification);
        return getSearchList(products,userId);

    }

    public ProductDetailResponse findProductByProductId(Long productId, String accessToken) {
        Product product = getProduct(productId);
        // accessToken이 null이면 null, 아니면 userId 반환
        Long userId = getUserId(accessToken);

        // accessToken이 null이 아니면 favorite 확인
        Boolean isFavorite = Optional.ofNullable(userId)
                .map(id -> favoriteRepository.findByUserIdAndProductIdAndIsDeletedFalse(id, productId) != null)
                .orElse(null);
        logService.saveLogProduct(userId, productId);

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
        // 편의점 코드 불러오기
        List<Integer> convenienceCodes = getConvenienceCodes(product);

        List<Integer> promotionCodes = getPromotionCodes(product);

        return ProductDetailResponse.builder()
                .productName(product.getProductName())
                .price(product.getPrice())
                .filename(product.getFilename())
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
                .convenienceCode(convenienceCodes)
                .promotionCode(promotionCodes)
                .build();
    }

    @Transactional
    public void addProduct(ProductRegistRequest request) {
        // Product 객체 생성 및 저장
        Product newProduct = Product.builder()
                .productName(request.getProductName())
                .price(request.getPrice())
                .filename(request.getFilename())
                .category(request.getCategory())
                .weight(request.getWeight())
                .kcal(request.getKcal())
                .carb(request.getCarb())
                .protein(request.getProtein())
                .fat(request.getFat())
                .convenienceInfos(new ArrayList<>())
                .sodium(request.getSodium())
                .isDeleted(false)
                .build();
        Product savedProduct = productRepository.save(newProduct);

        // ConvenienceCode 객체 생성 및 저장
        List<Integer> requestConvenienceCodes = request.getConvenienceCodes();
        List<Integer> requestPromotionCodes = request.getPromotionCodes();
        List<ConvenienceInfo> list = IntStream.range(0, requestConvenienceCodes.size())
                .mapToObj(i -> {
                    Integer convenienceCode = requestConvenienceCodes.get(i);
                    Integer promotionCode = requestPromotionCodes.get(i);
                    return ConvenienceInfo.builder()
                            .productId(savedProduct.getId())
                            .convenienceCode(convenienceCode)
                            .promotionCode(promotionCode)
                            .build();
                })
                .collect(Collectors.toList());


        // 저장한 ConvenienceCode 객체를 DB에 저장
        convenienceRepository.saveAll(list);
    }

    public void updateProduct(Long id, ProductUpdateRequest request) {
        Product product = getProduct(id);
        updateProductFields(product, request);

        ConvenienceInfo convenienceInfo = convenienceRepository.findByProductId(id)
                .orElseThrow(() -> new NotFoundException("해당하는 제품에 대한 편의점 코드가 없습니다 "));
        updateConvenienceCodeFields(convenienceInfo, request);
        productRepository.save(product);
        convenienceRepository.save(convenienceInfo);
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
        updateIfNotNull(request::getCategory, currentProduct::setCategory);
        updateIfNotNull(request::getWeight, currentProduct::setWeight);
        updateIfNotNull(request::getKcal, currentProduct::setKcal);
        updateIfNotNull(request::getCarb, currentProduct::setCarb);
        updateIfNotNull(request::getProtein, currentProduct::setProtein);
        updateIfNotNull(request::getFat, currentProduct::setFat);
        updateIfNotNull(request::getSodium, currentProduct::setSodium);
    }

    private void updateConvenienceCodeFields(ConvenienceInfo code, ProductUpdateRequest request) {
        updateIfNotNull(request::getConvenienceCode, code::setConvenienceCode);
        updateIfNotNull(request::getPromotionCode, code::setPromotionCode);
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
                        throw new NotFoundException(id + DELETED);
                    }
                    return product;
                })
                .orElseThrow(() -> new NotFoundException(id + NOT_FOUND));
    }

    private List<Integer> getConvenienceCodes(Product product) {
        return product.getConvenienceInfos()
                .stream()
                .map(ConvenienceInfo::getConvenienceCode)
                .collect(Collectors.toList());
    }

    private List<Integer> getPromotionCodes(Product product) {
        return product.getConvenienceInfos()
                .stream()
                .map(ConvenienceInfo::getPromotionCode)
                .collect(Collectors.toList());

    }

    private Long getUserId(String accessToken) {
        return Optional.ofNullable(accessToken)
                .filter(token -> token != null && !token.trim().isEmpty())
                .map(connectAuthService::getUserIdByAccessToken)
                .orElse(null);
    }

    private List<ProductPreviewResponse> getSearchList(List<Product> list, Long userId) {
        return list.stream()
                .map(product -> {
                    // accessToken이 null이 아니면 favorite 확인
                    Boolean isFavorite = Optional.ofNullable(userId)
                            .map(id -> favoriteRepository.findByUserIdAndProductIdAndIsDeletedFalse(id, product.getId()) != null)
                            .orElse(null);

                    List<Integer> convenienceCodes = getConvenienceCodes(product);

                    List<Integer> promotionCodes = getPromotionCodes(product);

                    return ProductPreviewResponse.builder()
                            .productId(product.getId())
                            .productName(product.getProductName())
                            .price(product.getPrice())
                            .filename(product.getFilename())
                            .favoriteCount(productRepository.countActiveFavoritesByProductId(product.getId()))
                            .convenienceCode(convenienceCodes)
                            .promotionCode(promotionCodes)
                            .isFavorite(isFavorite)
                            .build();
                })
                .collect(Collectors.toList());
    }
}
