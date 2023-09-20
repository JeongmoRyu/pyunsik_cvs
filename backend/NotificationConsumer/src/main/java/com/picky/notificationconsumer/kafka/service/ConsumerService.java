package com.picky.notificationconsumer.kafka.service;

import com.picky.notificationconsumer.fcm.service.FCMNotificationService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
@Slf4j
public class ConsumerService {

    private FCMNotificationService fcmNotificationService;
    /**
     * [listenGroupNotification]
     * config에 @EnableKafka가 붙은 경우 @KafkaListener 정상 작동
     * 지정한 토픽에 메세지가 발생할 경우 이를 수신
     * 메세지 필터 사용 시 containerFactory = "filterKafkaListenerContainerFactory" 파라미터 추가
     */
    @KafkaListener(topics = "Notification", groupId = "notification", containerFactory = "kafkaListenerContainerFactory")
    public void listenGroupNotification(Map<String, Object> notificationList) {
        log.info("[ConsumerService] Received Message in group notification: " + notificationList);
        fcmNotificationService.sendNotificationByFCMToken(notificationList);
    }
}
