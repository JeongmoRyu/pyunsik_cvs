package com.picky.notificationproducer.config;

import lombok.extern.slf4j.Slf4j;
import org.apache.kafka.clients.admin.AdminClientConfig;
import org.apache.kafka.clients.admin.NewTopic;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.kafka.core.KafkaAdmin;

import java.util.HashMap;
import java.util.Map;

@Configuration
@Slf4j
public class KafkaTopicConfig {

    @Value("${kafka.producer.bootstrap-servers}")
    private String bootstrapServers;

    /**
     * [kafkaAdmin]
     * NewTopic 타입의 빈들을 자동적으로 추가하기 위함
     */
    @Bean
    public KafkaAdmin kafkaAdmin() {
        Map<String, Object> configs = new HashMap<>();
        log.info("[kafkaAdmin] kafkaAdmin 생성 시작");
        configs.put(AdminClientConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrapServers);
        log.info("[kafkaAdmin] configs 설정 완료");
        return new KafkaAdmin(configs);
    }

    @Bean
    public NewTopic topic() {
        log.info("[topic] topic 생성 시작");
        return new NewTopic("Notification", 1, (short) 1);
    }
}
