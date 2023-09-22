package com.picky.business.combination.service;

import com.picky.business.combination.domain.entity.Combination;
import com.picky.business.combination.domain.entity.CombinationItem;
import com.picky.business.combination.domain.repository.CombinationRepository;
import com.picky.business.combination.dto.CombinationDetailResponse;
import com.picky.business.combination.dto.CombinationListResponse;
import com.picky.business.combination.dto.ProductInfo;
import com.picky.business.connect.service.ConnectAuthService;
import com.picky.business.exception.CommentNotFoundException;
import com.picky.business.product.service.ProductService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Slf4j
@RequiredArgsConstructor
public class CombinationService {
    private final ConnectAuthService connectAuthService;
    private final CombinationRepository combinationRepository;
    private final ProductService productService;
    private static final String NOT_FOUND = "를 찾을 수 없습니다";
    private static final String DELETED = "가 삭제되었습니다";

    public List<CombinationListResponse> getPersonalCombinations(String accessToken) {
        Long userId = connectAuthService.getUserIdByAccessToken(accessToken);
        return combinationRepository.findByUserId(userId)
                .stream()
                .map(combination -> CombinationListResponse.builder()
                        .combinationId(combination.getId())
                        .combinationName(combination.getCombinationName())
                        .totalPrice(combination.getTotalPrice())
                        .totalKcal(combination.getTotalKcal())
                        .build())
                .collect(Collectors.toList());

    }
    public CombinationDetailResponse getCombinationDetail(Long combinationId){
        Combination combination = getCombinationById(combinationId);

        List<CombinationItem> combinationItems = combination.getItems();

        List<ProductInfo> productInfos = combinationItems.stream()
                .filter(item -> !item.getIsDeleted())
                .map(item -> new ProductInfo(item.getProductId(), item.getAmount()))
                .collect(Collectors.toList());

        return CombinationDetailResponse.builder()
                .combinationName(combination.getCombinationName())
                .combinationId(combinationId)
                .totalKcal(combination.getTotalKcal())
                .totalPrice(combination.getTotalPrice())
                .totalCarb(combination.getTotalCarb())
                .totalFat(combination.getTotalFat())
                .totalSodium(combination.getTotalSodium())
                .totalProtein(combination.getTotalProtein())
                .combinationItems(productInfos)
                .build();
    }

    public Combination getCombinationById(Long combinationId) {
        return combinationRepository.findById(combinationId)
                .map(combination -> {
                    if (combination.getIsDeleted() == null || combination.getIsDeleted()) {
                        throw new CommentNotFoundException(combinationId + DELETED);
                    }
                    return combination;
                })
                .orElseThrow(() -> new CommentNotFoundException(combinationId + NOT_FOUND));
    }
}
