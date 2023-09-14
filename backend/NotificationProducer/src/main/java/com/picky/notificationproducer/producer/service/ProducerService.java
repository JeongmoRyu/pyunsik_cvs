package com.picky.notificationproducer.producer.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

@Service
@Slf4j
@RequiredArgsConstructor
public class ProducerService {

    private final KafkaTemplate<String, Object> kafkaTemplate;

    /**
     * [sendMessage]
     * 메세지 전송 - 비동기
     * CompletableFuture Object 반환 - 작업의 완료 여부, 결과 추적 가능
     */
    public void sendMessage(Object object, String topic) {
        log.info("[ProducerService] received message : {}", object);
        kafkaTemplate.send(topic, object);
    }
}
