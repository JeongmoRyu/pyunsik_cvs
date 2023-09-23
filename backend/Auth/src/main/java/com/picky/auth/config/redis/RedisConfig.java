package com.picky.auth.config.redis;

import lombok.RequiredArgsConstructor;
import org.springframework.boot.autoconfigure.data.redis.RedisProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.connection.RedisSentinelConfiguration;
import org.springframework.data.redis.connection.lettuce.LettuceConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.listener.RedisMessageListenerContainer;
import org.springframework.data.redis.serializer.StringRedisSerializer;

@Configuration
@RequiredArgsConstructor
public class RedisConfig {

    private final RedisProperties redisProperties;
    /*
     * [RedisConnectionFactory 인터페이스]
     * Redis 저장소와 연결
     * LettuceConnectionFactory를 생성하여 반환
     * 새로운 Connection이나 이미 존재하는 Connection 리턴
     */
    @Bean
    public RedisConnectionFactory redisConnectionFactory() {
        RedisSentinelConfiguration sentinelConfig = new RedisSentinelConfiguration()
                .master(redisProperties.getSentinel().getMaster());

        redisProperties.getSentinel().getNodes().forEach(s -> sentinelConfig.sentinel(s.split(":")[0],
                Integer.valueOf(s.split(":")[1])));

        return new LettuceConnectionFactory(sentinelConfig);
    }

    /*
     * [RedisTemplate bean]
     * RedisTemplate: java Object를 redis에 저장하는 경우 사용
     */
    @Primary
    @Bean
    public RedisTemplate<String, String> redisTokenTemplate() {
        RedisTemplate<String, String> redisTemplate = new RedisTemplate<>();
        redisTemplate.setConnectionFactory(redisConnectionFactory());
        // RedisTemplate 사용 시 Spring <-> Redis간 데이터 직렬화, 역직렬화에 사용하는 방식이 Jdk 직렬화 방식이기 때문
        redisTemplate.setKeySerializer(new StringRedisSerializer());
        redisTemplate.setValueSerializer(new StringRedisSerializer());
        redisTemplate.setHashKeySerializer(new StringRedisSerializer());
        redisTemplate.setHashValueSerializer(new StringRedisSerializer());
        return redisTemplate;
    }


    /*
     * [RedisMessageListenerContainer]
     * JMS template과 함께 스프링에서 JMS 메시징을 사용하는 핵심 컴포넌트
     * MDP(message-driven POJO)를 사용하여 비동기 메시지를 받는데 사용
     * 메시지의 수신관점에서 볼 때 필요
     * MessageListener를 생성하는데 사용
     */
    @Bean
    RedisMessageListenerContainer redisContainer() {
        RedisMessageListenerContainer container = new RedisMessageListenerContainer();
        container.setConnectionFactory(redisConnectionFactory());
        return container;
    }
}
