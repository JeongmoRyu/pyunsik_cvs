package com.picky.business.log.service;

import com.picky.business.log.domain.entity.LogCombination;
import com.picky.business.log.domain.entity.LogCombinationItem;
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
import java.util.stream.Collectors;

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
        // LogCombination 객체 생성
        LogCombination log = LogCombination.builder()
                .userId(userId)
                .createdAt(LocalDateTime.now())
                .build();

        // LogCombination 저장
        logCombinationRepository.save(log);

        // LogCombinationItem 리스트 생성
        List<LogCombinationItem> items = logCombinationItem.stream()
                .map(productId -> LogCombinationItem.builder()
                        .productId(productId)
                        .combinationId(log.getId())  // LogCombination의 ID 설정
                        .logCombination(log)  // 양방향 연관관계 설정
                        .build())
                .collect(Collectors.toList());

        // LogCombination에 Item 리스트 설정
        log.setItems(items);

        // LogCombination 업데이트 (Cascade 설정으로 인해 LogCombinationItem도 함께 저장됨)
        logCombinationRepository.save(log);
    }

    @Transactional
    public void saveLogSearch(String keyword) {
        logSearchRepository.save(LogSearch.builder()
                .keyword(keyword)
                .createdAt(LocalDateTime.now())
                .build());
    }

}
