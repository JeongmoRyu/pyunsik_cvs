package com.picky.notificationconsumer.fcm.config;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.messaging.FirebaseMessaging;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@Configuration
public class FCMConfig {

    /**
     * [Firebase Admin SDK 초기화]
     * FCM Backend 서버와 통신을 위한 앱 서버 옵션
     * 기기에서 주제 구독 및 구독 취소가 가능
     * 다양한 타켓 플랫폼에 맞는 메세지 페이로드 구성
     * 초기화 작업만 잘 진행하면 인증 처리를 자동으로 수행
     */
    @Bean
    FirebaseMessaging firebaseMessaging() throws IOException {
        // firebase admin sdk 비공개 키 읽어오기
        ClassPathResource resource = new ClassPathResource("firebase/picky-c7383-firebase-adminsdk-dfu39-6b9d9837b6.json");
        InputStream refreshToken = resource.getInputStream();

        FirebaseApp firebaseApp = null;
        List<FirebaseApp> firebaseAppList = FirebaseApp.getApps();

        // initializeApp 중복 방지, 이미 init 되어 있는 경우 기존의 app 사용
        if (firebaseAppList != null && !firebaseAppList.isEmpty()) {
            for (FirebaseApp app : firebaseAppList) {
                if (app.getName().equals(FirebaseApp.DEFAULT_APP_NAME)) {
                    firebaseApp = app;
                }
            }
        } else {
            // 옵션 설정
            FirebaseOptions options = FirebaseOptions.builder()
                    .setCredentials(GoogleCredentials.fromStream(refreshToken))
                    .build();
            // 초기화
            firebaseApp = FirebaseApp.initializeApp(options);
        }
        return FirebaseMessaging.getInstance(firebaseApp);
    }

}
