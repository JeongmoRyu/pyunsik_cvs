package com.picky.business.combination.service;

import com.picky.business.combination.domain.entity.Combination;
import com.picky.business.combination.domain.entity.CombinationItem;
import com.picky.business.combination.domain.repository.CombinationRepository;
import com.picky.business.combination.dto.*;
import com.picky.business.connect.service.ConnectAuthService;
import com.picky.business.exception.InvalidTokenException;
import com.picky.business.exception.NotFoundException;
import com.picky.business.log.service.LogService;
import com.picky.business.product.domain.entity.Product;
import com.picky.business.product.service.ProductService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@Slf4j
@RequiredArgsConstructor
public class CombinationService {
    private final ConnectAuthService connectAuthService;
    private final CombinationRepository combinationRepository;
    private final ProductService productService;
    private final LogService logService;
    private static final String NOT_FOUND = "를 찾을 수 없습니다";
    private static final String DELETED = "가 삭제되었습니다";

    public List<CombinationListResponse> getPersonalCombinations(String accessToken) {
        Long userId = connectAuthService.getUserIdByAccessToken(accessToken);
        log.info("personal Combination List 불러오기 : userId:" + userId);
        return combinationRepository.findByUserIdAndIsDeletedFalse(userId)
                .stream()
                .map(combination -> CombinationListResponse.builder()
                        .combinationId(combination.getId())
                        .combinationName(combination.getCombinationName())
                        .totalPrice(combination.getTotalPrice())
                        .totalKcal(combination.getTotalKcal())
                        .build())
                .collect(Collectors.toList());

    }

    public CombinationDetailResponse getCombinationDetail(Long combinationId) {
        Combination combination = getCombinationById(combinationId);

        List<CombinationItem> combinationItems = combination.getItems();

        List<ProductInfo> productInfos = combinationItems.stream()
                .map(item -> ProductInfo.builder()
                        .productId(item.getProductId())
                        .amount(item.getAmount())
                        .productName(item.getProductName())
                        .price(item.getPrice())
                        .filename(item.getFilename())
                        .build()
                )
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
                        throw new NotFoundException(combinationId + DELETED);
                    }
                    return combination;
                })
                .orElseThrow(() -> new NotFoundException(combinationId + NOT_FOUND));
    }

    public Long addCombination(String accessToken, CombinationInputRequest request) {
        Long userId = connectAuthService.getUserIdByAccessToken(accessToken);
        List<Long> logList = new ArrayList<>();
        Combination combination = Combination.builder()
                .userId(userId)
                .combinationName(request.getCombinationName())
                .isDeleted(false)
                .createdAt(LocalDateTime.now())
                .totalKcal(0)
                .totalPrice(0)
                .totalCarb(0.0)
                .totalProtein(0.0)
                .totalFat(0.0)
                .totalSodium(0.0)
                .build();
        List<CombinationItem> combinationItems = request.getProducts().stream()
                .map(createItem -> {
                    Long productId = createItem.getProductId();
                    logList.add(productId);
                    Product product = productService.getProduct(productId);
                    CombinationItem combinationItem = CombinationItem.builder()
                            .productId(productId)
                            .amount(createItem.getAmount())
                            .productName(product.getProductName())
                            .filename(product.getFilename())
                            .price(product.getPrice() * createItem.getAmount())
                            .combination(combination)
                            .build();

                    // Combination의 값들에 CombinationItem의 값들을 더합니다.
                    combination.setTotalKcal(combination.getTotalKcal() + product.getKcal() * combinationItem.getAmount());
                    combination.setTotalPrice(combination.getTotalPrice() + product.getPrice() * combinationItem.getAmount());
                    combination.setTotalCarb(combination.getTotalCarb() + product.getCarb() * combinationItem.getAmount());
                    combination.setTotalProtein(combination.getTotalProtein() + product.getProtein() * combinationItem.getAmount());
                    combination.setTotalFat(combination.getTotalFat() + product.getFat() * combinationItem.getAmount());
                    combination.setTotalSodium(combination.getTotalSodium() + product.getSodium() * combinationItem.getAmount());

                    return combinationItem;
                })
                .collect(Collectors.toList());

        combination.setItems(combinationItems);

        logService.saveLogCombination(userId, logList);
        combinationRepository.save(combination);
        log.info("저장된 combination Id:" + combination.getId());
        return combination.getId();
    }

    public void deleteCombination(String accessToken, Long combinationId) {
        Long userId = connectAuthService.getUserIdByAccessToken(accessToken);
        Combination combination = Optional.ofNullable(getCombinationById(combinationId))
                .filter(c -> userId.equals(c.getUserId()))
                .orElseThrow(() -> new InvalidTokenException("조합 생성 유저와 현재 유저가 일치하지 않습니다"));

        combination.setIsDeleted(true);
        combinationRepository.save(combination);
    }

    public Long updateCombination(String accessToken, Long combinationId, CombinationInputRequest request) {
        deleteCombination(accessToken, combinationId);
        return addCombination(accessToken, request);
    }
}
