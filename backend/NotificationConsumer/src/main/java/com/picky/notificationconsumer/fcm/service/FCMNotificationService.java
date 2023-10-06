package com.picky.notificationconsumer.fcm.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.common.net.HttpHeaders;
import com.picky.notificationconsumer.fcm.domain.entity.FcmMessage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import okhttp3.*;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class FCMNotificationService {

    private static final String API_URL = "https://fcm.googleapis.com/v1/projects/a5052-59303/messages:send";
    private final ObjectMapper objectMapper;

    public void sendNotificationByFCMToken(List<String> userFCMTokenList) {

        for (String userFCMToken : userFCMTokenList) {
            if (userFCMToken != null) {
                try {
                    String body = String.valueOf(LocalDateTime.now().getMonth().getValue()) + "월의 새로운 할인정보를 확인하세요.";
                    sendMessageTo(userFCMToken, "편식타임!", body);
                } catch (Exception e) {
                    log.info("[sendNotificationByFCMToken] error: " + e.getMessage());
                }
            } else {
                log.info("[sendNotificationByFCMToken] 유저의 FCMToken이 없습니다.");
            }
        }
    }

    public void sendMessageTo(String targetToken, String title, String body) throws IOException {

        String message = makeMessage(targetToken, title, body);
        OkHttpClient client = new OkHttpClient();
        RequestBody requestBody = RequestBody.create(message, MediaType.get("application/json; charset=utf-8"));
        Request request = new Request.Builder()
                .url(API_URL)
                .post(requestBody)
                .addHeader(HttpHeaders.AUTHORIZATION, "Bearer " + getAccessToken())
                .addHeader(HttpHeaders.CONTENT_TYPE, "application/json; UTF-8")
                .build();
        Response response = client.newCall(request)
                .execute();

        // HTTP 응답 코드 확인
        if (response.isSuccessful()) {
            log.info("[sendNotificationByFCMToken] 알림을 성공적으로 전송했습니다. targetUserFCMToken: " + targetToken);
        } else {
            log.error("[sendNotificationByFCMToken] 알림 전송에 실패했습니다. targetUserFCMToken: " + targetToken);
        }
    }

    private String makeMessage(String targetToken, String title, String body) throws JsonProcessingException {
        FcmMessage fcmMessage = FcmMessage.builder()
                .message(FcmMessage.Message.builder()
                        .token(targetToken)
                        .notification(FcmMessage.Notification.builder()
                                .title(title)
                                .body(body)
                                .image(null)
                                .build()
                        )
                        .build()
                )
                .validateOnly(false)
                .build();
        return objectMapper.writeValueAsString(fcmMessage);
    }

    private String getAccessToken() throws IOException {
        String firebaseConfigPath = "firebase/a505_fcm_sdk.json";
        GoogleCredentials googleCredentials = GoogleCredentials
                .fromStream(new ClassPathResource(firebaseConfigPath).getInputStream())
                .createScoped(List.of("https://www.googleapis.com/auth/cloud-platform"));
        googleCredentials.refreshIfExpired();
        return googleCredentials.getAccessToken().getTokenValue();
    }

}
