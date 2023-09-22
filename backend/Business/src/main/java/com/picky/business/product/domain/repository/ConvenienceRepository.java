package com.picky.business.product.domain.repository;

import com.picky.business.product.domain.entity.ConvenienceInfo;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface ConvenienceRepository extends JpaRepository<ConvenienceInfo,Long> {
    Optional<ConvenienceInfo> findByProductId(Long id);
}
