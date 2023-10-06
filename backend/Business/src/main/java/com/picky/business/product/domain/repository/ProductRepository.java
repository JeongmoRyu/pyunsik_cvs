package com.picky.business.product.domain.repository;

import com.picky.business.product.domain.entity.Product;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    List<Product> findAll(Specification<Product> specification);

    @Query("SELECT count(f) FROM Favorite f WHERE f.product.id = :productId AND f.isDeleted = false")
    Long countActiveFavoritesByProductId(@Param("productId") Long productId);

    List<Product> findByProductNameContaining(String keyword);
}
