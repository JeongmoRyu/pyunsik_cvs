package com.picky.business.recommend.controller;

import com.picky.business.recommend.dto.RecommendProductResponse;
import com.picky.business.recommend.service.RecommendService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(value = "/api/recommend")
@RequiredArgsConstructor
@Slf4j
@CrossOrigin(origins = "*")
public class RecommendController {

    private final RecommendService recommendService;

    @GetMapping("/similarity")// 유저선호도 기반 추천
    public ResponseEntity<List<RecommendProductResponse>> getRecommendListByUser(@RequestHeader("Authorization") String accessToken) {
        return ResponseEntity.status(HttpStatus.OK).body(recommendService.getRecommendListByUser(accessToken));
    }

    @GetMapping("/combination")// 조합상품기반 추천
    public ResponseEntity<List<RecommendProductResponse>> getRecommendListByCombination(@RequestParam List<Long> productIdList) {
        return ResponseEntity.status(HttpStatus.OK).body(recommendService.getRecommendListByCombination(productIdList));
    }

    @GetMapping("/nutrient")// 영양정보기반 추천
    public ResponseEntity<List<RecommendProductResponse>> getRecommendListByNutrient(@RequestParam List<Long> productIdList) {
        return ResponseEntity.status(HttpStatus.OK).body(recommendService.getRecommendListByNutrient(productIdList));
    }

    @GetMapping("/{category}")//카테고리 별 인기상품 추천
    public ResponseEntity<List<RecommendProductResponse>> getRecommendListByCategory(@PathVariable int category) {
        return ResponseEntity.status(HttpStatus.OK).body(recommendService.getRecommendListByCategory(category));
    }

}
