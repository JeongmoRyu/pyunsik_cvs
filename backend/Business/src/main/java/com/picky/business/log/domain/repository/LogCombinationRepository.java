package com.picky.business.log.domain.repository;

import com.picky.business.log.domain.entity.LogCombination;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LogCombinationRepository extends JpaRepository<LogCombination, Long> {


}
