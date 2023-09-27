package com.picky.business.log.service;

import com.picky.business.log.domain.entity.LogCombination;
import com.picky.business.log.domain.entity.LogProduct;
import com.picky.business.log.domain.entity.LogSearch;
import com.picky.business.log.domain.repository.LogCombinationRepository;
import com.picky.business.log.domain.repository.LogProductRepository;
import com.picky.business.log.domain.repository.LogSearchRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class LogService {
    private final LogProductRepository logProductRepository;
    private final LogCombinationRepository logCombinationRepository;
    private final LogSearchRepository logSearchRepository;

    public void saveLogProduct(Long userId, Long productId) {
        LocalDate today = LocalDate.now();
        if (userId == null) return;
        if (!logProductRepository.existsByUserIdAndProductIdAndCreatedAt(userId, productId, today)) {
            logProductRepository.save(LogProduct.builder()
                    .userId(userId)
                    .productId(productId)
                    .createdAt(today)
                    .build());
        }
    }

    public void saveLogCombination(Long userId, List<Long> logCombinationItem) {
        logCombinationRepository.save(LogCombination.builder()
                .userId(userId)
                .logCombinationItem(logCombinationItem)
                .createdAt(LocalDateTime.now())
                .build());
    }

    @Transactional
    public void saveLogSearch(String keyword) {
        logSearchRepository.save(LogSearch.builder()
                .keyword(keyword)
                .createdAt(LocalDateTime.now())
                .build());
    }

}
