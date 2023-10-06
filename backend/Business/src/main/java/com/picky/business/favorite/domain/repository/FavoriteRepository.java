package com.picky.business.favorite.domain.repository;

import com.picky.business.favorite.domain.entity.Favorite;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FavoriteRepository extends JpaRepository<Favorite, Long> {
    List<Favorite> findByUserIdAndIsDeletedFalse(Long userId);

    Favorite findByUserIdAndProductId(Long userId, Long productId);

}