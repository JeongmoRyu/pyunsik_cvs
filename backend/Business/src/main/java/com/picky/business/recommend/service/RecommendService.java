package com.picky.business.recommend.service;

import com.picky.business.product.domain.entity.Product;
import com.picky.business.product.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class RecommendService {
    private final ProductService productService;

    public List<Product> getProduct(List<Long> productId){
        return productId.stream()
                .map(productService::getProduct
                )
                .collect(Collectors.toList());
    }
}
