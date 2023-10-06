//package com.picky.business.configure;
//
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.data.redis.connection.RedisConnectionFactory;
//import org.springframework.data.redis.connection.RedisNode;
//import org.springframework.data.redis.connection.RedisSentinelConfiguration;
//import org.springframework.data.redis.connection.RedisStandaloneConfiguration;
//import org.springframework.data.redis.connection.lettuce.LettuceConnectionFactory;
//import org.springframework.data.redis.core.RedisTemplate;
//import org.springframework.data.redis.repository.configuration.EnableRedisRepositories;
//import org.springframework.data.redis.serializer.StringRedisSerializer;
//
//import java.util.HashSet;
//import java.util.List;
//import java.util.Set;
//import java.util.stream.Collectors;
//
//@Configuration
//@EnableRedisRepositories
//public class RedisUtil {
//    @Value("${spring.redis.host}")
//    private String redisHost;
//
//    @Value("${spring.redis.port}")
//    private int redisPort;
//
//    @Value("${spring.redis.sentinel.master}")
//    private String sentinelMaster;
//
//    @Value("${spring.redis.sentinel.nodes}")
//    private List<String> sentinelNodes;
//
//    @Bean(name = "redisConnectionFactory")
//    public RedisConnectionFactory redisConnectionFactory() {
//        LettuceConnectionFactory lettuceConnectionFactory;
//
//        if (sentinelMaster != null && !sentinelNodes.isEmpty()) {
//            RedisSentinelConfiguration sentinelConfig = new RedisSentinelConfiguration(sentinelMaster, new HashSet<>(sentinelNodes));
//            lettuceConnectionFactory = new LettuceConnectionFactory(sentinelConfig);
//        } else {
//            lettuceConnectionFactory = new LettuceConnectionFactory(new RedisStandaloneConfiguration(redisHost, redisPort));
//        }
//
//        return lettuceConnectionFactory;
//    }
//
//    @Bean(name = "redisTemplate")
//    public RedisTemplate<String, Object> redisTemplate() {
//        RedisTemplate<String, Object> redisTemplate = new RedisTemplate<>();
//        redisTemplate.setConnectionFactory(this.redisConnectionFactory());
//        redisTemplate.setKeySerializer(new StringRedisSerializer());
//        redisTemplate.setHashKeySerializer(new StringRedisSerializer());
//        redisTemplate.setHashValueSerializer(new StringRedisSerializer());
//        redisTemplate.setValueSerializer(new StringRedisSerializer());
//        return redisTemplate;
//    }
//
//    private Set<RedisNode> createSentinels(List<String> nodes) {
//        return nodes.stream()
//                .map(node -> node.split(":"))
//                .filter(parts -> parts.length == 2)
//                .map(parts -> new RedisNode(parts[0], Integer.parseInt(parts[1])))
//                .collect(Collectors.toSet());
//    }
//
//
//}
