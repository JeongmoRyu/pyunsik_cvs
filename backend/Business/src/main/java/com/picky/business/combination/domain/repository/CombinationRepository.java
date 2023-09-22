package com.picky.business.combination.domain.repository;

import com.picky.business.combination.domain.entity.Combination;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CombinationRepository extends JpaRepository<Combination, Long> {
    List<Combination> findByUserId(Long userId);
}
