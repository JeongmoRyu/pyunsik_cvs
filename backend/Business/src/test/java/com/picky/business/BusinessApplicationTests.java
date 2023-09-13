package com.picky.business;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.RedisTemplate;

import static org.junit.jupiter.api.Assertions.assertNotNull;

@SpringBootTest
class BusinessApplicationTests {
    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    @Test
    public void testConnection() {
        redisTemplate.opsForValue().set("myKey1", "myValue123");
        Object value = redisTemplate.opsForValue().get("myKey1");
        System.out.println(value);
        assertNotNull(redisTemplate.getConnectionFactory());
    }


}
