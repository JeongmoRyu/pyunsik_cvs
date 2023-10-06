package com.picky.business.log.domain.repository;

import com.picky.business.log.domain.entity.LogProduct;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;

@Repository
public interface LogProductRepository extends JpaRepository<LogProduct, Long> {
    boolean existsByUserIdAndProductIdAndCreatedAt(Long userId, Long productId, LocalDate createdAt);
}
