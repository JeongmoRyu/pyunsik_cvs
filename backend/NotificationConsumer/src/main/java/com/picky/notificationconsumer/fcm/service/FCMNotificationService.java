package com.picky.notificationconsumer.fcm.service;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
@Slf4j
public class FCMNotificationService {

    private final FirebaseMessaging firebaseMessaging;

    public FCMNotificationService(FirebaseMessaging firebaseMessaging) {
        this.firebaseMessaging = firebaseMessaging;
    }

    /** 세부 내용 알람
    public void sendNotificationByFCMToken(HashMap<String, HashMap<String, List<String>>> notificationList) {
        for (HashMap.Entry<String, HashMap<String, List<String>>> userEntry : notificationList.entrySet()) {
            String userFCMToken = userEntry.getKey();
            HashMap<String, List<String>> userNotificationList = userEntry.getValue();

            for (HashMap.Entry<String, List<String>> brandEntry : userNotificationList.entrySet()) {
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
     */

    public void sendNotificationByFCMToken(List<String> userFCMTokenList) {

        for (String userFCMToken : userFCMTokenList) {
            Notification notification = Notification.builder()
                    .setTitle("Notification")
                    .setBody("이달의 할인 목록을 확인해보세요.")
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
