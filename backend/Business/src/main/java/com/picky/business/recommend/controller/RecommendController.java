package com.picky.business.recommend.controller;

import com.picky.business.product.dto.ProductPreviewResponse;
import com.picky.business.recommend.service.RecommendService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
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

//    @GetMapping
//    public ResponseEntity<List<ProductPreviewResponse>> getRecommendListByUser(@RequestHeader("Authorization") String accessToken) {
//
//    }
//
//    @GetMapping
//    public ResponseEntity<List<ProductPreviewResponse>> getRecommendListByCombination(List<Long> productIdList) {
//
//    }
//
//    @GetMapping
//    public ResponseEntity<List<ProductPreviewResponse>> getRecommendListByNutrient(List<Long> productIdList) {
//
//    }
}
