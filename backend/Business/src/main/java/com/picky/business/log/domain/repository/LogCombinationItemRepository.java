package com.picky.business.log.domain.repository;

import com.picky.business.log.domain.entity.LogCombinationItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LogCombinationItemRepository extends JpaRepository<LogCombinationItem, Long> {
}
