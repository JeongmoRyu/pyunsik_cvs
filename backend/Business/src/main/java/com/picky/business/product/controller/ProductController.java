package com.picky.business.product.controller;

import com.picky.business.common.service.RedisService;
import com.picky.business.product.dto.*;
import com.picky.business.product.service.CommentService;
import com.picky.business.product.service.ProductService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping(value = "/api/product")
@RequiredArgsConstructor
@Slf4j
@CrossOrigin(origins = "*")
public class ProductController {

    private final ProductService productService;
    private final CommentService commentService;
    private final RedisService redisService;


    @GetMapping
    public ResponseEntity<List<ProductPreviewResponse>> getProductByQuery(
            @RequestParam(required = false) String category,
            @RequestParam(required = false) List<Integer> price,
            @RequestParam(required = false) List<Integer> carb,
            @RequestParam(required = false) List<Integer> protein,
            @RequestParam(required = false) List<Integer> fat,
            @RequestParam(required = false) List<Integer> sodium,
            @RequestParam(required = false) List<Integer> convenienceCodes,
            @RequestParam(required = false) List<Integer> promotionCodes,
            @RequestHeader("Authorization") String accessToken) {
        return ResponseEntity.status(HttpStatus.OK).body(productService.searchProductByQuery(category, price, carb, protein, fat, sodium,
                convenienceCodes, promotionCodes, accessToken));
    }

    @GetMapping(value = "/search")
    public ResponseEntity<List<ProductPreviewResponse>> getProductByKeyword(@RequestHeader("Authorization") String accessToken, @RequestParam String keyword) {
        return ResponseEntity.status(HttpStatus.OK).body(productService.searchProductByKeyword(keyword, accessToken));
    }

    @GetMapping(value = "/{productId}")
    public ResponseEntity<ProductDetailResponse> productDetailsByProductId(
            @PathVariable Long productId, @RequestHeader("Authorization") String accessToken) {
        return ResponseEntity.status(HttpStatus.OK).body(productService.findProductByProductId(productId, accessToken));
    }

    @PostMapping
    public ResponseEntity<String> addProduct(@RequestBody ProductRegistRequest request) {
        productService.addProduct(request);
        return ResponseEntity.status(HttpStatus.CREATED).body("상품등록 완료");
    }

    @PatchMapping(value = "/{productId}")
    public ResponseEntity<String> updateProduct(@PathVariable Long productId, @RequestBody ProductUpdateRequest request) {
        productService.updateProduct(productId, request);
        return ResponseEntity.status(HttpStatus.CREATED).body("상품 수정 완료");
    }

    @DeleteMapping(value = "/{productId}")
    public ResponseEntity<String> deleteProduct(@PathVariable Long productId) {
        productService.deleteProduct(productId);
        return ResponseEntity.status(HttpStatus.CREATED).body("상품 삭제 완료");
    }

    @PostMapping(value = "/comment/{productId}")
    public ResponseEntity<String> addComment(@PathVariable Long productId, @RequestHeader("Authorization") String accessToken, @RequestBody CommentWriteRequest request) {
        commentService.addComment(productId, request, accessToken);
        return ResponseEntity.status(HttpStatus.CREATED).body(productId + ":" + request.getContent() + " 댓글 등록 완료");
    }

    @PatchMapping(value = "/comment/{commentId}")
    public ResponseEntity<String> updateProduct(@PathVariable Long productId, @PathVariable Long commentId, @RequestHeader("Authorization") String accessToken, @RequestBody CommentUpdateRequest request) {
        commentService.updateComment(productId, commentId, request, accessToken);
        return ResponseEntity.status(HttpStatus.CREATED).body("댓글 수정 완료");
    }

    @DeleteMapping(value = "/comment/{commentId}")
    public ResponseEntity<String> deleteComment(@PathVariable Long commentId, @RequestHeader("Authorization") String accessToken) {
        //TODO 댓글 작성자 userId와 삭제하려는 사람 userID 일치하는지 로직 필요
        commentService.deleteComment(commentId, accessToken);
        return ResponseEntity.status(HttpStatus.CREATED).body("댓글 삭제 완료");
    }

    //인기검색어
    @GetMapping("/keyword-ranking")
    public ResponseEntity<Map<String, List<Map<String, String>>>> getKeywordRanking() {
        return ResponseEntity.status(HttpStatus.OK).body(redisService.getKeywordRanking());
    }


}
