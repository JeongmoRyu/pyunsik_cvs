package com.picky.business.favorite.controller;

import com.picky.business.favorite.dto.FavoriteListResponse;
import com.picky.business.favorite.service.FavoriteService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(value = "/api/favorite")
@RequiredArgsConstructor
@Slf4j
@CrossOrigin(origins = "*")
public class FavoriteController {
    private final FavoriteService favoriteService;
    private String accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZWEzYzIyNC0xMWMzLTRiNjItOTc4OS04ZDYzNmJjOGYyNTMiLCJyb2xlcyI6WyJST0xFX0NPTlNVTUVSIl0sImlhdCI6MTY5NTAxMDAyMywiZXhwIjoxNjk3NjAyMDIzfQ.h6wNgzVTjFYUGnf0HYZFIaOY8caoTEFCPnp7GcZ_hZ8";

    @GetMapping
    public ResponseEntity<List<FavoriteListResponse>> getFavoriteList(@RequestHeader("Authorization") String accessToken) {
        return ResponseEntity.status(HttpStatus.OK).body(favoriteService.getFavoriteList(accessToken));

    }

    @PostMapping(value = "/{productId}")
    public ResponseEntity<String> addFavorite(@PathVariable Long productId, @RequestHeader("Authorization") String accessToken) {
        favoriteService.addFavorite(accessToken, productId);
        return ResponseEntity.status(HttpStatus.CREATED).body("즐겨찾기 등록 완료");
    }

    @DeleteMapping(value = "/{productId}")
    public ResponseEntity<String> deleteFavorite(@PathVariable Long productId, @RequestHeader("Authorization") String accessToken) {
        favoriteService.deleteFavorite(accessToken, productId);
        return ResponseEntity.status(HttpStatus.CREATED).body("즐겨찾기 해제 완료");
    }

}
