package com.picky.notificationconsumer.fcm.service;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@Slf4j
public class FCMNotificationService {

    private final FirebaseMessaging firebaseMessaging;

    public FCMNotificationService(FirebaseMessaging firebaseMessaging) {
        this.firebaseMessaging = firebaseMessaging;
    }

    public void sendNotificationByFCMToken(Map<String, Object> notificationList) {

        for (Map.Entry<String, Object> userEntry : notificationList.entrySet()) {

            String userFCMToken = userEntry.getKey();
            Map<String, Object> userNotificationList = (Map<String, Object>) userEntry.getValue();

            for (Map.Entry<String, Object> brandEntry : userNotificationList.entrySet()) {
                Notification notification = Notification.builder()
                        .setTitle(brandEntry.getKey())
                        .setBody(brandEntry.getValue().toString())
                        .build();

                Message message = Message.builder()
                        .setToken(userFCMToken)
                        .setNotification(notification)
                        .build();

                try {
                    firebaseMessaging.send(message);
                    log.info("[sendNotificationByFCMToken] 알림을 성공적으로 전송했습니다. targetUserFCMToken: " + userFCMToken);
                } catch (FirebaseMessagingException e) {
                    e.printStackTrace();
                    log.info("[sendNotificationByFCMToken] 알림 전송에 실패했습니다. targetUserFCMToken: " + userFCMToken);
                }

            }
        }
    }
}
