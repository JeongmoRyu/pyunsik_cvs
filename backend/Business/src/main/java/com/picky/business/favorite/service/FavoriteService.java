package com.picky.business.favorite.service;

import com.picky.business.connect.service.ConnectAuthService;
import com.picky.business.favorite.domain.entity.Favorite;
import com.picky.business.favorite.domain.repository.FavoriteRepository;
import com.picky.business.favorite.dto.FavoriteAddRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class FavoriteService {
    private final FavoriteRepository favoriteRepository;
    private final ConnectAuthService connectAuthService;

    public void addFavorite(String accessToken, FavoriteAddRequest request) {
        favoriteRepository.save(
                Favorite.builder()
                        .userId(connectAuthService.getUserIdByAccessToken(accessToken))
                        .productId(request.getProductId())
                        .isDeleted(false)
                        .build()
        );
    }
}
