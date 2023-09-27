package com.picky.business.log.domain.repository;

import com.picky.business.log.domain.entity.LogSearch;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LogSearchRepository extends JpaRepository<LogSearch, Long> {
}
