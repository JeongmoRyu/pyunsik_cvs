package com.picky.notificationconsumer.fcm.service;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Slf4j
public class FCMNotificationService {

    private final FirebaseMessaging firebaseMessaging;

    public FCMNotificationService(FirebaseMessaging firebaseMessaging) {
        this.firebaseMessaging = firebaseMessaging;
    }

    public void sendNotificationByFCMToken(HashMap<String, HashMap<String, List>> notificationList) {
        System.out.println("received message: " + notificationList);
        for (HashMap.Entry<String, HashMap<String, List>> userEntry : notificationList.entrySet()) {
            System.out.println("userEntry: " + userEntry);
            String userFCMToken = userEntry.getKey();
            HashMap<String, List> userNotificationList = userEntry.getValue();

            for (Map.Entry<String, List> brandEntry : userNotificationList.entrySet()) {
                System.out.println("brandEntry: " + brandEntry);
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
