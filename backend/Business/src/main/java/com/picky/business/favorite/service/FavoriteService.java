package com.picky.business.favorite.service;

import com.picky.business.connect.service.ConnectAuthService;
import com.picky.business.favorite.domain.entity.Favorite;
import com.picky.business.favorite.domain.repository.FavoriteRepository;
import com.picky.business.favorite.dto.FavoriteListResponse;
import com.picky.business.product.domain.entity.Product;
import com.picky.business.product.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class FavoriteService {
    private final FavoriteRepository favoriteRepository;
    private final ConnectAuthService connectAuthService;

    private final ProductService productService;

    public List<FavoriteListResponse> getFavoriteList(String accessToken) {
        Long userId = connectAuthService.getUserIdByAccessToken(accessToken);
        List<Favorite> findList = favoriteRepository.findByUserIdAndIsDeletedFalse(userId);

        return findList.stream()
                .map(favorite -> {
                    Product product = productService.getProduct(favorite.getId());
                    return FavoriteListResponse.builder()
                            .productId(favorite.getProductId())
                            .productName(product.getProductName())
                            .filename(product.getFilename())
                            .price(product.getPrice())
                            .build();
                })
                .collect(Collectors.toList());
    }

    public void addFavorite(String accessToken, Long productId) {
        Long userId = connectAuthService.getUserIdByAccessToken(accessToken);
        Optional<Favorite> optionalFavorite = Optional.ofNullable(
                favoriteRepository.findByUserIdAndProductId(userId, productId)
        );

        optionalFavorite.ifPresentOrElse(
                existingFavorite -> {
                    existingFavorite.add();
                    favoriteRepository.save(existingFavorite);
                },
                () -> favoriteRepository.save(
                        Favorite.builder()
                                .userId(userId)
                                .productId(productId)
                                .isDeleted(false)
                                .build()
                )
        );
    }

    public void deleteFavorite(String accessToken, Long productId) {
        Long userId = connectAuthService.getUserIdByAccessToken(accessToken);
        Favorite favorite = favoriteRepository.findByUserIdAndProductId(userId, productId);
        favorite.delete();
        favoriteRepository.save(favorite);
    }
}
