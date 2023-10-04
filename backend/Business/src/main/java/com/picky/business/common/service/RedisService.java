package com.picky.business.common.service;

import com.picky.business.exception.NotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.core.type.TypeReference;

import java.util.List;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
public class RedisService {

    private final StringRedisTemplate stringRedisTemplate;

    //인기검색어 가져오기
    public Map<String, List<Map<String, String>>> getKeywordRanking() {
        String jsonStr = stringRedisTemplate.opsForValue().get("realtime_search_keywords");
        ObjectMapper objectMapper = new ObjectMapper();

        Map<String, List<Map<String, String>>> result;
        try {
            result = objectMapper.readValue(jsonStr, new TypeReference<>() {
            });
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            throw new NotFoundException("redis에 저장된 값이 없습니다.");
        }

        return result;
    }

    //카테고리별 인기상품
    public List<Long> getPopularProductsByCategory(int category) {
        String redisKey = "popular_products:" + category;
        String jsonStr = stringRedisTemplate.opsForValue().get(redisKey);

        if (jsonStr == null) {
            throw new NotFoundException("redis에 저장된 값이 없습니다");
        }

        ObjectMapper objectMapper = new ObjectMapper();
        List<Long> productIds;

        try {
            productIds = objectMapper.readValue(jsonStr, new TypeReference<>() {
            });
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            throw new NotFoundException("데이터 처리 오류");
        }

        return productIds;
    }
}
