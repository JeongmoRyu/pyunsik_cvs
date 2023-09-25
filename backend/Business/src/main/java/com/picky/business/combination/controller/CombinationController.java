package com.picky.business.combination.controller;

import com.picky.business.combination.dto.CombinationDetailResponse;
import com.picky.business.combination.dto.CombinationInputRequest;
import com.picky.business.combination.dto.CombinationListResponse;
import com.picky.business.combination.service.CombinationService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(value = "/api/combination")
@RequiredArgsConstructor
@Slf4j
@CrossOrigin(origins = "*")
public class CombinationController {
    private final CombinationService combinationService;

    @GetMapping
    ResponseEntity<List<CombinationListResponse>> getPersonalCombinations(@RequestHeader("Authorization") String accessToken) {
        log.info("------------token:" + accessToken);
        return ResponseEntity.status(HttpStatus.OK).body(combinationService.getPersonalCombinations(accessToken));
    }

    @GetMapping(value = "/{combinationId}")
    ResponseEntity<CombinationDetailResponse> getCombinationDetail(@PathVariable Long combinationId) {
        return ResponseEntity.status(HttpStatus.OK).body(combinationService.getCombinationDetail(combinationId));
    }

    @PostMapping
    ResponseEntity<String> createCombination(@RequestHeader("Authorization") String accessToken, @RequestBody CombinationInputRequest request) {
        combinationService.addCombination(accessToken, request);
        return ResponseEntity.status(HttpStatus.CREATED).body("조합등록 완료");
    }


}
