package com.picky.business.recommend.domain.repository;

import com.picky.business.recommend.domain.entity.Recommended;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RecommendRepository extends JpaRepository<Recommended, Long> {
    @Query("SELECT r FROM Recommended r WHERE r.userId = :userId")
    List<Recommended> findRecommendedByUserId(Long userId);

//    public List<RecommendProductResponse> findRecommendListByUser(String accessToken) {
//        return null;
//    }
//
//    public List<RecommendProductResponse> findRecommendListByProductId(List<Long> productIdList) {
//        return null;
//    }
//
//    public List<RecommendProductResponse> findRecommendListByCategory(String category) {
//        return null;
//    }
}
